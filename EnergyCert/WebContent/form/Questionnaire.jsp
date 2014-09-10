<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.ResultSet,java.text.SimpleDateFormat;" %>

<%
String link = request.getParameter("link");
boolean fromLink = false;
//to know what sections to display if it is from link
String sections = "";
String quest_id = "";

if (link != null) { %>
	
	<% String where_link = "questionnaire_link = \'" + link + "\'";
	RetrievedObject ro_link = SQLManager.retrieveRecords("questionnaire_link", where_link);
	ResultSet rs_link = ro_link.getResultSet();
	while (rs_link.next()) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
		
		//link_timestamp in Calendar obj
		String link_timestamp = rs_link.getString("link_timestamp");
		Calendar cal_link  = Calendar.getInstance();
		cal_link.setTime(sdf.parse(link_timestamp));
		
		//current calendar
		Calendar cal_current  = Calendar.getInstance();
		
		//check if link has expired (if more than 3 days means expired)
		long diffMilliSec =  cal_current.getTimeInMillis() - cal_link.getTimeInMillis();
		long diffDays = diffMilliSec/(24 * 60 * 60 * 1000);
		
		if (diffDays > 3) { 
		%>
		    <jsp:forward page="ExpiredLink.jsp" ></jsp:forward>
		<% 
		} else {
			String q_id = rs_link.getString("questionnaire_id");
			session.setAttribute("quest_id", q_id);
			sections = rs_link.getString("sections");
			fromLink = true;
		}
	}
	ro_link.close();
	
} else { %>
	<%@include file="../protectusers.jsp" %>
<% }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../header.jsp" %>
	<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>GTL Energy Certificate Questionnaire</title>
		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		
		<%-- JQuery script --%>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		
		<%-- Questionnaire validation --%>
		<link rel="stylesheet" href="../css/bootstrap.css"/>
		<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	
		<script type="text/javascript" src="../js/validation.js"></script>	
		
		<%-- This is for SiteInfo.jsp --%>
		<link href="../css/siteInfo.css" rel="stylesheet">
		<script type="text/javascript" src="../js/siteInfo.js"></script>	
		<script type="text/javascript" src="../js/expand.js"></script>	
			
		<%-- Questionnaire.jsp --%>
		<link href="../css/questionnaire.css" rel="stylesheet">
		<script type="text/javascript" src="../js/questionnaire.js"></script>
		
		<%-- This is for SiteDef.jsp --%>
		<script type="text/javascript" src="../js/siteDef.js"></script>
	
</head>
<body>
	
		  
  	<br><br>
  	<div class="main">
		<div class="header">
            GTL Energy Certificate Questionnaire
        </div>
                
		<form id="master_form" action="processmaster" class="form-horizontal" method="post">
		
		<%-- Get previous year --%>
		<%int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;%>
		
		<%
		//initialise array to get values from SiteDef form
		String[] building_array = request.getParameterValues("building_name[]");
		String[] zone_name_array;
		String[] zone_type_array;
		String[] zone_heating_cooling_array;
		String[] zone_min_temp_array;
		String[] zone_max_temp_array;
		String[] zone_operation_array;
		
		ArrayList<String> zone_list = new ArrayList<String>();
		ArrayList<String> identifiers_list = new ArrayList<String>();
		
		
		int year = Calendar.getInstance().get(Calendar.YEAR); 
		
		//DB details
		String tableName = ""; 
		String values = "";
		
		//zone details to pass to process_master.jsp
		String zone_details = "";
		
		String fromEdit = request.getParameter("fromEdit");
		//if fromEdit is null AND fromLink is false means it's a new questionnaire		
		if (fromEdit == null && fromLink == false) {
			quest_id = (SQLManager.getRowCount("questionnaire") + 1) + "";
			
			//store in QUESTIONNAIRE table
			String values_quest = "";
			values_quest = values_quest + "\'" + quest_id  + "\',";
			values_quest = values_quest + "\'" + request.getParameter("site_id")  + "\',";
			values_quest = values_quest + "\'" + previousYear  + "\',";
			for (int i = 0; i < 76; i++) {
				values_quest = values_quest + "\'\',";
			}
			values_quest = values_quest + "0";
			values_quest = values_quest + ",\'\',\'\'";
			SQLManager.insertRecord("questionnaire",values_quest);
			
			if (session.getAttribute("fromLink") == null) {
				session.setAttribute("quest_id",quest_id);
			}
			
			//site_def_details and site_def_activity to store in SITE_DEFINITION table
			String site_def_details = "";
			String site_def_activity = "";
			String site_def_building_name = "";
	
			for (int i = 0; i < building_array.length; i++) {
				int num = i+1;
				zone_type_array = request.getParameterValues("b" + num + "_zone_activity[]");
				zone_name_array = request.getParameterValues("b" + num + "_zone_name[]");
				zone_heating_cooling_array = request.getParameterValues("b" + num + "_zone_heating_cooling[]");	
				zone_min_temp_array = request.getParameterValues("b" + num + "_zone_min_temp[]");
				zone_max_temp_array = request.getParameterValues("b" + num + "_zone_max_temp[]");
				zone_operation_array = request.getParameterValues("b" + num + "_zone_operation[]");
				
				site_def_building_name = site_def_building_name + building_array[i] + "*";
				
				for (int j = 0; j < zone_type_array.length; j++) {
					String zone_type = zone_type_array[j];
					//add to zone_list
					String zone_element = building_array[i] + "," + zone_name_array[j] + "," + zone_type_array[j];
					zone_list.add(zone_element);
					
					//add to zone_details string
					zone_details = zone_details + zone_element + "//";
					
					//add to site_info_details string to store in SITE_DEFINITION DB
					site_def_details = site_def_details + quest_id + "-" + building_array[i] + "_" + zone_name_array[j] + "*";
					site_def_activity = site_def_activity + zone_type + "*";
				
					
					//add to DB
					values = "";
					values = values + "\'" + quest_id  + "\',";
					values = values + "\'" + quest_id + "-" + building_array[i] + "_" + zone_name_array[j]  + "\',";
					
					values = values + "\'" + (i+1)  + "\',";
					values = values + "\'" + (j+1)  + "\',";
					
					values = values + "\'" + building_array[i]  + "\',";
					values = values + "\'" + zone_name_array[j]  + "\',";
					values = values + "\'" + zone_type_array[j]  + "\',";
					values = values + "\'" + zone_heating_cooling_array[j]  + "\',";
					values = values + "\'" + zone_min_temp_array[j]  + "\',";
					values = values + "\'" + zone_max_temp_array[j]  + "\',";
					values = values + "\'" + zone_operation_array[j]  + "\'";
					
					
					if (zone_type.equals("wh_mezzanine")) {
						tableName = "mezzanine_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("wh_ground_to_roof")) {
						tableName = "ground_to_roof_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("wh_value_add")) {
						tableName = "warehouse_value_add_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("offices")) {
						tableName = "office_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					}
					
					SQLManager.insertRecord(tableName, values);
					
				}
				//delimit site_def_details and site_def_activity by ^ (to separate by buildings)
				site_def_details = site_def_details.substring(0,site_def_details.length()-1) + "^";
				site_def_activity = site_def_activity.substring(0,site_def_activity.length()-1) + "^";
			} 
			
			//store site_def_details and site_def_activity in SITE_DEFINITION table
			site_def_details = site_def_details.substring(0,site_def_details.length()-1);
			site_def_activity = site_def_activity.substring(0,site_def_activity.length()-1);
			site_def_building_name = site_def_building_name.substring(0,site_def_building_name.length()-1);
			String site_def_values = "\'" + quest_id + "\',\'" + site_def_details + "\',\'" + site_def_activity + "\',\'" + site_def_building_name + "\'";
			SQLManager.insertRecord("site_definition",site_def_values);
		
		//if fromEdit is not null OR fromLink is not null means need to put values from db for the saved questionnaire
		} else {
			if (!fromLink) {
				quest_id = request.getParameter("quest_id");
				session.setAttribute("quest_id",quest_id);	
			} else {
				quest_id = (String) session.getAttribute("quest_id");
			}
			
			String where = "questionnaire_id = \'" + quest_id + "\'";
			
			RetrievedObject site_def_ro = SQLManager.retrieveRecords("site_definition", where);
			ResultSet site_def_rs = site_def_ro.getResultSet();
			
			//store all the zones' building names and zone names
			ArrayList<String> building_zone_names_list = new ArrayList<String>();
			//store all the all zones' activities
			ArrayList<String> activity_list = new ArrayList<String>();
			
			while (site_def_rs.next()) {
				String site_def_info = site_def_rs.getString("site_def_info");
				String site_def_activity = site_def_rs.getString("site_def_activity");
				
				//use delimiter ^ to split by building
				String[] site_def_info_array = site_def_info.split("\\^");
				for (String def : site_def_info_array) {
					//use delimiter * to split each building into zones
					String[] def_array = def.split("\\*");
					for (String d : def_array) {
						String[] d_array = d.split("\\-");
						String[] building_zone_names = d_array[1].split("\\_");
						building_zone_names_list.add(building_zone_names[0] + "," + building_zone_names[1]);
					}
				}
				
				//use delimiter ^ to split by building
				String[] site_def_activity_array = site_def_activity.split("\\^");
				for (String act : site_def_activity_array) {
					//use delimiter * to split each building into zones
					String[] act_array = act.split("\\*");
					for (String a : act_array) {
						//add all zones to site_def_activity_list regardless of buildings
						activity_list.add(a);
					}
				}
				
				for (int i = 0; i < building_zone_names_list.size(); i++) {
					String building_zone_name = building_zone_names_list.get(i);
					String activity = activity_list.get(i);
					//prepare zone_list for including of form pages based on zone activity
					zone_list.add(building_zone_name + "," + activity);
					//prepare zone_details for process_master.jsp
					zone_details = zone_details + building_zone_name + "," + activity + "//";
				}
			}
			site_def_ro.close();
		}
		
		//set zone_details as a hidden field to pass to process_master.jsp 
		zone_details = zone_details.substring(0,zone_details.length()-2);
		%>
		<input type="hidden" name="zone_details" value="<%=zone_details%>" />
		<%-- Thread.sleep(10000); //QN: What is this thread sleep for?--%>
			<ul class="nav nav-tabs" role="tablist" id="myTab">
			  <li class="active"><a href="#sitedef" role="tab" data-toggle="tab">1. Site Definition</a></li>
			<%
			
			int tab_count = 2;
			
			if (!sections.equals("")) { 
				String[] sectionArray = sections.split("\\*");
				for (String sec : sectionArray) {
					if (sec.equals("a")) { 
			%>
						<li><a href="#siteinfo" role="tab" data-toggle="tab"><%=tab_count%>. Site Information</a></li>
			<% 	
						tab_count++;
					}
					if (sec.equals("b")) {
			%>
						<li><a href="#usage" role="tab" data-toggle="tab"><%=tab_count%>. Usage</a></li>
			<% 
						tab_count++;
					}
				}
			} else { %>
				<li><a href="#siteinfo" role="tab" data-toggle="tab"><%=tab_count%>. Site Information</a></li>
			<%
				tab_count++;
			%>	
				<li><a href="#usage" role="tab" data-toggle="tab"><%=tab_count%>. Usage</a></li>
			<%	
				tab_count++;
			}
			%>
			  
			<%
			if (!fromLink) {
				  for (int i = 0; i < zone_list.size(); i++) {
					String[] this_zone = zone_list.get(i).split(",");
					
					String building_name = this_zone[0];
					String zone_name = this_zone[1];
					
					String tab_title = tab_count + ". " + building_name + "_" + zone_name;
					String tab_id = building_name + "_" + zone_name;
			%>		
				<li><a href="#<%=tab_id%>" role="tab" data-toggle="tab"><%=tab_title%></a></li>
			<%		
				  	tab_count++;
				  }
			} else {
				if (!sections.equals("")) { 
					String[] sectionArray = sections.split("\\*");
					for (int i = 0; i < zone_list.size(); i++) {
						String[] this_zone = zone_list.get(i).split(",");
						
						String building_name = this_zone[0];
						String zone_name = this_zone[1];
						
						String tab_title = tab_count + ". " + building_name + "_" + zone_name;
						String tab_id = building_name + "_" + zone_name;
						for (String sec : sectionArray) {
							if (sec.equals(i+"")) {
						%>
								<li><a href="#<%=tab_id%>" role="tab" data-toggle="tab"><%=tab_title%></a></li>
						<%		
							}
						}
					}
				}
			}
			  %>
			</ul>
			
			<%-- Include SiteDef (fields disabled), SiteInfo and Usage parts in Questionnaire.jsp --%>
			
			<div class="tab-content">
				<div class="tab-pane active" id="sitedef"><%@include file="SiteDef.jsp" %></div>
			<%-- 
			<% 
			if (!sections.equals("")) { 
				String[] sectionArray = sections.split("\\*");
				for (String sec : sectionArray) {
					if (sec.equals("a")) { 
			%>
						<div class="tab-pane" id="siteinfo"><%@include file="SiteInfo.jsp" %></div>	
			<% 	
					}
					if (sec.equals("b")) {
			%>
						<div class="tab-pane" id="usage"><%@include file="Usage.jsp" %></div>
			<% 
					}
				}
			} else { 
			%>
			--%>
				<div class="tab-pane" id="siteinfo"><%@include file="SiteInfo.jsp" %></div>	
				<div class="tab-pane" id="usage"><%@include file="Usage.jsp" %></div>
			<%	
			//}
			%>
			  
			  <%
				//if (!fromLink) {
			  
					for (int i = 0; i < zone_list.size(); i++) {
						String[] this_zone = zone_list.get(i).split(",");
						
						String building_name = this_zone[0];
						String zone_name = this_zone[1];
						String zone_type = this_zone[2];
						
						String tab_id = building_name + "_" + zone_name;
						
						session.setAttribute("building_name",building_name);
						session.setAttribute("zone_name",zone_name);
						
						if (!zone_type.isEmpty()){
							if (zone_type.equals("wh_mezzanine")){
								%>
									<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Mezzanine_Form.jsp" %></div>
								<%
								
							} else if (zone_type.equals("wh_ground_to_roof")){
								%>
									<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Ground_Roof_Form.jsp" %></div>
								<%
								
							} else if (zone_type.equals("wh_value_add")){
								%>
									<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Warehouse_Value_Add _Form.jsp" %></div>
								<%
								
							} else if (zone_type.equals("offices")){
								%>
									<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Office_Form.jsp" %></div>
								<%					
							}
						}
					}
				/*} else {
					if (!sections.equals("")) { 
						String[] sectionArray = sections.split("\\*");
						for (int i = 0; i < zone_list.size(); i++) {
							String[] this_zone = zone_list.get(i).split(",");
							
							for (String sec : sectionArray) {
								if (sec.equals(i+"")) {
									String building_name = this_zone[0];
									String zone_name = this_zone[1];
									String zone_type = this_zone[2];
									
									String tab_id = building_name + "_" + zone_name;
									
									session.setAttribute("building_name",building_name);
									session.setAttribute("zone_name",zone_name);
									
									if (!zone_type.isEmpty()){
										if (zone_type.equals("wh_mezzanine")){
											%>
												<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Mezzanine_Form.jsp" %></div>
											<%
											
										} else if (zone_type.equals("wh_ground_to_roof")){
											%>
												<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Ground_Roof_Form.jsp" %></div>
											<%
											
										} else if (zone_type.equals("wh_value_add")){
											%>
												<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Warehouse_Value_Add _Form.jsp" %></div>
											<%
											
										} else if (zone_type.equals("offices")){
											%>
												<div class="tab-pane" id="<%=tab_id%>"><%@include file="Zone_Office_Form.jsp" %></div>
											<%					
										}
									}	
								}
							}
						}
					}
				}*/
			%>
  
			</div>
			
			<script>
			  $(function () {
			    $('#myTab a:first').tab('show')
			  })
			</script>
			
			
		<script>
		var $tabs = $('#myTab li');

		function prev_tab(){
		    $tabs.filter('.active').prev('li').find('a[data-toggle="tab"]').tab('show');
		};
		
		function next_tab() {
		    $tabs.filter('.active').next('li').find('a[data-toggle="tab"]').tab('show');
		};
		</script>
		
			<br>
			
			<%-- If it is from EditQuestionnaire.jsp, update records instead of insert records --%>
			<input type="hidden" name="fromEdit" value="true" /> 
			
			
			<div>
		        <div class="col-md-offset-9">
		            <% if (!fromLink) {%>
		            <button type="submit" class="btn btn-primary" name="action" value="submit">Submit Questionnaire</button>
					<% } %>
				</div>
				<br><br>
			</div>
			<div class="navigation" style="position:fixed; right:100px; top:70px;">
			    <button type="submit" class="btn btn-info" value="save" onclick="saveFunction()">Save and Exit</button>
			</div>
		</form>
	</div>
	
	<% if (!fromLink) {%>
		<div class="navigation" style="position:fixed; right:100px; top:115px;">
			<button class="btn btn-info" data-toggle="modal" data-target="#assignModal">Assign Questions</button>
		    <%-- <a data-toggle="modal" data-target="#assignModal">Assign Questions</a> --%>
		</div>
	<% } %>
	<%-- Modal for Assign Questions --%>
	<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" style="left:0px">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                <h4 class="modal-title">Assign Questions</h4>
	            </div>
	
	            <div class="modal-body">
	                <!-- The form is placed inside the body of modal -->
	                <form name="assign-form" method="GET" action="processsendemail" class="form-horizontal" id="assign-form">
					    <div class="form-group">
					        <label class="col-md-5 control-label">Receiver's Name</label>
					        <div class="col-md-5">
					            <input type="text" class="form-control" name="receiver_name" />
					        </div>
					    </div>
					    <div class="form-group">
					        <label class="col-md-5 control-label">Receiver's Email</label>
					        <div class="col-md-5">
					            <input type="text" class="form-control" name="receiver_email" />
					        </div>
					    </div>
					    <div class="form-group">
					        <label class="col-md-5 control-label">Message to Receiver</label>
					        <div class="col-md-5">
					            <textarea class="form-control" name="message"></textarea>
					        </div>
					    </div>    
					    <div class="form-group">
							<label class="col-lg-5 control-label" for="sections_assigned">Sections Assigned</label>
							<div class="col-lg-6">
								<div class="checkbox">
									<label><input type="checkbox" name="sections_assigned" value="a" />Site Information</label><br>
									<label><input type="checkbox" name="sections_assigned" value="b" />Site Usage</label><br>
									<% 
									for (int i = 0; i < zone_list.size(); i++) {
										String[] this_zone = zone_list.get(i).split(",");
										
										String building_name = this_zone[0];
										String zone_name = this_zone[1];
										
										String tab_title = building_name + "_" + zone_name;
										
									%>
										<label><input type="checkbox" name="sections_assigned" value="<%=i%>" /><%=tab_title%></label><br>
									<%
									}
									%>
								</div>
							</div>
						</div>               
					    <div class="form-group">
					        <div class="col-md-5 col-md-offset-5">
					            <button type="submit" class="btn btn-primary">Send Email</button>
					        </div>
					    </div>
					    <div class="form-group">
					        <div class="col-md-5 col-md-offset-5">
					        	<div id="result"></div>
					        </div>
					    </div>
					</form>
	            </div>
	        </div>
	    </div>
	</div>	
</body>

	<script type="text/javascript">
	var form = $('#assign-form');
	form.submit(function () {
	 
	$.ajax({
	type: form.attr('method'),
	url: form.attr('action'),
	data: form.serialize(),
	success: function (data) {
	var result=data;
	$('#result').text(result);
	}
	});
	 
	return false;
	});
	
	</script>
</html>
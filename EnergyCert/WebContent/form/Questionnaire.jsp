<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.ResultSet,java.text.SimpleDateFormat,utility.*" %>

<%
String link = request.getParameter("link");
boolean fromLink = false;
//to know what sections to display if it is from link
String sections = "";
String quest_id = "";

if (link != null) {
	session.setAttribute("questionnaire_link", link);
	String where_link = "questionnaire_link = \'" + link + "\'";
	RetrievedObject ro_link = SQLManager.retrieveRecords("questionnaire_link", where_link);
	ResultSet rs_link = ro_link.getResultSet();
	if (!rs_link.isBeforeFirst() ) { %>
	    <jsp:forward page="BrokenLink.jsp" ></jsp:forward>
	<%
	}
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
		
		<!-- Support datetime picker plugin: http://eonasdan.github.io/bootstrap-datetimepicker/ -->
	    <link rel="stylesheet" href="../css/bootstrap3-datetimepicker.css"/>
	    <script type="text/javascript" src="../js/moments.min.js"></script>
	    <script type="text/javascript" src="../js/bootstrap3-datetimepicker.js"></script>
	
</head>
<script>
function validate() {
	var options = $('#master_form').bootstrapValidator('getOptions');
	$('#master_form').bootstrapValidator(options);
	$('#master_form').data('bootstrapValidator').validate();
}
</script>

<%
String fromEdit = request.getParameter("fromEdit");
String fromAddZone = (String) session.getAttribute("fromAddZone");
if (fromEdit != null || fromLink == true || fromAddZone != null) {
%>
<body onload="validate()">
<% }  else { %>	
<body>
<% } %>
	<%@include file="../header.jsp" %>
  	<br><br>
  	<div class="main">
		<div class="header">
            GTL Energy Certificate Questionnaire
        </div>
                
		<form id="master_form" method="post" class="form-horizontal">
		<%-- Get previous year --%>
		<%String company = (String) session.getAttribute("company");
		int month = PeriodManager.getMonthInt(company);
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.MONTH,month);
		cal.set(Calendar.DATE,1);
		Calendar today = Calendar.getInstance();
		int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
		if (today.before(cal)) {
			previousYear -= 1;
		}%>
		
		<%
		
		ArrayList<String> zone_list = new ArrayList<String>();
		ArrayList<String> identifiers_list = new ArrayList<String>();
		
		
		int year = Calendar.getInstance().get(Calendar.YEAR); 
	
		//zone details to pass to process_master.jsp
		String zone_details = "";
		
		if (fromAddZone != null) {
			session.removeAttribute("fromAddZone");
		}
		//if fromEdit is null AND fromLink is false means it's a new questionnaire		
		if (fromEdit == null && fromLink == false && fromAddZone == null) {
		
			zone_details = (String) session.getAttribute("zone_details");
			session.removeAttribute("zone_details");
			
			String zone_string = (String) session.getAttribute("zone_string");
			String[] zone_string_array = zone_string.split("//");
			for (String z : zone_string_array) {
				zone_list.add(z);
			}
		
		//if fromEdit is not null OR fromLink is not null means need to put values from db for the saved questionnaire
		} else {
			if (!fromLink && fromAddZone == null) {
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
			  <li class="active bv-tab-success"><a href="#sitedef" role="tab" data-toggle="tab">1. Site Definition <span class="glyphicon glyphicon-ok"></span></a></li>
			<%
			
			int tab_count = 2;
			
			if (!sections.equals("")) { 
				String[] sectionArray = sections.split("\\*");
				for (String sec : sectionArray) {
					if (sec.equals("a")) { 
			%>
						<li class="bv-tab-error"><a href="#siteinfo" role="tab" data-toggle="tab"><%=tab_count%>. Site Information <span class="glyphicon glyphicon-remove"></span></a></li>
			<% 	
						tab_count++;
					}
					if (sec.equals("b")) {
			%>
						<li class="bv-tab-error"><a href="#usage" role="tab" data-toggle="tab"><%=tab_count%>. Usage <span class="glyphicon glyphicon-remove"></span></a></li>
			<% 
						tab_count++;
					}
				}
			} else { %>
				<li class="bv-tab-error"><a href="#siteinfo" role="tab" data-toggle="tab"><%=tab_count%>. Site Information <span class="glyphicon glyphicon-remove"></span></a></li>
			<%
				tab_count++;
			%>	
				<li class="bv-tab-error"><a href="#usage" role="tab" data-toggle="tab"><%=tab_count%>. Usage <span class="glyphicon glyphicon-remove"></span></a></li>
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
				<li class="bv-tab-error"><a href="#<%=tab_id%>" role="tab" data-toggle="tab"><%=tab_title%> <span class="glyphicon glyphicon-remove"></span></a></li>
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
								<li class="bv-tab-error"><a href="#<%=tab_id%>" role="tab" data-toggle="tab"><%=tab_title%> <span class="glyphicon glyphicon-remove"></span></a></li>
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
						if (i==zone_list.size()-1) {
							session.setAttribute("last_tab","true");
						}
						
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
		            <button type="submit" class="btn btn-primary" name="action" value="submit" onclick="submitFunction()">Submit Questionnaire</button>
					<% } %>
				</div>
				<br><br>
			</div>
			<div class="navigation" style="position:fixed; right:100px; top:70px;">
			    <button type="submit" class="btn btn-info" value="save" onclick="saveFunction()"><span class="glyphicon glyphicon-floppy-save"></span> Save and Exit</button>
			</div>
		</form>
	</div>
	
	<% if (!fromLink) {%>
		<div class="navigation" style="position:fixed; right:100px; top:115px;">
			<button class="btn btn-info" data-toggle="modal" data-target="#assignModal"><span class="glyphicon glyphicon-envelope"></span> Assign Questions</button>
		    <%-- <a data-toggle="modal" data-target="#assignModal">Assign Questions</a> --%>
		</div>
	<% } %>
	
	<%@include file="modals.jsp" %>
		
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
<%@page import="java.util.*,db.*,utility.*,java.sql.*,java.text.*" %>
<%@include file="../protectusers.jsp"%>

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
		
		<link rel="stylesheet" type="text/css" href="../css/payback_stylesheet.css"> 
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		<script type="text/javascript" src="../js/Chart.js"></script>
		
		<%-- This is for Payback --%>
		<link rel="stylesheet" type="text/css" href="../css/payback_form.css"> 
		<script type="text/javascript" src="../js/payback_form.js"></script>	
		
		<%
		HashMap<String, ArrayList<String>> paybackMap = (HashMap<String,ArrayList<String>>) request.getAttribute("paybackMap");
		
		Set<String> keySet = new HashSet<String>();
		String[] arr = {};
		if(paybackMap!=null) {
			keySet = paybackMap.keySet();
			String[] temp = {"192,262,63","82,225,203","255,26,0","110,16,232","2,213,255"};
			arr = temp;
		}
		%>

<% if (paybackMap!=null) { %>	
<script>

var radarChartData = {
	labels: ["IRR (%)", "Rating (% change)", "Lighting Output (% change)"],
	datasets: [
	           <%
	           int count = 0;
	            for(String key: keySet){
	            	ArrayList<String> list = paybackMap.get(key);
	           %>
	           
	           	{
	   			label: "<%= key%>",
	   			
	   			fillColor: "rgba(<%= arr[count] %>, 0.2)",
	   			strokeColor: "rgba(<%= arr[count] %>, 1)",
	   			pointColor: "rgba(<%= arr[count] %>, 1)",
	   			pointStrokeColor: "#fff",
	   			pointHighlightFill: "#fff",
	   			pointHighlightStroke: "rgba(<%= arr[count] %>, 1)",
	   			data: [<%=list.get(0)%>,<%=list.get(1)%>,<%=list.get(2)%>]
	   			},
	           
	           <%
	           count++;
	           } %>
	    
	]
};

function setSelectedIndex(s, valsearch)
{
// Loop through all the items in drop down list
for (i = 0; i< s.options.length; i++)
{ 
if (s.options[i].value == valsearch)
{
// Item is found. Set its property and exit
s.options[i].selected = true;
break;
}
}
return;
}

window.onload = function(){
	window.myRadar = new Chart(document.getElementById("canvas").getContext("2d")).Radar(radarChartData, {
		responsive: false,
	});
	var options = $('#payback_form').bootstrapValidator('getOptions');
	$('#payback_form').bootstrapValidator(options);
	$('#payback_form').data('bootstrapValidator').validate();
	
	var xmlhttp;    
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var res = xmlhttp.responseText;
		  var values = res.split(";");
		  var select = document.getElementById("zone_id"), option = null, next_desc = null;
		  var len = select.options.length;
		 
		  for (var i = 0; i < len; i++)
          {
              select.remove(0);
          }
	        
		  for(x in values) {
		        option = document.createElement("option");
		        next_desc = values[x];
		        option.value = next_desc.trim();
		        var temp = next_desc.split("//");
		        option.innerHTML = temp[0].trim();
		        select.appendChild(option);
		    }
	    }
	  }
	xmlhttp.open("GET","getzones.jsp?questionnaire_id="+"<%=session.getAttribute("selected_site_id")%>",true);
	xmlhttp.send();
	setTimeout(function() {
		setSelectedIndex(document.getElementById("zone_id"),"<%=session.getAttribute("selected_zone_id")%>");
	}, 500);
	
	$('html, body').animate({
        scrollTop: $("#main").offset().top
    }, 1000);
	
}


</script>

<% } %>

</head>
<body onload="validateFields()">
<%
Map<String,String[]> formulaHM = new HashMap<String,String[]>();
	HashMap<String,Integer> hm = PaybackFormulaManager.getFormulaHM();
	Iterator iter = hm.entrySet().iterator();
while (iter.hasNext()) {
    Map.Entry<String,Integer> pairs = (Map.Entry<String,Integer>)iter.next();
    String variable = pairs.getKey();
    Integer value = pairs.getValue();
    String[] temp = {"" + value};
    formulaHM.put(variable,temp);
}
%>	

<% String company = (String) session.getAttribute("company");
int month = PeriodManager.getMonthInt(company);
Calendar cal = Calendar.getInstance();
cal.set(Calendar.MONTH,month);
cal.set(Calendar.DATE,1);
Calendar today = Calendar.getInstance();
int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
if (today.before(cal)) {
	previousYear -= 1;
}
%>	 
		  
  	<br>
  	<div class="main">
		<div class="header">
		    Payback Analysis
		</div>
		
         <form id="payback_form" method="post" action="payback">
		
			<%
			String desc = (String) session.getAttribute("userdesc");
			String comp = (String) session.getAttribute("company");
			String type = (String) session.getAttribute("usertype");
			if (type.equals("Site")) {
				type = "site_info_name";
			} else if (type.equals("Country")) {
				type = "site_info_address_country";
			}

			String where = "company=\'"+ comp + "\' and " + type + "=\'" + desc + "\'";
			RetrievedObject ro = SQLManager.retrieveRecords("site", where); 
			ResultSet rs = ro.getResultSet();
			
			%>
			<div class="form-group" style="width:90%;padding-left:1em;">
				<div class="row">
					<div class="col-md-3 selectContainer">
						<label class="control-label">Site ID</label> <select
							class="form-control" name="site_id" id="site_id" onchange="showValues(this.value)" >
							<option value="">--Select one--</option>
							<%
							while (rs.next()) {
								where = "site_id=\'" + rs.getString("site_id") + "\' and year=" + previousYear + " and emission_electrical_use <> 0";
								RetrievedObject ro2 = SQLManager.retrieveRecords("questionnaire", where); 
								ResultSet rs2 = ro2.getResultSet();
								while (rs2.next()) {
								%>			
									<% if (rs2.getString("questionnaire_id").equals(request.getParameter("site_id"))) { %>
										<option value="<%=rs2.getString("questionnaire_id")%>" selected><%=rs2.getString("site_id")%></option>
									<% } else { %>
									<option value="<%=rs2.getString("questionnaire_id")%>"><%=rs2.getString("site_id")%></option>
									<% } 
								}
								ro2.close();
							} 
							ro.close();%>
						</select>
					</div>

					<div class="col-md-3 selectContainer">
						<label class="control-label">Zone ID</label> <select
							class="form-control" id="zone_id" name="zone_id">
							<% String zone_id = request.getParameter("zone_id"); 
							if (zone_id!=null) { 
								String[] temp = zone_id.split("//"); %>
								<option value="<%=zone_id %>" selected><%=temp[0] %></option>
							<% } else { %>
								<option value="">--Select a Site ID first--</option>
							<% } %>
						</select>
					</div>
				</div>
			</div>
			
			<hr>
			
			<div class="form-group" style="width:90%;padding-left:1em;">
				<div class="row">
					<div class="col-md-3">
		                <label class="control-label">Consumption of Electricity (kWh)</label>
		                <% if (request.getParameter("actual_consumption_electricity")!=null) { %>
		                	<input type="text" class="form-control" id="actual_consumption_electricity" name="actual_consumption_electricity" value="<%=request.getParameter("actual_consumption_electricity") %>" />
		                <% } else { %>
		                	<input type="text" class="form-control" id="actual_consumption_electricity" name="actual_consumption_electricity" />
		                <% } %>
		            </div>

					<div class="col-md-3">
		                <label class="control-label">$ / kWh</label>
		                <% if (request.getParameter("electricity_cost")!=null) { %>
		                	<input type="text" class="form-control" name="electricity_cost" value="<%=request.getParameter("electricity_cost") %>" />
		                <% } else { %>
		                	<input type="text" class="form-control" name="electricity_cost" />
		                <% } %>
		            </div>
		            
				</div>
			</div>
			
			<hr>
			
			<div class ="table_inline_flex">
			<div class="form-group" style="width:90%;padding-left:1em;">
				<div class="row">
					<div class="col-md-12">
			        <label class="control-label">Select Types of Lighting for Analysis</label><br>
			        <% String[] zoneList = request.getParameterValues("types[]");
			        HashMap<String,String> zoneMap = new HashMap<String,String>();
			        if (zoneList!=null) {
				        for (String zone: zoneList) {
				        	zoneMap.put(zone,"1");
				        }
			        }
			        %>
			            <div class="btn-group" data-toggle="buttons">
				            	<% if (zoneMap.get("t5")!=null) { %>
				                	<label class="btn btn-default active" id="t5_label" style="width:120px;">
				                		<input type="checkbox" name="types[]" id="t5" value="t5" onchange="updateTable()" checked />T5
				                <% } else { %>
				                	<label class="btn btn-default" id="t5_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="t5" value="t5" onchange="updateTable()" />T5
				                <% } %>
				                </label>
				                <% if (zoneMap.get("t5_sensors")!=null) { %>
				                	<label class="btn btn-default active" id="t5_sensors_label" style="width:120px;">
				                		<input type="checkbox" name="types[]" id="t5_sensors" value="t5_sensors" onchange="updateTable()" checked />T5 with sensors
				                <% } else { %>
				                	<label class="btn btn-default" id="t5_sensors_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="t5_sensors" value="t5_sensors" onchange="updateTable()" />T5 with sensors
				                <% } %>
				                </label>
				                <% if (zoneMap.get("t8")!=null) { %>
				                	<label class="btn btn-default active" id="t8_label" style="width:120px;">
				                		<input type="checkbox" name="types[]" id="t8" value="t8" onchange="updateTable()" checked />T8
				                <% } else { %>
				                	<label class="btn btn-default" id="t8_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="t8" value="t8" onchange="updateTable()" />T8
				                <% } %>
				                </label>
				                 <% if (zoneMap.get("t8_sensors")!=null) { %>
				                	<label class="btn btn-default active" id="t8_sensors_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="t8_sensors" value="t8_sensors" onchange="updateTable()" checked />T8 with sensors
				                <% } else { %>
				                	<label class="btn btn-default" id="t8_sensors_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="t8_sensors" value="t8_sensors" onchange="updateTable()" />T8 with sensors
				                <% } %>
				                </label>
				                <% if (zoneMap.get("LED")!=null) { %>
				                	<label class="btn btn-default active" id="LED_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="LED" value="LED" onchange="updateTable()" checked />LED
				                <% } else { %>
				                	<label class="btn btn-default" id="LED_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="LED" value="LED" onchange="updateTable()" />LED
				                <% } %>
				                </label>
				                <% if (zoneMap.get("induction")!=null) { %>
				                	<label class="btn btn-default active" id="induction_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="induction" value="induction" onchange="updateTable()" checked />Induction
				                <% } else { %>
				                	<label class="btn btn-default" id="induction_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="induction" value="induction" onchange="updateTable()" />Induction
				                <% } %>
				                </label>
				                <% if (zoneMap.get("metal_halide")!=null) { %>
				                	<label class="btn btn-default active" id="metal_halide_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="metal_halide" value="metal_halide" onchange="updateTable()" checked />Metal Halide
				                <% } else { %>
				                	<label class="btn btn-default" id="metal_halide_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="metal_halide" value="metal_halide" onchange="updateTable()" />Metal Halide
				                <% } %>
				                </label>
				                <% if (zoneMap.get("CFL")!=null) { %>
				                	<label class="btn btn-default active" id="CFL_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="CFL" value="CFL" onchange="updateTable()" checked />CFL
				                <% } else { %>
				                	<label class="btn btn-default" id="CFL_label" style="width:120px;">
				                    	<input type="checkbox" name="types[]" id="CFL" value="CFL" onchange="updateTable()" />CFL
				                <% } %>
				                </label>
				         </div>			        
				 	</div>
				 	
			     </div>
			     </div>
			     <div style="padding-top:1.8em;">
		            <button id="add_new_button" type="button" class="btn btn-info" onclick="addNewType()"><span class="glyphicon glyphicon-plus-sign"></span>  Add new Type</button>      
				</div>
		    </div>
				
				<div id="max-alert" style="width: 35%; padding-left: 2em; display: none;" class="alert alert-danger" role="alert">
					A <b>maximum of 10</b> lighting types is allowed for analysis
				</div>	
										
				<div>
					<%-- Header --%>
					<div class ="table_inline_flex">
			            <div class="table_row_bold"></div>
			            <div class="table_row_bold">Number of <br>Fixtures</div>
			            <div class="table_row_bold">Lamp per Fixture</div>
			            <div class="table_row_bold">Power Rating (W)</div>
			            <div class="table_row_bold">Efficacy (lm/W)</div>
			            <div class="table_row_bold">Ballast Factor (%)</div>
			            <div class="table_row_bold">Ops Hours red. <br> (with sensors) (%)</div>
			            <div class="table_row_bold">Cost per Lamp</div>
			            <div class="table_row_bold">Installation Cost <br> per Fixture</div>
			            <div class="table_row_bold">Useful Life <br> (years)</div>
			            <div class="table_row_icon"></div>
			    	</div>
			    	
					
			    	<%-- 1st Row: Current --%>
			    	<% String zone = "current"; %>
			    	<div class ="table_inline_flex">
			            <div class="table_row_bold">Current</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="current_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control" />
									<% } else { %>
										<input name="current_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("current_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="current_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="current_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("current_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="current_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="current_power_rating" type="text" id="number" value="<%=formulaHM.get("current_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="current_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="current_efficacy" type="text" id="number" value="<%=formulaHM.get("current_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="current_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="current_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("current_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="current_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="current_op_hours" type="text" id="integer" value="<%=formulaHM.get("current_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
						</div>
						<div class="table_row">
						</div>	
						<div class="table_row">
						</div>	
			            <div class="table_row_icon">
						</div>
						
			            
			    	</div>
			    	
			    	<%-- 2nd Row: T5 --%>
			    	<% zone = "t5_sensors"; %>
			    	<% if (zoneMap.get("t5")!=null) { %>
			    	<div class ="table_inline_flex" id="t5_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="t5_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">T5</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="t5_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t5_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="t5_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t5_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="t5_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_power_rating" type="text" id="number" value="<%=formulaHM.get("t5_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="t5_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_efficacy" type="text" id="number" value="<%=formulaHM.get("t5_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="t5_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t5_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="t5_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_op_hours" type="text" id="integer" value="<%=formulaHM.get("t5_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="t5_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t5_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t5_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_installation_cost" type="text" id="number" value="<%=formulaHM.get("t5_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t5_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_useful_life" type="text" id="number" value="<%=formulaHM.get("t5_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="t5" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>	
			            
			    	</div>
			    	
			    	<%-- 3rd Row: T5 with sensors --%>
			    	<% if (zoneMap.get("t5_sensors")!=null) { %>
			    	<div class ="table_inline_flex" id="t5_sensors_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="t5_sensors_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">T5 with sensors</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="t5_sensors_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="t5_sensors_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="t5_sensors_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_power_rating" type="text" id="number" value="<%=formulaHM.get("t5_sensors_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="t5_sensors_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_efficacy" type="text" id="number" value="<%=formulaHM.get("t5_sensors_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="t5_sensors_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="t5_sensors_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_op_hours" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="t5_sensors_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t5_sensors_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t5_sensors_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_installation_cost" type="text" id="number" value="<%=formulaHM.get("t5_sensors_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t5_sensors_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="t5_sensors_useful_life" type="text" id="number" value="<%=formulaHM.get("t5_sensors_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="t5_sensors" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 4th Row: T8 --%>
			    	<% zone = "t8"; %>
			    	<% if (zoneMap.get("t8")!=null) { %>
			    	<div class ="table_inline_flex" id="t8_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="t8_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">T8</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="t8_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t8_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="t8_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t8_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="t8_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_power_rating" type="text" id="number" value="<%=formulaHM.get("t8_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="t8_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_efficacy" type="text" id="number" value="<%=formulaHM.get("t8_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="t8_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t8_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="t8_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_op_hours" type="text" id="integer" value="<%=formulaHM.get("t8_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="t8_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t8_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t8_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_installation_cost" type="text" id="number" value="<%=formulaHM.get("t8_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t8_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_useful_life" type="text" id="number" value="<%=formulaHM.get("t8_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="t8" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 5th Row: T8 with sensors --%>
			    	<% zone = "t8_sensors"; %>
			    	<% if (zoneMap.get("t8_sensors")!=null) { %>
			    	<div class ="table_inline_flex" id="t8_sensors_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="t8_sensors_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">T8 with sensors</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="t8_sensors_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="t8_sensors_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="t8_sensors_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_power_rating" type="text" id="number" value="<%=formulaHM.get("t8_sensors_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="t8_sensors_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_efficacy" type="text" id="number" value="<%=formulaHM.get("t8_sensors_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="t8_sensors_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="t8_sensors_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_op_hours" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="t8_sensors_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t8_sensors_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t8_sensors_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_installation_cost" type="text" id="number" value="<%=formulaHM.get("t8_sensors_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div> 
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="t8_sensors_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="t8_sensors_useful_life" type="text" id="number" value="<%=formulaHM.get("t8_sensors_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div> 
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="t8_sensors" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 6th Row: LED --%>
			    	<% zone = "LED" ;%>
			    	<% if (zoneMap.get("LED")!=null) { %>
			    	<div class ="table_inline_flex" id="LED_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="LED_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">LED</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="LED_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("LED_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="LED_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("LED_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="LED_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_power_rating" type="text" id="number" value="<%=formulaHM.get("LED_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="LED_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_efficacy" type="text" id="number" value="<%=formulaHM.get("LED_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="LED_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("LED_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="LED_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_op_hours" type="text" id="integer" value="<%=formulaHM.get("LED_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="LED_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_cost_lamp" type="text" id="number" value="<%=formulaHM.get("LED_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="LED_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_installation_cost" type="text" id="number" value="<%=formulaHM.get("LED_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="LED_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="LED_useful_life" type="text" id="number" value="<%=formulaHM.get("LED_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="LED" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 7th Row: Induction --%>
			    	<% zone = "induction"; %>
			    	<% if (zoneMap.get("induction")!=null) { %>
			    	<div class ="table_inline_flex" id="induction_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="induction_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">Induction</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="induction_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("induction_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="induction_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("induction_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="induction_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_power_rating" type="text" id="number" value="<%=formulaHM.get("induction_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="induction_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_efficacy" type="text" id="number" value="<%=formulaHM.get("induction_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="induction_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("induction_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="induction_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_op_hours" type="text" id="integer" value="<%=formulaHM.get("induction_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="induction_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_cost_lamp" type="text" id="number" value="<%=formulaHM.get("induction_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="induction_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_installation_cost" type="text" id="number" value="<%=formulaHM.get("induction_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="induction_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="induction_useful_life" type="text" id="number" value="<%=formulaHM.get("induction_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="induction" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 8th Row: Metal Halide --%>
			    	<% zone = "metal_halide"; %>
			    	<% if (zoneMap.get("metal_halide")!=null) { %>
			    	<div class ="table_inline_flex" id="metal_halide_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="metal_halide_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">Metal Halide</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="metal_halide_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("metal_halide_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="metal_halide_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("metal_halide_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="metal_halide_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_power_rating" type="text" id="number" value="<%=formulaHM.get("metal_halide_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="metal_halide_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_efficacy" type="text" id="number" value="<%=formulaHM.get("metal_halide_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="metal_halide_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("metal_halide_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="metal_halide_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_op_hours" type="text" id="integer" value="<%=formulaHM.get("metal_halide_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="metal_halide_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_cost_lamp" type="text" id="number" value="<%=formulaHM.get("metal_halide_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="metal_halide_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_installation_cost" type="text" id="number" value="<%=formulaHM.get("metal_halide_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="metal_halide_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="metal_halide_useful_life" type="text" id="number" value="<%=formulaHM.get("metal_halide_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="metal_halide" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>
			    	</div>
			    	
			    	<%-- 9th Row: CFL --%>
			    	<% zone = "CFL"; %>
			    	<% if (zoneMap.get("CFL")!=null) { %>
			    	<div class ="table_inline_flex" id="CFL_row">
			    	<% } else { %>
			    	<div class ="table_inline_flex" id="CFL_row" style="display: none;">
			    	<% } %>
			            <div class="table_row_bold">CFL</div>
			            						<div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_num_fixtures")!=null) { %>
										<input name="CFL_num_fixtures" type="text" id="integer" value="<%=request.getParameter(zone + "_num_fixtures") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("CFL_num_fixtures")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_lamp_fixture")!=null) { %>
										<input name="CFL_lamp_fixture" type="text" id="integer" value="<%=request.getParameter(zone + "_lamp_fixture") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("CFL_lamp_fixture")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_power_rating")!=null) { %>
										<input name="CFL_power_rating" type="text" id="number" value="<%=request.getParameter(zone + "_power_rating") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_power_rating" type="text" id="number" value="<%=formulaHM.get("CFL_power_rating")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_efficacy")!=null) { %>
										<input name="CFL_efficacy" type="text" id="number" value="<%=request.getParameter(zone + "_efficacy") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_efficacy" type="text" id="number" value="<%=formulaHM.get("CFL_efficacy")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_ballast_factor")!=null) { %>
										<input name="CFL_ballast_factor" type="text" id="integer" value="<%=request.getParameter(zone + "_ballast_factor") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("CFL_ballast_factor")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_op_hours")!=null) { %>
										<input name="CFL_op_hours" type="text" id="integer" value="<%=request.getParameter(zone + "_op_hours") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_op_hours" type="text" id="integer" value="<%=formulaHM.get("CFL_op_hours")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_cost_lamp")!=null) { %>
										<input name="CFL_cost_lamp" type="text" id="number" value="<%=request.getParameter(zone + "_cost_lamp") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_cost_lamp" type="text" id="number" value="<%=formulaHM.get("CFL_cost_lamp")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="CFL_installation_cost" type="text" id="number" value="<%=request.getParameter(zone + "_installation_cost") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_installation_cost" type="text" id="number" value="<%=formulaHM.get("CFL_installation_cost")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<% if (request.getParameter(zone + "_installation_cost")!=null) { %>
										<input name="CFL_useful_life" type="text" id="number" value="<%=request.getParameter(zone + "_useful_life") %>" class="form-control"/>
									<% } else { %>
										<input name="CFL_useful_life" type="text" id="number" value="<%=formulaHM.get("CFL_useful_life")[0] %>" class="form-control"/>
									<% } %>
								</div>	
							</div>
						</div>
						<div class="table_row_icon">
							<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img id="CFL" onclick="removeThis(this.id)" src="../icons/remove.png" width="50%"></a>
						</div>	
			    	</div>
			   </div>
			   
			   <%-- Append back the added rows after generating radar chart --%>
			   <% 
			   if (request.getParameterValues("lighting_type[]")!=null) { 
			   		String[] lighting_type_arr = request.getParameterValues("lighting_type[]");
			   		String[] num_fixtures_arr = request.getParameterValues("num_fixtures[]");
			   		String[] lamp_fixture_arr = request.getParameterValues("lamp_fixture[]");
			   		String[] power_rating_arr = request.getParameterValues("power_rating[]");
			   		String[] efficacy_arr = request.getParameterValues("efficacy[]");
			   		String[] ballast_factor_arr = request.getParameterValues("ballast_factor[]");
			   		String[] op_hours_arr = request.getParameterValues("op_hours[]");
			   		String[] cost_lamp_arr = request.getParameterValues("cost_lamp[]");
			   		String[] installation_cost_arr = request.getParameterValues("installation_cost[]");
			   		String[] useful_life_arr = request.getParameterValues("useful_life[]");
			   		
			   		for (int i = 0; i < lighting_type_arr.length; i++) { %>
			   		
			   			<div id='row_A<%=i%>' class ="table_inline_flex">
						    <div class="table_row">
				            	<div class="form-group">
									<div class="col-lg-12">
										<input name="lighting_type[]" type="text" value="<%=lighting_type_arr[i]%>" id="number" class="form-control"/>
									</div>	
								</div>
							</div>
		       				<div class="table_row">
				            	<div class="form-group">
									<div class="col-lg-12">
										<input name="num_fixtures[]" type="text" value="<%=num_fixtures_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="lamp_fixture[]" type="text" value="<%=lamp_fixture_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">	
							
								<div class="form-group">
									<div class="col-lg-12">
										<input name="power_rating[]" type="text" value="<%=power_rating_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="efficacy[]" type="text" value="<%=efficacy_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="ballast_factor[]" type="text" value="<%=ballast_factor_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="op_hours[]" type="text" value="<%=op_hours_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="cost_lamp[]" type="text" value="<%=cost_lamp_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="installation_cost[]" type="text" value="<%=installation_cost_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
							
							<div class="table_row">
								<div class="form-group">
									<div class="col-lg-12">
										<input name="useful_life[]" type="text" value="<%=useful_life_arr[i]%>" id="integer" class="form-control"/>
									</div>	
								</div>
							</div>
				    		
				    		<div class="table_row_icon">
								<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img onclick="removeRow(this.id)" id="A<%=i%>" src="../icons/remove.png" width="50%"></a>
							</div>	
					    </div>
			   			
			   <%
			   		}
			   }
			   %>
			   			   
			   <%-- Hidden row for cloning --%>
			   <div id='type_row' class ="table_inline_flex hide">
				    <div class="table_row">
		            	<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
       				<div class="table_row">
		            	<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">	
					
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
					
					<div class="table_row">
						<div class="form-group">
							<div class="col-lg-12">
								<input name="" type="text" value="" class="form-control"/>
							</div>	
						</div>
					</div>
		    		
		    		<div class="table_row_icon">
						<a href="#" data-toggle="tooltip" data-placement="bottom" title="remove for analysis"><img onclick="removeRow(this.id)" id="" src="../icons/remove.png" width="50%"></a>
					</div>	
			    </div>
			   
			<br>
      		<br>
	        <div class="col-md-offset-10">
	            <button type="submit" class="btn btn-primary" name="action" value="submit">Calculate Payback</button>
			</div>
			<br><br>
			</form>
	</div>
	
	
	<%-- Modal --%>
	<div class="modal fade" id="paybackModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" style="left:0px">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                <h4 class="modal-title">Payback Analysis</h4>
	            </div>
	
	            <div class="modal-body">
	                <!-- The form is placed inside the body of modal -->
					Please <b>complete Questionnaire and generate Energy Certificate</b> for <b>at least one Site</b> in order to proceed with Payback Analysis
	            </div>
	        </div>
	    </div>
	</div>	
	
	
<% if (paybackMap!=null) { %>
<div id="main">

<canvas id="canvas" width="600" height="600"></canvas>
<div class='my-legend'>
<div class='legend-title'>Legend</div>
<div class='legend-scale'>
  <ul class='legend-labels'>
  	<%
  	int count = 0;
	for(String key: keySet){
	%>
    <li><span style='background:rgba(<%= arr[count] %>,1);'></span><%=key %></li>
    <%
    count++;
    } 
    %>
  </ul>
</div>
<!-- <div class='legend-source'>Source: <a href="#link to source">Name of source</a></div> -->
  	<%
  	HashMap<String, ArrayList<String>> negativeMap = (HashMap<String,ArrayList<String>>) request.getAttribute("negativeMap");
  	if(negativeMap != null){
  		
  		Set<String> negativeKeys = negativeMap.keySet();
  	%>

<div class='legend-scale'>
  <ul class='legend-labels'>
  	<%
  	count = 0;
	for(String key: negativeKeys){
	%>
    <li>*<%=key %> is  undesirable as its values are significantly lower</li>
    <%
    count++;
    } 
    %>
  </ul>
</div>
<%} %>
</div>


<style type='text/css'>

.my-legend {
	float: right;
}


  .legend-title {
    text-align: left;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 90%;
    }
  .my-legend .legend-scale ul {
    margin: 0;
    margin-bottom: 5px;
    padding: 0;
    float: left;
    list-style: none;
    }
  .my-legend .legend-scale ul li {
    font-size: 80%;
    list-style: none;
    margin-left: 0;
    line-height: 18px;
    margin-bottom: 2px;
    }
  .my-legend ul.legend-labels li span {
    display: block;
    float: left;
    height: 16px;
    width: 30px;
    margin-right: 5px;
    margin-left: 0;
    border: 1px solid #999;
    }
  .my-legend .legend-source {
    font-size: 70%;
    color: #999;
    clear: both;
    }
  .my-legend a {
    color: #777;
    }
</style>


</div>

<% } %>
</body>
</html>
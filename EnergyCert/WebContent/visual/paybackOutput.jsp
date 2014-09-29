<%@page import="java.util.*,db.*,java.sql.ResultSet,utility.*;" %>

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
	
	<style type="text/css">
/* Adjust feedback icon position */
#payback_form .form-control-feedback {
    top: 25px;
    right: 15px;
}
#payback_form .selectContainer .form-control-feedback {
    top: 25px;
    right: 25px;
}
</style>

<script>
	function showValues(str)
	{
	var xmlhttp;    
	if (str=="")
	  {
		var select = document.getElementById("zone_id"), option = null;
		var len = select.options.length;
		for (var i = 0; i < len; i++)
        {
            select.remove(0);
        }
		option = document.createElement("option");
		option.value = ""
		option.innerHTML = "--Select a Site ID first--";
	    select.appendChild(option);
	    setTimeout(function() {
			$('#payback_form').bootstrapValidator('revalidateField', 'zone_id');
		}, 500);
	  return;
	  }
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
	xmlhttp.open("GET","getzones.jsp?questionnaire_id="+str,true);
	xmlhttp.send();
	setTimeout(function() {
		$('#payback_form').bootstrapValidator('revalidateField', 'zone_id');
	}, 500);
	}
	
	function validateFields() {
		$('#payback_form').bootstrapValidator('revalidateField', 'integer');
		$('#payback_form').bootstrapValidator('revalidateField', 'number');
		var len = document.getElementById("site_id").options.length;
	
		if (len == 1) {
			$('#paybackModal').modal('show');
		}
	}
	
	function updateTable() {
		var checkboxes = document.getElementsByName('types[]');
		var checkboxesChecked = [];
		 // loop over them all
		for (var i=0; i<checkboxes.length; i++) {
		    // And stick the checked ones onto an array...
		    var temp = checkboxes[i].value + '_row';
			if (checkboxes[i].checked) {
		    	document.getElementById(temp).style.display = "block";
		    	document.getElementById(temp).style.display = "inline-flex";
		    } else {
		    	document.getElementById(temp).style.display = "none";
		    }
		 }
		validateFields();
	}
	</script>

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
		  
  	<br><br>
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
					<div class="col-md-3 selectContainer" id="required">
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
									<option value="<%=rs2.getString("questionnaire_id")%>"><%=rs2.getString("site_id")%></option>
								<% } 
								ro2.close();
							} 
							ro.close();%>
						</select>
					</div>

					<div class="col-md-3 selectContainer" id="required">
						<label class="control-label">Zone ID</label> <select
							class="form-control" id="zone_id" name="zone_id">
							<option value="">--Select a Site ID first--</option>
						</select>
					</div>
				</div>
			</div>
			
			<hr>
			
			<div class="form-group" style="width:90%;padding-left:1em;">
				<div class="row">
					<div class="col-md-3">
		                <label class="control-label">Consumption of Electricity (kWh)</label>
		                <input type="text" class="form-control" id="actual_consumption_electricity" name="actual_consumption_electricity" />
		            </div>

					<div class="col-md-3">
		                <label class="control-label">$ / kWh</label>
		                <input type="text" class="form-control" name="electricity_cost" />
		            </div>
		            
				</div>
			</div>
			
			<hr>
			
			<div class="form-group" style="width:90%;padding-left:1em;">
				<div class="row">
					<div class="col-md-12">
			        <label class="control-label">Select Types of Lighting for Analysis</label><br>
			            <div class="btn-group" data-toggle="buttons">
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="t5" onchange="updateTable()" />T5
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="t5_sensors" onchange="updateTable()" />T5 with sensors
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="t8" onchange="updateTable()" />T8
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="t8_sensors" onchange="updateTable()" />T8 with sensors
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="LED" onchange="updateTable()">LED
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="induction" onchange="updateTable()">Induction
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="metal_halide" onchange="updateTable()">Metal Halide
			                </label>
			                <label class="btn btn-default" style="width:120px;">
			                    <input type="checkbox" name="types[]" value="CFL" onchange="updateTable()">CFL
			                </label>
			            </div>
			        </div>
			     </div>
		    </div>
													
				<div>
					<%-- Header --%>
					<div class ="table_inline_flex">
			            <div class="table_row_bold"></div>
			            <div class="table_row_bold">Number of Fixtures</div>
			            <div class="table_row_bold">Lamp per Fixture</div>
			            <div class="table_row_bold">Power Rating (W)</div>
			            <div class="table_row_bold">Efficacy (lm/W)</div>
			            <div class="table_row_bold">Ballast Factor (%)</div>
			            <div class="table_row_bold">Ops Hours red. (with sensors) (%)</div>
			            <div class="table_row_bold">Cost per Lamp</div>
			            <div class="table_row_bold">Installation Cost per Fixture</div>
			    	</div>
			    	
			    	<%-- 1st Row: Current --%>
			    	<div class ="table_inline_flex">
			            <div class="table_row_bold">Current</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="current_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("current_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="current_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("current_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="current_power_rating" type="text" id="number" value="<%=formulaHM.get("current_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="current_efficacy" type="text" id="number" value="<%=formulaHM.get("current_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="current_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("current_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="current_op_hours" type="text" id="integer" value="<%=formulaHM.get("current_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
						</div>
						<div class="table_row">
						</div>	
			            
			    	</div>
			    	
			    	<%-- 2nd Row: T5 --%>
			    	<div class ="table_inline_flex" id="t5_row" style="display: none;">
			            <div class="table_row_bold">T5</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t5_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t5_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_power_rating" type="text" id="number" value="<%=formulaHM.get("t5_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_efficacy" type="text" id="number" value="<%=formulaHM.get("t5_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t5_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_op_hours" type="text" id="integer" value="<%=formulaHM.get("t5_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t5_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_installation_cost" type="text" id="number" value="<%=formulaHM.get("t5_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	
			            
			    	</div>
			    	
			    	<%-- 3rd Row: T5 with sensors --%>
			    	<div class ="table_inline_flex" id="t5_sensors_row" style="display: none;">
			            <div class="table_row_bold">T5 with sensors</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_power_rating" type="text" id="number" value="<%=formulaHM.get("t5_sensors_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_efficacy" type="text" id="number" value="<%=formulaHM.get("t5_sensors_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_op_hours" type="text" id="integer" value="<%=formulaHM.get("t5_sensors_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t5_sensors_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t5_sensors_installation_cost" type="text" id="number" value="<%=formulaHM.get("t5_sensors_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			    	<%-- 4th Row: T8 --%>
			    	<div class ="table_inline_flex" id="t8_row" style="display: none;">
			            <div class="table_row_bold">T8</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t8_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t8_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_power_rating" type="text" id="number" value="<%=formulaHM.get("t8_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_efficacy" type="text" id="number" value="<%=formulaHM.get("t8_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t8_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_op_hours" type="text" id="integer" value="<%=formulaHM.get("t8_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t8_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_installation_cost" type="text" id="number" value="<%=formulaHM.get("t8_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	
			    	</div>
			    	
			    	<%-- 5th Row: T8 with sensors --%>
			    	<div class ="table_inline_flex" id="t8_sensors_row" style="display: none;">
			            <div class="table_row_bold">T8 with sensors</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_power_rating" type="text" id="number" value="<%=formulaHM.get("t8_sensors_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_efficacy" type="text" id="number" value="<%=formulaHM.get("t8_sensors_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_op_hours" type="text" id="integer" value="<%=formulaHM.get("t8_sensors_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_cost_lamp" type="text" id="number" value="<%=formulaHM.get("t8_sensors_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="t8_sensors_installation_cost" type="text" id="number" value="<%=formulaHM.get("t8_sensors_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			    	<%-- 6th Row: LED --%>
			    	<div class ="table_inline_flex" id="LED_row" style="display: none;">
			            <div class="table_row_bold">LED</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("LED_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("LED_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_power_rating" type="text" id="number" value="<%=formulaHM.get("LED_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_efficacy" type="text" id="number" value="<%=formulaHM.get("LED_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("LED_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_op_hours" type="text" id="integer" value="<%=formulaHM.get("LED_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_cost_lamp" type="text" id="number" value="<%=formulaHM.get("LED_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="LED_installation_cost" type="text" id="number" value="<%=formulaHM.get("LED_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			    	<%-- 7th Row: Induction --%>
			    	<div class ="table_inline_flex" id="induction_row" style="display: none;">
			            <div class="table_row_bold">Induction</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("induction_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("induction_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_power_rating" type="text" id="number" value="<%=formulaHM.get("induction_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_efficacy" type="text" id="number" value="<%=formulaHM.get("induction_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("induction_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_op_hours" type="text" id="integer" value="<%=formulaHM.get("induction_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_cost_lamp" type="text" id="number" value="<%=formulaHM.get("induction_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="induction_installation_cost" type="text" id="number" value="<%=formulaHM.get("induction_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			    	<%-- 8th Row: Metal Halide --%>
			    	<div class ="table_inline_flex" id="metal_halide_row" style="display: none;">
			            <div class="table_row_bold">Metal Halide</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("metal_halide_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("metal_halide_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_power_rating" type="text" id="number" value="<%=formulaHM.get("metal_halide_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_efficacy" type="text" id="number" value="<%=formulaHM.get("induction_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("metal_halide_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_op_hours" type="text" id="integer" value="<%=formulaHM.get("metal_halide_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_cost_lamp" type="text" id="number" value="<%=formulaHM.get("metal_halide_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="metal_halide_installation_cost" type="text" id="number" value="<%=formulaHM.get("metal_halide_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			    	<%-- 9th Row: CFL --%>
			    	<div class ="table_inline_flex" id="CFL_row" style="display: none;">
			            <div class="table_row_bold">CFL</div>
			            <div class="table_row">
			            	<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_num_fixtures" type="text" id="integer" value="<%=formulaHM.get("CFL_num_fixtures")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_lamp_fixture" type="text" id="integer" value="<%=formulaHM.get("CFL_lamp_fixture")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">	
						
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_power_rating" type="text" id="number" value="<%=formulaHM.get("CFL_power_rating")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_efficacy" type="text" id="number" value="<%=formulaHM.get("CFL_efficacy")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_ballast_factor" type="text" id="integer" value="<%=formulaHM.get("CFL_ballast_factor")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_op_hours" type="text" id="integer" value="<%=formulaHM.get("CFL_op_hours")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_cost_lamp" type="text" id="number" value="<%=formulaHM.get("CFL_cost_lamp")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>
						<div class="table_row">
							<div class="form-group">
								<div class="col-lg-12">
									<input name="CFL_installation_cost" type="text" id="number" value="<%=formulaHM.get("CFL_installation_cost")[0] %>" class="form-control"/>
								</div>	
							</div>
						</div>	 
			    	</div>
			    	
			   </div>

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
	
</body>
</html>
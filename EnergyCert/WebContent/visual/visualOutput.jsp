<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,java.text.*" %>


<% 
	HashMap<String, String> siteInfoMap = (HashMap<String,String>) request.getAttribute("siteInfoMap");
	String fromFile = (String)request.getAttribute("actualConsumption");
	if(fromFile.equals("NO")){ 
		System.out.println("BOBOB Link");
	%>
		
<%@include file="../protectusers.jsp" %>		
		
<%}%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">

<!-- Bootstrap-->
<link href="../css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../css/va_stylesheet.css"> 
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>



<%
// retrieve Info

	
	
	String site_info_name = siteInfoMap.get("site_info_name");
	String site_info_address_street = siteInfoMap.get("site_info_address_street");
	String site_info_address_city = siteInfoMap.get("site_info_address_city");
	String site_info_address_postal = siteInfoMap.get("site_info_address_postal");
	String site_info_address_country = siteInfoMap.get("site_info_address_country");
	String warehouseHeated = siteInfoMap.get("warehouseHeated");
	String warehouseCooled = siteInfoMap.get("warehouseCooled");
	String officeHeated = siteInfoMap.get("officeHeated");
	String officeCooled = siteInfoMap.get("officeCooled"); 
			
	
	
	//String site_info_business_unit = siteInfoMap.get("site_info_business_unit");
	
	double actualConsumption = Double.parseDouble((String)request.getAttribute("actualConsumption"));
	double heatConsumption =	 Double.parseDouble((String)request.getAttribute("heatConsumption"));
	double coolConsumption =  Double.parseDouble((String)request.getAttribute("coolConsumption"));
	double lightingConsumption = Double.parseDouble((String) request.getAttribute("lightingConsumption"));
	double extLightingConsumption =  Double.parseDouble((String)request.getAttribute("extLightingConsumption"));
	double hotWaterConsumption =  Double.parseDouble((String)request.getAttribute("hotWaterConsumption"));
	double mheConsumption =  Double.parseDouble((String)request.getAttribute("mheConsumption"));
	double operationsConsumption = Double.parseDouble((String)request.getAttribute("operationsConsumption"));
		
	String business_unit = siteInfoMap.get("business_unit"); 
	String facility_contact = siteInfoMap.get("facility_contact"); 
	
	double benchmark = heatConsumption + coolConsumption + lightingConsumption 
			+ extLightingConsumption +hotWaterConsumption+mheConsumption+operationsConsumption;
	
	int rating = (int)(100 * actualConsumption / benchmark); 
	SQLManager.updateRecords("questionnaire", "energy_rating="+rating, "questionnaire_id=\'" + siteInfoMap.get("quest_id") + "\'");
	
	// for google charts
	int year1 = Integer.parseInt((String)request.getAttribute("consumptionYear"));
	int year2 = year1-1;
	int year3 = year2-1;
	
	/*
	ResultSet year1_rs = SQLManager.retrieveRecords("QUESTIONAIRE", "year="+year1+"AND site_id="+"'"+site_id+"'");
	ResultSet year2_rs = SQLManager.retrieveRecords("QUESTIONAIRE", "year="+year2+"AND site_id="+"'"+site_id+"'");
	ResultSet year3_rs = SQLManager.retrieveRecords("QUESTIONAIRE", "year="+year3+"AND site_id="+"'"+site_id+"'");
	*/
	double year1_electrical_use = Double.parseDouble((String) siteInfoMap.get("year1_electrical_use"));
	double year2_electrical_use = Double.parseDouble((String) siteInfoMap.get("year2_electrical_use"));
	double year3_electrical_use = Double.parseDouble((String) siteInfoMap.get("year3_electrical_use"));
	
	double year1_nat_gas_use = Double.parseDouble((String) siteInfoMap.get("year1_nat_gas_use"));	
	double year2_nat_gas_use = Double.parseDouble((String) siteInfoMap.get("year2_nat_gas_use"));	
	double year3_nat_gas_use = Double.parseDouble((String) siteInfoMap.get("year3_nat_gas_use"));

	
	double emission_factor_electrical_use = Double.parseDouble(siteInfoMap.get("emission_factor_electrical_use"));
	double emission_factor_nat_gas_use = Double.parseDouble(siteInfoMap.get("emission_factor_nat_gas_use"));
	
	double warehouseFloorArea = Double.parseDouble((String)request.getAttribute("warehouseFloorArea"));
	double officeFloorArea = Double.parseDouble((String)request.getAttribute("officeFloorArea"));
	
	double totalFloorArea =  warehouseFloorArea + officeFloorArea; 

	double totalVolume = Double.parseDouble((String)request.getAttribute("volume"));
		
	double electricalPerArea = year1_electrical_use / totalFloorArea;
	double electricalPerVol = year1_electrical_use / totalVolume;
	double natGasPerArea = year1_nat_gas_use / totalFloorArea;
	double natGasPerVol = year1_nat_gas_use / totalVolume;

	DecimalFormat df = new DecimalFormat("#.##");
	
	
%>


<script type="text/javascript">  

google.load("visualization", "1", {packages:["corechart"]});



function initChart() {

	var consumptionData = google.visualization.arrayToDataTable([
	                                                             ['Genre', 'Electricity', 'Natural Gas', { role: 'annotation' } ],
	                                                             [<%="'"+year3+"'"%>, <%= year3_electrical_use%>, <%= year3_nat_gas_use  %>, ''],
	                                                             [<%="'"+year2+"'"%>, <%= year2_electrical_use %>, <%= year2_nat_gas_use %>, ''],
	                                                             [<%="'"+year1+"'"%>, <%= year1_electrical_use %>, <%= year1_nat_gas_use %>, ''],
	                                                           	]);
	

	
	
	
	var consumptionOptions = {
			width : 300,
			height :200,
			
			vAxis : {
				title : 'Energy (kWh) 1000',
				titleTextStyle : {
					color : 'black'
				}
			},
			legend : {
				position : 'top',
				maxLines : 3
			},
			bar : {
				groupWidth : '75%'
			},
			isStacked : true,
			colors : [ '#ffcd00', '#c10435' ],
			animation : {
				duration : 1000,
				easing : 'out',
			},
		};

		var consumptionChart = new google.visualization.ColumnChart(document
				.getElementById('tc_chart'));
		consumptionChart.draw(consumptionData, consumptionOptions);

		var emissionData = google.visualization
		.arrayToDataTable([
				[ 'Genre', 'Electricity', 'Natural Gas', {
					role : 'annotation'
				} ],
				[<%="'"+year3+"'"%>, <%= year3_electrical_use * emission_factor_electrical_use %>, <%= year3_nat_gas_use * emission_factor_nat_gas_use %>, ''],
				[<%="'"+year2+"'"%>,  <%= year2_electrical_use * emission_factor_electrical_use %>, <%= year2_nat_gas_use * emission_factor_nat_gas_use %>, ''],
				[<%="'"+year1+"'"%>,  <%= year1_electrical_use * emission_factor_electrical_use %>, <%= year1_nat_gas_use * emission_factor_nat_gas_use %>, ''],
			]);

		var emissionOptions = {
				width : 300,
				height : 200,
				
			vAxis : {
				title : 'CO2 Emmission',
				titleTextStyle : {
					color : 'black'
				}
			},
			legend : {
				position : 'top',
				maxLines : 3
			},
			bar : {
				groupWidth : '75%'
			},
			isStacked : true,
			colors : [ '#ffcd00', '#c10435' ],
			animation : {
				duration : 1000,
				easing : 'out',
			},
		};

		var emissionChart = new google.visualization.ColumnChart(document
				.getElementById('te_chart'));

		emissionChart.draw(emissionData, emissionOptions);

		
		 var button = document.getElementById('whatifButton');

		 button.onclick = function() {
	
			var heatMul = getHeatMultiplier();
			var coolMul = getCoolMultiplier();
			var lightMul = getLightingMultiplier();
			 
			var initialElecConsumption = <%= year1_electrical_use %>;
			var initialNGConsumption = <%= year1_nat_gas_use %>;
			var initialElecEmission = <%= year1_electrical_use * emission_factor_electrical_use %>
			var initialNGEmission = <%= year1_nat_gas_use * emission_factor_nat_gas_use %> 
			
			
			var newElecConsumption = initialElecConsumption * heatMul * coolMul * lightMul;
			var newNGConsumption = initialNGConsumption * heatMul * coolMul * lightMul;
			var newElecEmission = initialElecEmission * heatMul * coolMul * lightMul;
			var newNGEmission = initialNGEmission * heatMul * coolMul * lightMul;
			
			
			consumptionData.setValue(2, 1, newElecConsumption);
			consumptionData.setValue(2, 2, newNGConsumption);
			emissionData.setValue(2, 1, newElecEmission);
			emissionData.setValue(2, 2, newNGEmission);
			
			consumptionChart.draw(consumptionData, consumptionOptions);
			emissionChart.draw(emissionData, emissionOptions);
		}
		 
	}

	google.setOnLoadCallback(initChart);

	//COPY THISS!!!!

	$(document).ready(function() {

		initRating();

		
		$("#whatifButton").click(function() {
			//new rating
			
			alert("Hello World");
			
			var newRating = calculateNewRating();

			var leftOffset = getLeftOffset(newRating);
			var topOffset = getTopOffset(newRating);

			$("#currentRating").text(newRating);
			$("#ratingPointer").animate({
				"left" : leftOffset + "px",
				"top" : topOffset + "px"
			}, "slow");

		});
		

	});

	function calculateNewRating() {
		var actualConsumption =
<%= actualConsumption %>;
	var benchmark = <%= benchmark%>;
	
	var heatMul = getHeatMultiplier();
	var coolMul = getCoolMultiplier();
	var lightMul = getLightingMultiplier();
	
	var newConsumption = actualConsumption * heatMul * coolMul * lightMul;
	
	var newRating = 100 * newConsumption / benchmark;
	
	return Math.round(newRating); 
	
	
}

function initRating(){
	var rating = <%=rating%>;
		
	
	var leftOffset = getLeftOffset(rating);
	var topOffset = getTopOffset(rating);
	
	$("#ratingPointer").css({"left":leftOffset+"px", 
							"top": topOffset+"px"});
}

function getTopOffset(rating){
	
	var topOffset = 415;
	for(var i=50; i<rating && i<350 ; i+= 50){
		topOffset += 80;
	}
	return topOffset;
}

function getLeftOffset(rating){
	var leftOffset = 250;
	for(var i=50; i<rating && i<350 ; i+= 50){
		leftOffset += 40;
	}
	return leftOffset;
}


function getHeatMultiplier(){
	
	var txtBox = document.getElementById('heatFac');
	var multiplier = txtBox.value;
	var total = <%= benchmark%>;
	var consumption = <%= heatConsumption %>
	if(consumption ==  0 || multiplier == 0){
		return 1;
	}
	var percentage = consumption / total;
	var newConsumption = consumption / multiplier;
	var newPercentage = newConsumption / (total - consumption + newConsumption);
	
	return newPercentage / percentage;
}

function getCoolMultiplier(){
	var txtBox = document.getElementById('coolFac');
	var multiplier = txtBox.value;
	
	var total = <%= benchmark%>;
	var consumption = <%= coolConsumption %>
	if(consumption ==  0 || multiplier == 0){
		return 1;
	}
	var percentage = consumption / total;
	var newConsumption = consumption / multiplier;
	var newPercentage = newConsumption / (total - consumption + newConsumption) ;
	
	return newPercentage / percentage;
}

function getLightingMultiplier(){
	var txtBox = document.getElementById('lightFac');
	var multiplier = txtBox.value;
	
	var total = <%= benchmark%>;
	var consumption = <%= lightingConsumption %> +  <%= extLightingConsumption %>;
	if(consumption ==  0 || multiplier == 0){
		return 1;
	}
	var percentage = consumption / total;
	var newConsumption = consumption / multiplier;
	var newPercentage = newConsumption / (total - consumption + newConsumption);
	
	return newPercentage / percentage;
}




</script>
<title>GTL Energy Certificate Visual Output</title>


</head>


<body>
<%@include file="../header.jsp" %>
<br/>
<br/>
<br/>
<div class="navigation" id ="share_button" style="float:right">
		<button class="btn btn-info" data-toggle="modal" data-target="#shareModel">Share</button>
</div>

	<%-- Modal for Share --%>
	<div class="modal fade" id="shareModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="left: 0px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">X</button>
					<h4 class="modal-title">Share</h4>
				</div>

				<div class="modal-body">
					<form name="assign-form" method="POST" action="processShare"
						class="form-horizontal">
						<div class="form-group">
							<label class="col-md-5 control-label">Email</label>
							<div class="col-md-5">
								<input type="text" class="form-control" name="Email" />
							</div>
						</div>
						<input type="hidden" name="q_id"
							value='<%=siteInfoMap.get("quest_id")%>'> <input
							type="submit" name="submit" value="Email!" />

					</form>
				</div>
			</div>
		</div>
	</div> 
<br/>



<div class="navigation" id ="whatif" style="float:right">
		<button class="btn btn-info" data-toggle="modal" data-target="#whatIfModel">What If</button>
</div>



<!-- Modal -->
<div class="modal fade" id="whatIfModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">What If</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
							<label class="col-md-5 control-label">Cooling Factor</label>
							<div class="col-md-5">
								<input type="text" class="form-control" name="coolFac" id="coolFac" />
							</div>
						</div>
						<div class="form-group">	
								<label class="col-md-5 control-label">Lighting Factor</label>
							<div class="col-md-5">
								<input type="text" class="form-control" name="lightFac" id="lightFac"/>
							</div>
						</div>
						<div class="form-group">
						
							<label class="col-md-5 control-label">Heating Factor</label>
							<div class="col-md-5">
								<input type="text" class="form-control" name=""heatFac"" id="heatFac"/>
							</div>
						</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-info" data-dismiss="modal" id="whatifButton">What If!</button>
      </div>
    </div>
  </div>
</div>




	<%-- Modal for Whatif --%>
	<div class="modal fade"  tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="left: 0px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">X</button>
					<h4 class="modal-title">What If</h4>
				</div>

				<div class="modal-body">
						
							
						
						
						
						
						
				</div>
			</div>
		</div>
	</div> 



<br/>
<div id="main">
<div id="General_Info">
<div id="logo_container">
<div id="company_logo" style="float: left"><img src="../img/DHL_Logo.png" height="23"/></div>
<div id="dhl_logo" ><img src="../img/DHL_Logo.png" height="23" /></div>
</div>
<table id="general_info_table">
<tr><th colspan = "6">Energy Certificate</th></tr>
<tr>
<td class="field_name"> Facility Name:</td>
<td class="field_info"><%= site_info_name %></td>
<td></td>
<td></td>
<td class="field_name"> Certification Year:</td>
<td class="field_info"> <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %></td>
</tr>
<tr><th colspan = "6">Building and Facility Information</th></tr>
<tr>
<td class="field_name"> Street:</td>
<td class="field_info"> <%= site_info_address_street %></td>
<td class="field_name"> Warehouse Floor Area:</td>
<td class="field_info">  <%= warehouseFloorArea %> m<sup>2</sup></td>
<td class="field_name"> Office Floor Area:</td>
<td class="field_info">  <%= officeFloorArea %> m<sup>2</sup></td>
</tr>
<tr>
<td class="field_name"> City:</td>
<td class="field_info"> <%= site_info_address_city %></td>
<td class="field_name"> Warehouse Heated:</td>
<td class="field_info">  <%= warehouseHeated %></td>
<td class="field_name"> Office Heated:</td>
<td class="field_info">  <%= officeHeated %></td>
</tr>
<tr>
<td class="field_name"> Postal Code:</td>
<td class="field_info">  <%= site_info_address_postal %></td>
<td class="field_name"> Warehouse Cooled:</td>
<td class="field_info">  <%= warehouseCooled %> </td>
<td class="field_name"> Office Cooled:</td>
<td class="field_info"><%= officeCooled %> </td>
</tr>
<tr>
<td class="field_name"> Country:</td>
<td class="field_info">  <%= site_info_address_country %></td>
<td> </td>
<td> </td>
<td> </td>
<td> </td>
</tr>

<tr class = "blank_row">
<td colspan="6"></td>
</tr>
<tr class = "blank_row">
<td colspan="6"></td>
</tr>

<tr>
<td class="field_name"> Business Unit:</td>
<td class="field_info">  <%= business_unit %></td>
<td> </td>
<td> </td>
<td class="field_name"> Date Issued: </td>
<td class="field_info">  <%= new java.text.SimpleDateFormat("MMM-yy").format(new java.util.Date()) %> </td>
</tr>

<tr>
<td class="field_name"> Facility Contact:</td>
<td class="field_info">  <%= facility_contact %></td>
<td> </td>
<td> </td>
<td> </td>
<td> </td>
</tr>


</table>

</div>

<div id="Charts">
	<div id="Eff_Rating">
		<h2>Energy Efficiency Rating (<%= year1 %>)</h2>
		More energy efficient
		<!--  ActualConsumption: <%=actualConsumption %> -->
		<!--  Benchmark: <%=benchmark %> -->
		<br/>
		
		<div id="ratingPointer">
		<img src="../img/arrow.png" height="65pt" style="padding: 5pt"/><span id="currentRating"><%=rating %></span>
		</div>
	
		<div class="energybar" id="a_bar"><span class="rating">A</span> 0-50</div>
		<div class="energybar" id="b_bar"><span class="rating">B</span> 51-100</div>
		<div class="energybar" id="c_bar"><span class="rating">C</span> 101-150</div>
		<div class="energybar" id="d_bar"><span class="rating">D</span> 151-200</div>
		<div class="energybar" id="e_bar"><span class="rating">E</span> 201-250</div>
		<div class="energybar" id="f_bar"><span class="rating">F</span> 251-300</div>
		<div class="energybar" id="g_bar"><span class="rating">G</span> over 300</div>
		
			
			
			
		Less energy efficient
	</div>
	
	
	<div id="google_charts">
	<div id="Total_Consumption">
		<h2>Total Consumption (kWh)</h2>
		<div id="tc_chart"></div>
	</div>	
	<div id="Total_Emmission">
		<h2>Total Emission (tonnes CO2)</h2>
		<div id="te_chart"></div>
	</div>
	</div>
</div>



<div id="Add_Info">

<table id="additional_info_table">
<tr><th colspan = "5">Additional Information	</th></tr>
<tr>
<td><%=year1 %> Key Performance Indicators:</td>
<td><%= df.format(electricalPerArea) %> kWh per m<sup>2</sup></td>
<td><%= df.format(natGasPerArea) %> kg CO2 per m<sup>2</sup></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td><%= df.format(electricalPerVol) %> kWh per m<sup>3</sup></td>
<td><%= df.format(natGasPerVol) %> kg CO2 per m<sup>3</sup></td>
<td></td>
<td></td>
</tr>

</table>

</div>

If you require further detail or calculation methods in this report please email energycertificate@dhl.com


</div>

</body>
</html>
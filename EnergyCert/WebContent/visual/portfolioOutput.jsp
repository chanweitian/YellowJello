<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,visual.*"%>
<%@include file="../protectusers.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">

<!-- Bootstrap-->
<link href="../css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../css/va_stylesheet.css">
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<%-- Questionnaire.jsp --%>
<link href="../css/questionnaire.css" rel="stylesheet">

<script type="text/javascript" src="../js/d3min.js"></script>
<script type="text/javascript" src="../js/scatter.js"></script>

<%
	// retrieve Info
	//Only if there is information then show.
	ArrayList<String> years = (ArrayList<String>) request.getAttribute("years");
	boolean status = true;
	if (years.size()==0){
		status = false;
	}
	//convert Java ArrayList to js
%>
<script>
	var years = [];
	var regionList = [];
	var countryList = [];
	var master = [];
	var year = "";
	var selectFilter = "";
<%//Pushing the data into years
	for(int i = 0; i <years.size(); i++){%>
	years.push(
<%=years.get(i)%>
	);
<%}%>
	// methods for dynamically adding options to text box
	var addOption = function(selectbox, text, value) {
		var optn = document.createElement("OPTION");
		optn.text = text;
		optn.value = value;
		selectbox.options.add(optn);
	}
	
	var removeOption =function(selectbox){
		var select = selectbox, option = null, next_desc = null;
		  var len = select.options.length;
		 
		  for (var i = 0; i < len; i++)
	    {
	        select.remove(0);
	    }
	}
</script>

<title>GTL Warehouse Portfolio Overview</title>

</head>
<body>
	<%@include file="../header.jsp"%>
	<br />
	<br />
	<div class="header">Manage Warehouse Portfolio!</div>

	<%
		if(status){
	%>
	<form name="form1" action="" method="get">
		Please select year of visualisation: 
		<select id="year">
			<script>
				//dynamically generates dropdown options
				var yearOptions = document.forms["form1"].elements["year"];

				for (var i = 0; i < years.length; ++i) {
					addOption(yearOptions, years[i], years[i]);
				}
			</script>
		</select>
		<br> You may choose to filter the data by: 
		<select id="filter">
			<option selected>No filter (show all data)</option>
			<option>Country</option>
			<option>Region</option>
		</select>
		<br> 
		<input type="button" name="button" value="Proceed" onClick="yearAndFilter(this.form)">
	</form>
	<br>
	
	<form id ="yearOnly" style="display: none;" action = "" method= "get">
			 Please select the axis desired:
			 <select id="axis">
			<option>Carbon Emission</option>
			<option>Energy Consumption</option>
			</select> <br>
			<input type="hidden" id="filter" value="none">			
			<input type="button" name="button" value="Generate"
			onClick="generate(this.form, 'null')">
	</form>

	<form id="country" style="display: none;" action=""
		method="get">
		Please select the country desired: <select id="country">
		</select><br>
		Please select the axis desired: 
		<select id="axis">
			<option>Carbon Emission</option>
			<option>Energy Consumption</option>
			</select><br>
		<input type="hidden" id="filter" value="Country">	
		 <input type="button" name="button" value="Generate - Country"
			onClick="generate(this.form)">
	</form>

	<form id="region" style="display: none;" action=""
		method="get">
		Please select the region desired: <select id="region">
		</select> <br>
		Please select the axis desired: 
		<select id="axis">
			<option>Carbon Emission</option>
			<option>Energy Consumption</option>
			</select><br>
		<input type="hidden" id="filter" value="Region">	
		<input type="button" name="button" value="Generate - Region"
			onClick="generate(this.form)">
	</form>
	<%
		}else{
	%>
	Sorry there are currently no warehouses with completed questionnaire on
	file.
	<br> If you believe you have received this message in error,
	please contact your system administrator.
	<br>
	<%
		}
	%>

	<div id=chart></div>

	<script type="text/javascript">
		var drawCarbon = function(data) {
			master = [];
			for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   var energyRating = data.sites[i].siteName;
			   var elecEmi = data.sites[i].elecEmi;
			   var gasEmi = data.sites[i].gasEmi;
			   var elec = Number(data.sites[i].elec);
			   var gas = Number(data.sites[i].gas);
			   var totalConsp = gas + elec;
			   var totalEmi = gasEmi+elecEmi;
			   
			   var site = {"effRating": energyRating, "carbon": totalEmi, "energy": totalConsp , "siteName": siteName};
			   master.push(site);
			   
			}
			
			var options = {
				width : 720,
				height : 400,
				xValue : 'carbon',
				yValue : 'effRating',
				series : 'siteName'
			};
			var div = document.getElementById("chart");
			div.innerHTML = "";

			var scatter = new Scatter('#chart', options);
			scatter.render(master);
			scatter.xlabel("carbon emission");
			scatter.ylabel("efficiency rating");
			scatter.legend();
			console.log(scatter);
		}

		var drawEnergy = function(data) {
			master = [];
			for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   var energyRating = data.sites[i].siteName;
			   var elecEmi = data.sites[i].elecEmi;
			   var gasEmi = data.sites[i].gasEmi;
			   var elec = Number(data.sites[i].elec);
			   var gas = Number(data.sites[i].gas);
			   var totalConsp = gas + elec;
			   var totalEmi = gasEmi+elecEmi;
			   
			   var site = {"effRating": energyRating, "carbon": totalConsp, "energy": totalConsp , "siteName": siteName};
			   master.push(site);
			   
			}

			
			var options = {
				width : 720,
				height : 400,
				xValue : 'energy',
				yValue : 'effRating',
				series : 'siteName'
			};

			var div = document.getElementById("chart");
			div.innerHTML = "";

			var scatter = new Scatter('#chart', options);
			scatter.render(master);
			scatter.xlabel("energy consumption");
			scatter.ylabel("efficiency rating");
			scatter.legend();
			console.log(scatter);
		}
		
		//retrieve master data with no filter and generate the charts
		var generate = function(form){
			var axis = form.axis.value
			var selectFilter = form.filter.value
			var request = '';
			switch(selectFilter){
			case 'Region':
				var value = form.value.region;
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + filter + "&value=" + value;
				break;
			case 'Country':
				var value = form.value.country;
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + filter + "&value=" + value;
				break;
			case 'none':	
				var value = 'null';
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + filter + "&value=" + value;
				break;
			};
			
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200){
					var result = JSON.parse(request.responseText);
					if (axis == 'Carbon Emission'){
					drawCarbon(result);
					}else{
					drawEnergy(result);	
					}
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}

		//goes to the servlet to get relevant countries for a selected year
		var retrieveCountry = function(form, callback) {
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "retrieveCountry?year=" + year;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200){
					var result = JSON.parse(request.responseText);
					callback(result);
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}
		
		//goes to the servlet to get relevant regions for a selected year
		var retrieveRegion = function(form, callback) {
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "retrieveRegion?year=" + year;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200){
					var result = JSON.parse(request.responseText);
					callback(result);
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}
		
		//populates the relevant countries in the javascript
		var generateCountryList = function(data) {
	        countryList = [];
			for(var i in data)
	        { 
	            countryList.push(data.country); 
	        };
	        var countryOptions = document.forms["country"].elements["country"];
	        removeOption(countryOptions);
			for (var i = 0; i < countryList.length; ++i) {
				addOption(countryOptions, countryList[i], countryList[i]);
			}
		}
		
		//populates the relevant regions in the javascript
		var generateRegionList = function(data) {
	        regionList = [];
			for(var i in data)
	        { 
	            regionList.push(data.region); 
	        };
	        var regionOptions = document.forms["region"].elements["region"];
	        removeOption(regionOptions);
			for (var i = 0; i < regionList.length; ++i) {
				addOption(regionOptions, regionList[i], regionList[i]);
			}
		}
		
		//logic for showing the relevant section after filling in form 1
		function yearAndFilter(form) {
			year = null;
			year = form.year.value;
			var filter = form.filter.value;
			
			switch (filter) {
			case 'Country':
				filter = "Country";
				retrieveCountry(form, generateCountryList);
				document.getElementById("country").style.display = "block";
				document.getElementById("region").style.display = "none";
				document.getElementById("yearOnly").style.display = "none";
				break;
			case 'Region':
				filter = "Region";
				retrieveRegion(form, generateRegionList);
				document.getElementById("country").style.display = "none";
				document.getElementById("region").style.display = "block";
				document.getElementById("yearOnly").style.display = "none";
				break;
			default:
				filter = "none";
				document.getElementById("region").style.display = "none";
				document.getElementById("country").style.display = "none";
				document.getElementById("yearOnly").style.display = "block";
				break;
			}

		}
		
	</script>

	If you require further details shown on this report please email
	energycertificate@dhl.com

</body>
</html>
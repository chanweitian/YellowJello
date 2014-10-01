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

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
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
	google.load("visualization", "1", {packages:["corechart"]});
	var years = [];
	var regionList = [];
	var countryList = [];
	var master = [];
	var year = "";
	var selectFilter = "";
	var filterValue = "";
	var axis ="";
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
	
	var removeOption = function(selectbox){
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
	<div style="width:50%;margin:0 auto;" class="header">Manage Warehouse Portfolio!</div>

	<%
		if(status){
	%>
	<div style="width:50%;margin:0 auto;">
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
		<input type="button"  class="btn-small btn-primary" name="button" value="Proceed" onClick="yearAndFilter(this.form)">
	</form>
	</div>
	
	<div id = "secondForm" style="width:50%; margin:0 auto;">
	<br>
	<form id ="yearOnly" style="display: none;" action = "" method= "get">
			 Please select the axis desired:
			 <select id="axis">
			<option>Carbon Emission</option>
			<option>Energy Consumption</option>
			</select> <br>
			<input type="hidden" id="filter" value="none">			
			<input type="button" class="btn-small btn-primary" name="button" value="Generate"
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
		 <input type="button" class="btn-small btn-primary" name="button" value="Generate - Country"
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
		<input type="button" class="btn-small btn-primary" name="button" value="Generate - Region"
			onClick="generate(this.form)">
	</form>
	<br>
	</div>
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

	<div style="width:50%;margin:0 auto;" id=chart></div>

	<script type="text/javascript">
	var drawCarbon = function(data) {
		var data3 = new google.visualization.DataTable();
		data3.addColumn('number', 'Carbon');
		for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   data3.addColumn('number', siteName);
		}
		var j = 1;
		var k = data.sites.length+1;
		for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   var energyRating = data.sites[i].energyRating;
			   var elecEmi = data.sites[i].elecEmi;
			   var gasEmi = data.sites[i].gasEmi;
			   var elec = Number(data.sites[i].elec);
			   var gas = Number(data.sites[i].gas);
			   var totalConsp = gas + elec;
			   var totalEmi = gasEmi+elecEmi;
			   data3.addRows(1);
			   data3.setCell(i, 0, parseInt(totalEmi));
			   data3.setCell(i, j, parseInt(energyRating));
			   j++;

		}
	       var options = {
	          title: 'Warehouse Portfolio',
	          hAxis: {title: 'Carbon Emission'},
	          vAxis: {title: 'Efficiency Rating'},
	          legend: '',
	          'width':1024,
	          'height':720
	        };

	        var chart = new google.visualization.ScatterChart(document.getElementById('chart'));

	        chart.draw(data3, options);
	        
	}
	
	
	/*	var drawCarbon = function(data) {
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
	*/
	
	var drawEnergy = function(data) {
		var data3 = new google.visualization.DataTable();
		data3.addColumn('number', 'Energy');
		for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   data3.addColumn('number', siteName);
		}
		var j = 1;
		var k = data.sites.length+1;
		for (i = 0; i < data.sites.length; i++) { 
			   var siteName = data.sites[i].siteName;
			   var energyRating = data.sites[i].energyRating;
			   var elecEmi = data.sites[i].elecEmi;
			   var gasEmi = data.sites[i].gasEmi;
			   var elec = Number(data.sites[i].elec);
			   var gas = Number(data.sites[i].gas);
			   var totalConsp = gas + elec;
			   var totalEmi = gasEmi+elecEmi;
			   data3.addRows(1);
			   data3.setCell(i, 0, parseInt(totalConsp));
			   data3.setCell(i, j, parseInt(energyRating));
			   j++;
		}

	       var options = {
	          title: 'Warehouse Portfolio',
	          hAxis: {title: 'Energy Consumption'},
	          vAxis: {title: 'Efficiency Rating'},
	          legend: '',
	          'width':1024,
	          'height':720
	        };

	        var chart = new google.visualization.ScatterChart(document.getElementById('chart'));

	        chart.draw(data3, options);
	        
	}
	
	/*

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
		*/
		
		//retrieve master data with no filter and generate the charts
		var generate = function(form){
		 	axis = form.axis.value
			selectFilter = form.filter.value
			console.log(selectFilter);
			var request = '';
			switch(selectFilter){
			case 'Region':
				filterValue = form.region.value;
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + selectFilter + "&value=" + filterValue;
				break;
			case 'Country':
				filterValue = form.country.value;
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + selectFilter + "&value=" + filterValue;
				break;
			case 'none':
				filterValue = 'null';
				request = new XMLHttpRequest(), typeValue = "get", urlValue = "generate?year=" + year + "&filter=" + selectFilter + "&value=" + filterValue;
				break;
			};
			
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200){
					var result = JSON.parse(request.responseText);
					if (axis == 'Carbon Emission'){
					document.getElementById("share").style.display = "block";
					drawCarbon(result);
			
					}else{
					document.getElementById("share").style.display = "block";
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
	            countryList.push(data[i]); 
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
	        console.log(data);
	        
			for(var i in data)
	        { 
	            regionList.push(data[i]);
	        };
	        var regionOptions = document.forms["region"].elements["region"];
	        removeOption(regionOptions);
			for (var i = 0; i < regionList.length; i++) {
				console.log(regionList.length);
				addOption(regionOptions, regionList[i], regionList[i]);
			}
		}
		
		function clear(){
			var a = document.getElementById("country").style.display;
			var b = document.getElementById("region").style.display;
			var c = document.getElementById("yearOnly").style.display;
			a.innerHTML = "";
			b.innerHTML = "";
			c.innerHTML = "";
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
		<form id ="share" style="width:50%; min-height:100%; margin:0 auto; display: none;" action = "portfolioEmail" method= "post">
			If you wish to share this chart, please enter the email address of the intended receipient: 
			<br>
			<input type=hidden id=year value = "<script>year</script>" >
			<input type=hidden id=axis value = "<script>axis</script>" >
			<input type=hidden id=selectFilter value = "<script>selectFilter</script>">
			<input type=hidden id=filterValue value = "<script>filterValue</script>">
			<input type="text" id="Email" placeholder="Enter receipient Email">
			<input type="submit" class="btn-small btn-primary" name="submit" value="Email">
	</form>
	
	<div style="width:50%; min-height:100%; margin:0 auto;">
 	If you require further details shown on this report please email
	energycertificate@dhl.com
	</div>
</body>
</html>
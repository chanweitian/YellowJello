<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,visual.*"%>
<%@ page import="com.google.common.collect.*" %>
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

<%-- Questionnaire.jsp --%>
<link href="../css/questionnaire.css" rel="stylesheet">

<script type="text/javascript" src="../js/d3min.js"></script>
<script type="text/javascript" src="../js/scatter.js"></script>

<%
	// retrieve Info
	//Only if there is information then show.
	Multimap<String, Object> myMultimap = (Multimap) request.getAttribute("myMultimap");
	ArrayList<String> years = (ArrayList<String>) request.getAttribute("years");
	boolean status = true;
	if (years.size()==0 || myMultimap.isEmpty() == true ){
		status = false;
	}
	//convert Java ArrayList to js
%>
	<script>
	var master = [];
	var years = [];
	var renderData = [];
	var regionList = [];
	var countryList = [];
    
    var addOption = function (selectbox,text,value)  
    {  
    var optn = document.createElement("OPTION");  
    optn.text = text;  
    optn.value = value;  
    selectbox.options.add(optn);  
    }  
	
    var annualDataJSONConvert = function (year){ 
    	JSON.stringify(year)
    	<%
    	//HARDCODED VALUES
    	String key = "2012";
    	Collection <Object> col = myMultimap.get("2012");
    	 Iterator itr = col.iterator();
         while (itr.hasNext()) {
            Site temp = (Site) itr.next();
			int carbon = temp.carbonConsumption();
			int energy = temp.energyConsumption(); 
			String region = temp.getRegion();
			String country = temp.getCountry();
			String siteName = temp.siteName();
			String efficiencyRating = temp.efficiencyRating();
			int effRating = Integer.parseInt(efficiencyRating);
         }
    	%>
    	
    	
    } 
	</script>


<title>GTL Warehouse Portfolio Overview</title>

</head>
<body>
	<%@include file="../header.jsp"%>
	<br />
	<br />
	<div class="header">Manage Warehouse Portfolio!</div>
	<%if(status){%>
		<form name="form1" action="" method="get">
		Please select year of visualisation: <select id="year">
		<script>
		//dynamically generates dropdown options
		var yearOptions = document.forms["form1"].elements["year"];  

		for (var i=0; i < years.length;++i)  
	 	{  
	 		addOption(yearOptions, years[i], years[i]);  
	 	}
		</script>
		</select><br> 
		You may choose to filter the data by: <select id="filter">
			<option selected>No filter (show all data)</option>
			<option>Country</option>
			<option>Region</option>
		</select><br> Please select the x-axis desired for your visualisation: <select
			id="axis">
			<option>Carbon Emmission</option>
			<option>Energy Consumption</option>
		</select><br> <input type="button" name="button" value="Proceed"
			onClick="yearAndFilter(this.form)">
	</form>
	<br>


	<form id="country" style="display: none;" action="" method="get">
		Please select the country desired:
		<select id="country">
		<script>
    	var countryOptions = document.forms["country"].elements["country"];
		for (var i=0; i < countryList.length;++i)  
	 	{  
	 		addOption(yearOptions, countryList[i], countryList[i]);  
	 	}
		</script>
		</select>
		<input type="button" name="button" value="Generate - Country"
			onClick="generate(this.form)">
	</form>

	<form id="region" style="display: none;" action="" method="get">
		Please select the region desired:
		<select id ="region">
		<script>
    	var regionOptions = documents.forms["region"].elements["region"];
		for (var i=0; i < regionList.length;++i)  
	 	{  
	 		addOption(yearOptions, regionList[i], regionList[i]);  
	 	}
		</script>
		</select>
		<input type="button" name="button" value="Generate - Region"
			onClick="generate(this.form)">
	</form>
	<%}else{%>
		Sorry there are currently no warehouses with completed questionnaire on file. <br>
		If you believe you have received this message in error, please contact your system administrator. <br>
	<%} %>


	<div id=chart></div>

	<script type="text/javascript">
    var filterMasterData = function(year){
    	alert("masterData");
    	alert(master);
    	renderData = [];
    	for(var i = 0; i < master.length; i++)
    	{
    	  if(master[i].year == 'year')
    	  {
    	    renderData.push(master[i]);
    	  }
    	}
    	alert(renderData);
    }
    
    var filterUnique = function (year, regionOrCountry){
    	
    }
	
		var drawCarbon = function (data) {
			var options = {
				width : 720,
				height : 400,
				xValue : 'carbon',
				yValue : 'effRating',
				series : 'siteName'
			};

			var scatter = new Scatter('#chart', options);
			scatter.render(data);
			scatter.xlabel("carbon");
			scatter.ylabel("effRating");
			scatter.legend();
			console.log(scatter);
		}

		var drawEnergy = function (data) {
			var options = {
				width : 720,
				height : 400,
				xValue : 'energy',
				yValue : 'effRating',
				series : 'siteName'
			};

			var scatter = new Scatter('#chart', options);
			scatter.render(data);
			scatter.xlabel("Carbon Emission");
			scatter.ylabel("Energy Rating");
			scatter.legend();
			console.log(scatter);
		}
			      

  
	    //takes in the initial form param and generates the options for country/region filters or generates chart
	    function yearAndFilter(form)
	        {
	          var year = form.year.value;
	          var filter = form.filter.value;
	          var axis = form.axis.value;
	          switch (filter) {
	          case 'Country':
	            document.getElementById("country").style.display="block";
	            document.getElementById("region").style.display="none";
	            break;
	          case 'Region':
	            document.getElementById("country").style.display="none";
	            document.getElementById("region").style.display="block"; 
	            break;
	          // otherwise we assume that the users wants to see everything for a certain year
	          default:
	            document.getElementById("region").style.display="none";
	            document.getElementById("country").style.display="none";
	            //directly generate
	            alert("XXX");
	            filterMasterData(year);
	            alert(axis);
	            switch (axis){
	            case 'Carbon Emmission':
	            	drawCarbon(renderData);
	            	break;
	            
	            case 'Energy Consumption':
	            	drawEnergy(renderData);
	            	break;
	            }
	            break;
	          }

	        }
	        		
	</script>

	If you require further details shown on this report please email
	energycertificate@dhl.com

</body>
</html>
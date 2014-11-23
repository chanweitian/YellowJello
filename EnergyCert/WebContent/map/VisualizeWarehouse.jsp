<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,visual.*"%>
<%@include file="../protectusers.jsp"%>

<!DOCTYPE html>
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

<!--  Maps -->
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>

<script type="text/javascript">

<%
	// retrieve Info
	//Only if there is information then show.
	String companyName = (String) request.getAttribute("company");
	ArrayList<String> years = (ArrayList<String>) request.getAttribute("years");
	boolean status = true;
	if (years.size()==0){
		status = false;
	}
	//convert Java ArrayList to js
	
%>
var companyName = "<%=companyName%>";
        	
function getSites(){

	var year = '2013';
	filterValue = 'none';
	request = new XMLHttpRequest(), typeValue = "get",
			urlValue = "GenerateMap?year=" + year + "&company="+ companyName;
	
	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			var result = JSON.parse(request.responseText);

			//console.log(result.sites[0].siteName);
			initialize(JSON.parse(request.responseText).sites);
			
			//return JSON.parse(request.responseText).sites;
		}
	}
	
	request.open('GET', urlValue, true);
	request.send();	
}

function initialize(data) {
	var sites = data;
	
	if (typeof sites[0] == 'undefined') {
		console.log("sites is " + sites[0]);
		
		window.alert = null;
		delete window.alert; // true
		//alert('test'); // win
		alert("Aw, snap!\n\nThere are no sites fulfilling your selected filter(s). Please adjust your filter(s) for better results.");
		
	} else {
		
	console.log("1. Initialize" + sites[0].siteName);
	document.getElementById("loading").style.display = "block";
	
	var geocoder = new google.maps.Geocoder();
    var focus = new google.maps.LatLng(35.0, 103.0),
        markers,
       	myMapOptions = {
            zoom: 3,
            center: focus,
            minZoom: 2,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        map = new google.maps.Map(document.getElementById("map_canvas"), myMapOptions);
    
    function geocodeAddress(data, i, next) {
	    	var coordinates,address;
	    	var address = data[i].address+ "," + data[i].state + "," + data[i].postal;
	    	
	    	console.log("3. geocodeAddress "+ i + " " + data[i].address+ "," + data[i].state + "," + data[i].postal);
			
	    	geocoder.geocode( { 'address': address}, function(results, status) {
		 	    if (status == google.maps.GeocoderStatus.OK) {
		 	    	var latLong = results[0].geometry.location;
		 	   		coordinates = latLong.lat() + "," + latLong.lng();
		 	   		
		 	   		sites[i].latLng = latLong;
		 	   		console.log("4. Geocoded! " + sites[i].siteid + "  " + sites[i].latLng + " " + i);
		 	   		
			 	   	request = new XMLHttpRequest(), typeValue = "get",
			 		urlValue = "updateLonLat.jsp?lon=" + latLong.lng() + "&lat="+ latLong.lat() + "&siteid=" + sites[i].siteid;
			 		
			 		request.open('GET', urlValue, true);
			 		request.send();	
		 	       	
		 	    } else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT){
		 	    	console.log('Geocode of '+address+' was not successful for the following reason: ' + status);
		 	    	
		 	    } else if (status == google.maps.GeocoderStatus.ZERO_RESULTS){
		 	    	alert('Oops sorry! Geocode of '+address+' was not successful because we cannot identify the address given.' );
		 	    } else {
		 	       	alert('Geocode of '+address+' was not successful for the following reason: ' + status);
		 	    }
		 	    
		 	   if(typeof(next) != "undefined"&&i==data.length-1){
		   			next(data);
		   		}
		 	    
			});
    }
    
    var count = 0;             //  set your counter to 1

    function myLoop (data, next) {           //  create a loop function
    	//  call a 3s setTimeout when the loop is called
          //alert('hello');          //  your code here
          
          //sites[count].visible = true;
	    	
	    	if (data[count].energyRating >= 0 && data[count].energyRating < 51){
	    		sites[count].icon = "B.png";
	    	} if (data[count].energyRating >= 51 && data[count].energyRating < 101){
	    		sites[count].icon = "B.png";
	    	} if (data[count].energyRating >= 101 && data[count].energyRating < 151){
	    		sites[count].icon = "E.png";
	    	} if (data[count].energyRating >= 151 && data[count].energyRating < 201){
	    		sites[count].icon = "E.png";
	    	} if (data[count].energyRating >= 201 && data[count].energyRating < 251){
	    		sites[count].icon = "E.png";
	    	} if (data[count].energyRating >= 251 && data[count].energyRating < 301){
	    		sites[count].icon = "G.png";
	    	} if (data[count].energyRating >= 301) {
	    		sites[count].icon = "G.png";
	    	}
	    	
	    	var geocode = false;
	    	if(count == data.length-1){
	    		if (data[count].lon === null || data[count].lat === null) {
	    			geocodeAddress(data, count, next);
	    			geocode = true;
	    		} else {
	    			data[count].latLng = new google.maps.LatLng(data[count].lat, data[count].lon);
	    			if(typeof(next) != "undefined"){
	    	   			next(data);
	    	   		}
	    		}
	    	} else {
	    		if (data[count].lon === null || data[count].lat === null) {
	    			geocodeAddress(data, count);
	    			geocode = true;
	    		} else {
	    			data[count].latLng = new google.maps.LatLng(data[count].lat, data[count].lon);
	    			if(typeof(next) != "undefined"&&count==data.length-2){
	    	   			next(data);
	    	   		}
	    		}
	    	}
          	count++;                     //  increment the counter
          	if (count < data.length) {            //  if the counter < 10, call the loop function
            	if (geocode) {
            		setTimeout(function () {
            			myLoop(data, next);
            		}, 1500);
            	} else {
            		myLoop(data, next);
            	}
          	}
    
    	return data;
    }

    //myLoop(data);
    
    function siteConverter(data, next) {
    	//Geocoding portion - converting postal code to latlng
    	myLoop(data, next);
    	
    	/*
    	
	    for (var i=0; i<data.length; i++){
	    	<!--alert(data[i].energyRating);-->
	    	
	    	sites[i].visible = true;
	    	
	    	if (data[i].energyRating >= 0 && data[i].energyRating < 51){
	    		sites[i].icon = "B.png";
	    	} if (data[i].energyRating >= 51 && data[i].energyRating < 101){
	    		sites[i].icon = "B.png";
	    	} if (data[i].energyRating >= 101 && data[i].energyRating < 151){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating >= 151 && data[i].energyRating < 201){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating >= 201 && data[i].energyRating < 251){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating >= 251 && data[i].energyRating < 301){
	    		sites[i].icon = "G.png";
	    	} if (data[i].energyRating >= 301) {
	    		sites[i].icon = "G.png";
	    	}
	    	
	    	if(i == data.length-1){
	    		geocodeAddress(data, i, next);
	    	} else {
	    		
	    		geocodeAddress(data, i);
	    			
	    	}
	    	
	    	
	    }*/
    	return data;
    }
    
    function initMarkers(map, markerData) {
        var newMarkers = [],
            marker,
            image;
            
        for(var i=0; i<markerData.length; i++) {
        	console.log("6. initMarkers " + markerData.length + " " + markerData[i].latLng + " " +  markerData[i].energyRating);
        	document.getElementById("loading").style.display = "none";
        	
        	marker = new google.maps.Marker({
                map: map,
                position: markerData[i].latLng,
                visible: true,
                icon:"../img/" + markerData[i].icon
            }),
			
            boxText = document.createElement("div"),
            
            //these are the options for all infoboxes
            infoboxOptions = {
                content: boxText,
                disableAutoPan: false,
                maxWidth: 0,
                pixelOffset: new google.maps.Size(-140, 0),
                zIndex: null,
                boxStyle: {
                    background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/examples/tipbox.gif') no-repeat",
                    opacity: 0.75,
                    width: "200px"
                },
                closeBoxMargin: "12px 4px 2px 2px",
                closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
                infoBoxClearance: new google.maps.Size(1, 1),
                isHidden: false,
                pane: "floatPane",
                enableEventPropagation: false
            };
            
            	newMarkers.push(marker);
            
            //define the text and style for all infoboxes
            boxText.style.cssText = "border: 1px solid black; margin-top: 8px; background:#333; color:#FFF; font-family:Arial; font-size:12px; padding: 5px; border-radius:6px; -webkit-border-radius:6px; -moz-border-radius:6px;";
            boxText.innerHTML = "Site Name: " + markerData[i].siteName + "<br>" + "Energy Rating: " + markerData[i].energyRating + "<br>" + "Region: " + markerData[i].region + "<br>" + "Electricity Usage: "  + markerData[i].elec + "<br>" + "Natural Gas Use: " + markerData[i].gas + "<br>" + "Size: " + markerData[i].size;
            
            //Define the infobox
            newMarkers[i].infobox = new InfoBox(infoboxOptions);
            
            //Open box when page is loaded
            //newMarkers[i].infobox.open(map, marker);
            
            //Add event listen, so infobox for marker is opened when user clicks on it.  Notice the return inside the anonymous function - this creates
            //a closure, thereby saving the state of the loop variable i for the new marker.  If we did not return the value from the inner function, 
            //the variable i in the anonymous function would always refer to the last i used, i.e., the last infobox. This pattern (or something that
            //serves the same purpose) is often needed when setting function callbacks inside a for-loop.
            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    newMarkers[i].infobox.open(map, this);
                    map.panTo(markerData[i].latLng);
                }
            })(marker, i));
            
        	
        }
        
        return newMarkers;
    }
   	
    console.log("2. Waiting for site converter");
    
    siteConverter(data, function(sites){
    	console.log("5. Site converter done! Plotting markers");
    	
    	//here the call to initMarkers() is made with the necessary data for each marker.  All markers are then returned as an array into the markers variable
    	markers = initMarkers(map,sites);	
    });    
	}
}

var years = [];
var regionList = [];
var countryList = [];
var master = [];
var year = "";
var selectFilter = "none";
var filterValue = "none";
var axis = "carbon";
var companyName = "<%=companyName%>";
<%	//Pushing the data into years
for(int i = 0; i <years.size(); i++){%>
	years.push(
	<%=years.get(i)%>
	);
	year = <%=years.get(0)%>

<%}%>
// methods for dynamically adding options to text box
var addOption = function(selectbox, text, value) {
	var optn = document.createElement("OPTION");
	optn.text = text;
	optn.value = value;
	selectbox.options.add(optn);
}

var removeOption = function(selectbox) {
	var select = selectbox, option = null, next_desc = null;
	var len = select.options.length;

	for (var i = 0; i < len; i++) {
		select.remove(0);
	}
}

function clear() {
	var a = document.getElementById("country").style.display;
	var b = document.getElementById("region").style.display;
	a.innerHTML = "";
	b.innerHTML = "";
}

function setYear(val) {
	year = val;
}

function yearAndFilter(val) {
	
	switch (val) {
	case 'Country':
		selectFilter = "Country";
		retrieveCountry(val, generateCountryList);
		document.getElementById("country").style.display = "block";
		document.getElementById("region").style.display = "none";
		document.getElementById("rating").style.display = "none";
		document.getElementById("showAll").style.display = "none";
		break;
	case 'Region':
		selectFilter = "Region";
		retrieveRegion(val, generateRegionList);
		document.getElementById("country").style.display = "none";
		document.getElementById("region").style.display = "block";
		document.getElementById("rating").style.display = "none";
		document.getElementById("showAll").style.display = "none";
		break;
	case 'Energy Rating':
		selectFilter = "Rating";
		retrieveRegion(val, generateRegionList);
		document.getElementById("country").style.display = "none";
		document.getElementById("region").style.display = "none";
		document.getElementById("rating").style.display = "block";
		document.getElementById("showAll").style.display = "none";
		break;
	default:
		selectFilter = "none";
		document.getElementById("region").style.display = "none";
		document.getElementById("country").style.display = "none";
		document.getElementById("region").style.display = "none";
		document.getElementById("showAll").style.display = "block";
		break;
	}
}

//goes to the servlet to get relevant countries for a selected year
var retrieveCountry = function(form, callback) {
	var request = new XMLHttpRequest(), typeValue = "get", urlValue = "../visual/retrieveCountry?year="
			+ year;
	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			var result = JSON.parse(request.responseText);
			callback(result);
		}
	}
	request.open('GET', urlValue, true);
	request.send();
}

//goes to the servlet to get relevant regions for a selected year
var retrieveRegion = function(form, callback) {
	var request = new XMLHttpRequest(), typeValue = "get", urlValue = "../visual/retrieveRegion?year="
			+ year;
	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
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
	for ( var i in data) {
		countryList.push(data[i]);
	}
	;
	var countryOptions = document.forms["country"].elements["country"];
	removeOption(countryOptions);
	for (var i = 0; i < countryList.length; ++i) {
		addOption(countryOptions, countryList[i], countryList[i]);
	}
}

//populates the relevant regions in the javascript
var generateRegionList = function(data) {
	regionList = [];

	for ( var i in data) {
		regionList.push(data[i]);
	}
	;
	var regionOptions = document.forms["region"].elements["region"];
	removeOption(regionOptions);
	for (var i = 0; i < regionList.length; i++) {
		addOption(regionOptions, regionList[i], regionList[i]);
	}
}

//retrieve master data with no filter and generate the charts
var generate = function(form) {
	
	var request = '';
	switch (selectFilter) {
	case 'Region':
		filterValue = form.region.value;
		request = new XMLHttpRequest(), typeValue = "get",
				urlValue = "GenerateMap?year=" + year + "&filter="
						+ selectFilter + "&value=" + filterValue + "&company="+companyName;
		break;
	case 'Country':
		filterValue = form.country.value;
		request = new XMLHttpRequest(), typeValue = "get",
				urlValue = "GenerateMap?year=" + year + "&filter="
						+ selectFilter + "&value=" + filterValue + "&company="+companyName;
		break;
	case 'Rating':
		filterValue = form.rating.value;
		request = new XMLHttpRequest(), typeValue = "get",
				urlValue = "GenerateMap?year=" + year + "&filter="
						+ selectFilter + "&value=" + filterValue + "&company="+companyName;
		break;
	case 'none':
		filterValue = 'none';
		request = new XMLHttpRequest(), typeValue = "get",
				urlValue = "GenerateMap?year=" + year + "&filter="
						+ selectFilter + "&value=" + filterValue + "&company="+companyName;
		break;
	}
	;

	request.onreadystatechange = function() {
		if (request.readyState == 4 && request.status == 200) {
			var result = JSON.parse(request.responseText);
			
			initialize(JSON.parse(request.responseText).sites);
			
		}
	}
	request.open('GET', urlValue, true);
	request.send();
}
</script>

<!-- Calling of methods -->
<title>Warehouse Visualization Tool</title>
</head>

<body onload="getSites()">
	<%@include file="../header.jsp"%>
	<br><br><br>
	
	<%
		if(status){
	%>
	
		<div class="form-group">
        	
            <div class="col-md-2 selectContainer">
                <label class="control-label">Select the Year</label>
                <select id="year" onChange="setYear(this.value)" class="form-control">
				<script>
					//dynamically generates dropdown options
					var yearOptions = document.getElementById("year");
		
					for (var i = 0; i < years.length; ++i) {
						addOption(yearOptions, years[i], years[i]);
					}
				</script>
				</select>
            </div>
            
		</div>
		
		<div class="form-group" style="margin-top:-15px;">
        
            <div class="col-lg-4 control-label">
                <label class="control-label">Filter the Data by</label>
                <select id="filter" onChange="yearAndFilter(this.value)" class="form-control">
					<option value="none" selected>No filter (show all data)</option>
					<option>Country</option>
					<option>Region</option>
					<option>Energy Rating</option>
				</select>
            </div>
            
		<form id="country" style="display: none;">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Country Desired</label>
                <select id="country" class="form-control" onchange="if (typeof(this.selectedIndex) != undefined) {generate(this.form); this.blur();}" onfocus="this.selectedIndex = -1;">
				</select>
            </div>
        </form>
        
        <form id="region" style="display: none;">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Region Desired</label>
                <select id="region" class="form-control" onchange="if (typeof(this.selectedIndex) != undefined) {generate(this.form); this.blur();}" onfocus="this.selectedIndex = -1;">
				</select>
            </div>
		</form>
        
        <form id="rating" style="display: none;">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Energy Rating Desired</label>
                <select id="rating" class="form-control" onchange="if (typeof(this.selectedIndex) != undefined) {generate(this.form); this.blur();}" onfocus="this.selectedIndex = -1;">
                <option value="0-51" selected>A</option>
					<option value="51-101">B</option>
					<option value="101-151">C</option>
					<option value="151-201">D</option>
					<option value="201-251">E</option>
					<option value="251-301">F</option>
					<option value="301-999999">G</option>
				</select>
            </div>
            
        </form>
        
        <form id="showAll">
           
        </form>
        	
        	<div style="position: absolute;margin-top: 80px; z-index: 4">
			<font size="2" color="red"> * Plotting of the markers may take some time. Please be patient.</font>
    		</div>
    	</div>
	
	
	<%
		}else{
	%>
	Sorry there is currently no warehouse with completed questionnaire on
	file.
	<br> If you believe you have received this message in error,
	please contact your system administrator.
	<br>
	<%
		}
	
	%>
	<br><br>
	<div id="map_canvas" style="margin-top: 5%;width: 100%;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px; height: 550px; border:1px solid #666; box-shadow: 0px 0px 10px #333;"></div>
	<div style="display:block; z-index:20; position:absolute; top:260px; right:28px;"><img src="../img/map legend.png" alt="Legend" style="width:148px;height:175px;"></div>
	<div id="loading" style="display:block; z-index:20; position:absolute; top:48%; right:46%;"><img src="../img/loading.gif" alt="loading" style="width:170px;height:132px;opacity:0.94;border-radius:50px;"></div>
		
		<script type="text/javascript">
			$(function() {
			    if($.browser.msie) {
			        $("<div/>", {html:"<br>Download Firefox <a href='http://www.mozilla.org/de/firefox/new/'>here</a>.", target:"_blank"}).appendTo("body");
			    }
			});
		</script>
		
</body>
</html>
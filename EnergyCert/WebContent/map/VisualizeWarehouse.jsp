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
	//var data = getSites();
	console.log("Sites in initialize double checking" + sites[0].siteName);
		
	var geocoder = new google.maps.Geocoder();
    var focus = new google.maps.LatLng(-33.9, 151.2),
        markers,
       	myMapOptions = {
            zoom: 3,
            center: focus,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        map = new google.maps.Map(document.getElementById("map_canvas"), myMapOptions);
    
    function geocodeAddress(data, i, next) {
    	var coordinates,address;
    	var address = data[i].postal;
		
    	geocoder.geocode( { 'address': address}, function(results, status) {
	 	    if (status == google.maps.GeocoderStatus.OK) {
	 	    	var latLong = results[0].geometry.location;
	 	   		coordinates = latLong.lat() + "," + latLong.lng();
	 	   		
	 	   		sites[i].latLng = latLong;
	 	   		console.log("geocodeAddresses " + sites[i].siteName + "  " + sites[i].latLng + " " + i);
	 	       	
	 	   		if(typeof(next) != "undefined"){
	 	   			next();
	 	   		}
	 	      
	 	    } else {
	 	       	alert('Geocode of '+address+' was not successful for the following reason: ' + status);
	 	    }
		});
    }
    
    function siteConverter(data, next) {
    	//Geocoding portion - converting postal code to latlng
	    for (var i=0; i<data.length; i++){
	    	<!--alert(data[i].energyRating);-->
	    	
	    	sites[i].visible = true;
	    	
	    	if (data[i].energyRating >= 0 && data[i].energyRating < 51){
	    		sites[i].icon = "B.png";
	    	} if (data[i].energyRating > 50 && data[i].energyRating < 101){
	    		sites[i].icon = "B.png";
	    	} if (data[i].energyRating > 100 && data[i].energyRating < 151){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating > 150 && data[i].energyRating < 201){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating > 200 && data[i].energyRating < 251){
	    		sites[i].icon = "E.png";
	    	} if (data[i].energyRating > 250 && data[i].energyRating < 301){
	    		sites[i].icon = "G.png";
	    	} if (data[i].energyRating > 300) {
	    		sites[i].icon = "G.png";
	    	}
	    	
	    	if(i == data.length-1){
	    		geocodeAddress(data, i, next);
	    	} else {
	    		geocodeAddress(data, i);	   		
	    	}
	    }
    	
    	return data;
    }
    
    function initMarkers(map, markerData) {
        var newMarkers = [],
            marker,
            image;
            
        for(var i=0; i<markerData.length; i++) {
        	console.log("Marker Data " + markerData.length + " " + markerData[i].icon +  markerData[i].energyRating);
            marker = new google.maps.Marker({
                map: map,
                position: markerData[i].latLng,
                visible: markerData[i].visible,
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
                isHidden: !markerData[i].visible,
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
            newMarkers[i].infobox.open(map, marker);
            
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
   	
    console.log("Waiting for site converter first");
    
    siteConverter(data, function(){
    	console.log("Site converter done! Plotting markers");
    	
    	//here the call to initMarkers() is made with the necessary data for each marker.  All markers are then returned as an array into the markers variable
    	markers = initMarkers(map,sites);	
    });    
    
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
        <div class="row">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Year of Visualization</label>
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
	</div>
	
	<div class="form-group">
        <div class="row">
            <div class="col-lg-5 control-label">
                <label class="control-label">Filter the Data by</label>
                <select id="filter" onChange="yearAndFilter(this.value)" class="form-control">
					<option selected>No filter (show all data)</option>
					<option>Country</option>
					<option>Region</option>
				</select>
            </div>
		<form id="country" style="display: none;">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Country Desired</label>
                <select id="country" onChange="" class="form-control">
				</select>
            </div>
            
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Axis Desired:</label>
                 <select id="axis" class="form-control">
					<option>Carbon Emission</option>
					<option>Energy Consumption</option>
				</select>
            </div>
            
            <div style="position:absolute; left:20px; top:315px;">
            <input type="button" class="btn btn-primary" name="button" value="Generate" onClick="generate(this.form)">
            </div>
        </form>
        
        <form id="region" style="display: none;">
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Region Desired</label>
                <select id="region" onChange="" class="form-control">
				</select>
            </div>
            
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Axis Desired:</label>
                <select id="axis" class="form-control">
					<option>Carbon Emission</option>
					<option>Energy Consumption</option>
				</select>
            </div>
            
            <div style="position:absolute; left:20px; top:315px;">
            <input type="button" class="btn btn-primary" name="button" value="Generate" onClick="generate(this.form)">
            </div>
        </form>
        
        <form id="showAll">
            
            <div class="col-md-4 selectContainer">
                <label class="control-label">Select the Axis Desired:</label>
                <select id="axis" class="form-control">
					<option>Carbon Emission</option>
					<option>Energy Consumption</option>
				</select>
            </div>
            <br>
            <div style="position:absolute; left:20px; top:315px;">
            <input type="button" class="btn btn-primary" name="button" value="Generate" onClick="generate(this.form)">
            </div>
        </form>
        </div>
    </div>
	
	<br><br>
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
	
	<div id="map_canvas" style="width: 100%;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px; height: 600px; border:1px solid #666; box-shadow: 0px 0px 10px #333;"></div>
		
		<script type="text/javascript">
			$(function() {
			    if($.browser.msie) {
			        $("<div/>", {html:"<br>Download Firefox <a href='http://www.mozilla.org/de/firefox/new/'>here</a>.", target:"_blank"}).appendTo("body");
			    }
			});
		</script>
		
</body>
</html>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>

<script type="text/javascript">

var sites = [
         	{siteName: "Address 1", region: "State 1" , country: "c1", energyRating: 50, postal: "159961", visible:true},
        	{siteName: "Address 2", region: "State 2" , country: "c2", energyRating: 150, postal: "V6B3P8", visible:true},
         	{siteName: "Address 3", region: "State 3" , country: "c3", energyRating: 400, postal: "530961", visible:true},
        	{siteName: "Address 4", region: "State 1" , country: "c1", energyRating: 50, postal: "100075", visible:true},
        	{siteName: "Address 5", region: "State 2" , country: "c2", energyRating: 150, postal: "510017", visible:true},
         	{siteName: "Address 6", region: "State 3" , country: "c3", energyRating: 400, postal: "112", visible:true}
        	];

function initialize() {
	var geocoder = new google.maps.Geocoder();
    var focus = new google.maps.LatLng(-33.9, 151.2),
        markers,
       	myMapOptions = {
            zoom: 3,
            center: focus,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        map = new google.maps.Map(document.getElementById("map_canvas"), myMapOptions);
    
    function geocodeAddress(siteArray, i, next) {
    	var coordinates,address;
    	address = siteArray[i].postal;
		
    	geocoder.geocode( { 'address': address}, function(results, status) {
	 	    if (status == google.maps.GeocoderStatus.OK) {
	 	    	var latLong = results[0].geometry.location;
	 	   		coordinates = latLong.lat() + "," + latLong.lng();
	 	     	
	 	   		sites[i].latLng = latLong;
	 	   		console.log("geocodeAddresses " + sites[i].siteName + "  " + sites[i].latLng);
	 	       	
	 	   		if(typeof(next) != "undefined"){
	 	   			next();
	 	   		}
	 	      
	 	    } else {
	 	       	alert('Geocode of '+address+' was not successful for the following reason: ' + status);
	 	    }
		});
    }
    
    function siteConverter(siteArray, next) {
    	//Geocoding portion - converting postal code to latlng
	    for (var i=0; i<siteArray.length; i++){
	    	<!--alert(siteArray[i].energyRating);-->
	    	
	    	if (siteArray[i].energyRating > 0 && siteArray[i].energyRating < 51){
	    		sites[i].icon = "B.png";
	    	} if (siteArray[i].energyRating > 50 && siteArray[i].energyRating < 101){
	    		sites[i].icon = "B.png";
	    	} if (siteArray[i].energyRating > 100 && siteArray[i].energyRating < 151){
	    		sites[i].icon = "E.png";
	    	} if (siteArray[i].energyRating > 150 && siteArray[i].energyRating < 201){
	    		sites[i].icon = "E.png";
	    	} if (siteArray[i].energyRating > 200 && siteArray[i].energyRating < 251){
	    		sites[i].icon = "E.png";
	    	} if (siteArray[i].energyRating > 250 && siteArray[i].energyRating < 301){
	    		sites[i].icon = "G.png";
	    	} if (siteArray[i].energyRating > 300) {
	    		sites[i].icon = "G.png";
	    	}

	    	if(i ==  siteArray.length-1){
		    	geocodeAddress(siteArray, i, next);
	    	} else {
		    	geocodeAddress(siteArray, i);	    		
	    	}
	    }
    	
    }
    
    function checkArray(){
		var str;
    	for (var i=0; i<sites.length; i++){
    		alert("checkArray " + sites[i].siteName);
	    	
	    }
    }
    
    function initMarkers(map, markerData) {
        var newMarkers = [],
            marker,
            image;
            
        for(var i=0; i<markerData.length; i++) {
        	
            marker = new google.maps.Marker({
                map: map,
                position: markerData[i].latLng,
                visible: markerData[i].visible,
                icon:"images/" + markerData[i].icon
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
            boxText.innerHTML = "Site Name: " + markerData[i].siteName + "<br>" + "Energy Rating: " + markerData[i].energyRating + "<br>" + "Consumption: "  + markerData[i].country + "<br>" + "Size: " + markerData[i].region + markerData[i].country;
            
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
    
    siteConverter(sites, function(){
    	console.log("Site converter done! Plotting markers");
    	//here the call to initMarkers() is made with the necessary data for each marker.  All markers are then returned as an array into the markers variable
    	markers = initMarkers(map,sites);	
    });    
    
}

function filter(){
	
	
	initialize();
	
}
</script>

<!-- Calling of methods -->
<title>Warehouse Visualization Tool</title>
</head>
<body onload="initialize()">
	<form>
		<select id='country' onchange="filter()">
		  <option value="Address1">A1</option>
		  <option value="Address2">A2</option>
	
		</select>
	</form>
	
	<br>
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
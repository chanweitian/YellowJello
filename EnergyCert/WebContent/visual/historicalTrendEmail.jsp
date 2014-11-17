<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
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

<%-- Questionnaire.jsp --%>
<link href="../css/questionnaire.css" rel="stylesheet">

<%-- Questionnaire validation --%>
<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	

<%
	// retrieve Info
	//Only if there is information then show.
	String site1 = (String) request.getParameter("site");
	String site = site1.replaceAll("_", " ");
%>
<script>
	google.load('visualization', '1.0', {'packages':['table']});
	var site = "<%=site%>";
	var chartSRC = "";
	var tableSRC = "";

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

<title>GTL Historical Site Trend</title>

</head>
<body onload="retrieveWarehouseData(draw)">
	<%@include file="../header.jsp"%>
	<br />
	<br />
	<div class="header">Historical Site Trend</div>
	
	<br>	
	<b>The graph below shows the Historical Trend for site: <%=site%></b><br><br>

	<div style="display: inline-flex;">
	<div id=chart></div>
	<div>
	<br><br><br><br>
		<div id=table></div>
	</div>
	</div>
	<br>
	<script type="text/javascript">
    	google.load('visualization', '1.0', {'packages':['corechart']});

		//goes to the servlet to get relevant questionnaire for the year selected
		var draw = function(result) {
			var siteName = result.sites[0].siteName;

			var data3 = new google.visualization.DataTable();
			data3.addColumn('number', 'Year');
			data3.addColumn('number', siteName);
			
			var data = new google.visualization.DataTable();
		    data.addColumn('number', 'Year');
		    data.addColumn('number', 'Energy Efficiency Rating');
		    data.addColumn('string', 'Grade');	
		    
			for (i = 0; i < result.sites.length; i++) {
				var energyRating = result.sites[i].energyRating;
				var year = result.sites[i].year;
				var grade = result.sites[i].grade;
				data3.addRows(1);
				data3.setCell(i, 0, parseInt(year));
				data3.setCell(i, 1, parseInt(energyRating));
				data.addRows(1);
				data.setCell(i, 0, parseInt(year));
				data.setCell(i, 1, parseInt(energyRating));
				data.setCell(i, 2, String(grade));

			}

			var options = {
				title : 'Historical Site Trend : ' + siteName,
				hAxis: {
					title : 'Year'
					//viewWindow: {
				     //   var maxYrPosition = result.sites.length;
				    //    var maxYr = result.sites[maxYrPosition-1].year;
				     //   var minYr = result.sites[0].year;
					//	min: 2010,
				    //   max: 2014
				    //},
				    //ticks: [2010, 2012, 2014]
				    
				},
				vAxis : {
					title : 'Energy Efficiency Rating'
				},
				legend : '',
				'width' : 800,
				'height' : 480
			};
			
			var chart = new google.visualization.ScatterChart(document
					.getElementById('chart'));
			chart.draw(data3, options);
			
	        var table = new google.visualization.Table(document.getElementById('table'));
	        table.draw(data, {showRowNumber: true});
			
		          table.innerHTML = '<img src="' + chart.getImageURI() + '">';
		          tableSRC = (table.innerHTML);
		      
		          chart.innerHTML = '<img src="' + chart.getImageURI() + '">';
		         chartSRC = (chart.innerHTML);


		}

		var retrieveWarehouseData = function(callback) {
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "warehouseData?warehouse="
					+ site;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					var result = JSON.parse(request.responseText);
					callback(result);
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}
		
	</script>

	<br>
	If you require further details shown on this report please email
	energycertificate@dhl.com

</body>
</html>
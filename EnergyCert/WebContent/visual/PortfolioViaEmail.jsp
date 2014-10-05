<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,visual.*"%>

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

<%
	String year = (String) request.getParameter("year");
	String axis = (String) request.getParameter("axis");
	String filterValue1 = (String) request.getParameter("filterValue");
	String filterValue = filterValue1.replaceAll("_", " ");
	String selectFilter = (String) request.getParameter("filter");
	String company1 = (String) request.getParameter("company");
	String company = company1.replaceAll("_", " ");
%>

<script>
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	
	var year = "<%=year%>";
	var selectFilter = "<%=selectFilter%>";
	var filterValue = "<%=filterValue%>";
	var axis = "<%=axis%>";
	var company = "<%=company%>"
	
	var drawCarbon = function(data) {
		var data3 = new google.visualization.DataTable();
		data3.addColumn('number', 'Carbon');
		for (i = 0; i < data.sites.length; i++) {
			var siteName = data.sites[i].siteName;
			data3.addColumn('number', siteName);
		}
		var j = 1;
		var k = data.sites.length + 1;
		for (i = 0; i < data.sites.length; i++) {
			var siteName = data.sites[i].siteName;
			var energyRating = data.sites[i].energyRating;
			var elecEmi = data.sites[i].elecEmi;
			var gasEmi = data.sites[i].gasEmi;
			var elec = Number(data.sites[i].elec);
			var gas = Number(data.sites[i].gas);
			var totalConsp = gas + elec;
			var totalEmi = gasEmi + elecEmi;
			data3.addRows(1);
			data3.setCell(i, 0, parseInt(totalEmi));
			data3.setCell(i, j, parseInt(energyRating));
			j++;

		}
		var options = {
			title : 'Warehouse Portfolio',
			hAxis : {
				title : 'Carbon Emission'
			},
			vAxis : {
				title : 'Efficiency Rating'
			},
			legend : '',
			'width' : 1024,
			'height' : 720
		};

		var chart = new google.visualization.ScatterChart(document
				.getElementById('chart'));

		chart.draw(data3, options);

	}

	var drawEnergy = function(data) {
		var data3 = new google.visualization.DataTable();
		data3.addColumn('number', 'Energy');
		for (i = 0; i < data.sites.length; i++) {
			var siteName = data.sites[i].siteName;
			data3.addColumn('number', siteName);
		}
		var j = 1;
		var k = data.sites.length + 1;
		for (i = 0; i < data.sites.length; i++) {
			var siteName = data.sites[i].siteName;
			var energyRating = data.sites[i].energyRating;
			var elecEmi = data.sites[i].elecEmi;
			var gasEmi = data.sites[i].gasEmi;
			var elec = Number(data.sites[i].elec);
			var gas = Number(data.sites[i].gas);
			var totalConsp = gas + elec;
			var totalEmi = gasEmi + elecEmi;
			data3.addRows(1);
			data3.setCell(i, 0, parseInt(totalConsp));
			data3.setCell(i, j, parseInt(energyRating));
			j++;
		}

		var options = {
			title : 'Warehouse Portfolio',
			hAxis : {
				title : 'Energy Consumption'
			},
			vAxis : {
				title : 'Efficiency Rating'
			},
			legend : '',
			'width' : 1024,
			'height' : 720
		};

		var chart = new google.visualization.ScatterChart(document
				.getElementById('chart'));

		chart.draw(data3, options);

	}

	//retrieve master data with no filter and generate the charts
	function generate() {
		var request = '';
		var urlValue = '';
		switch (selectFilter) {
		case 'Region':
			request = new XMLHttpRequest(), typeValue = "get",
					urlValue = "generate?year=" + year + "&filter="
							+ selectFilter + "&value=" + filterValue + "&company="+companyName;
			break;
		case 'Country':
			request = new XMLHttpRequest(), typeValue = "get",
					urlValue = "generate?year=" + year + "&filter="
							+ selectFilter + "&value=" + filterValue + "&company="+companyName;
			break;
		case 'none':

			request = new XMLHttpRequest(), typeValue = "get",
					urlValue = "generate?year=" + year + "&filter="
							+ selectFilter + "&value=" + filterValue + "&company="+companyName;
			break;
		}
		;
		
		request.onreadystatechange = function() {
			if (request.readyState == 4 && request.status == 200) {
				var result = JSON.parse(request.responseText);
				if (axis == 'carbon') {
					drawCarbon(result);
				} else {
					drawEnergy(result);
				}
			}
		}
		request.open('GET', urlValue, true);
		request.send();
	}


</script>

	
<title>GTL Site Portfolio Overview</title>

</head>
<body onload="generate()">
	<%@include file="../header.jsp" %>
	<br>
	<div class="header">
		View Site Portfolio</div>
	<br>	
	<b>The graph below shows the Site Portfolio for:</b><br><br>
	
	<table>
	<tr>
		<td style="width:250px;"><b>Year: </b></td><td><%=year %></td>
	</tr>
	<tr>
	<td><b>Filter (Country/Region/None): </b></td><td><%=selectFilter%></td>
	</tr>
	<% if (selectFilter.equals("Country")) { %>
		<tr><td><b>Selected Country: </b></td> <td><%=filterValue%></td></tr>
	<% } else if (selectFilter.equals("Region")) {%>
		<tr><td><b>Selected Region: </b></td> <td><%=filterValue%></td></tr>
	<% } %>
	</table>
	<div id=chart></div>

	<br> If you require further details shown on this report please
	email energycertificate@dhl.com
</body>
</html>
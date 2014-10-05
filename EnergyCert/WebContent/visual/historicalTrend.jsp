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
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<%-- Questionnaire.jsp --%>

<script type="text/javascript" src="../js/d3min.js"></script>
<script type="text/javascript" src="../js/scatter.js"></script>

<%
	// retrieve Info
	//Only if there is information then show.
	ArrayList<String> warehouses = (ArrayList<String>) request.getAttribute("warehouses");
	boolean status = true;
	if (warehouses.size()==0){
		status = false;
	}
	//convert Java ArrayList to js
%>
<script>
	var warehouses = [];
	var master = [];
	var warehouse = "";
<%//Pushing the data into years
	for(int i = 0; i <warehouses.size(); i++){%>
	warehouses.push(
<%=warehouses.get(i)%>
	);
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

<title>GTL Warehouse Portfolio Overview</title>

</head>
<body>
	<%@include file="../header.jsp"%>
	<br />
	<br />
	<div class="header">Historical Warehouse Trend</div>

	<%
		if(status){
	%>
	<form name="form1" action="" method="get">
		Please select the warehouse desired for visualisation: <select
			id="warehouse">
			<script>
				//dynamically generates dropdown options
				var warehouseOptions = document.forms["form1"].elements["warehouse"];

				for (var i = 0; i < warehouses.length; ++i) {
					addOption(warehouseOptions, warehouses[i], warehouses[i]);
				}
			</script>
		</select> <br> <input type="button" name="button" value="Generate"
			onClick="warehouseSelection(this.form)">
	</form>
	<br>

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
		//goes to the servlet to get relevant questionnaire for the year selected
		var draw = function(data){
			
		}
		
		var retrieveWarehouseData = function(callback) {
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "warehouseData?warehouse="
					+ warehouse;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					var result = JSON.parse(request.responseText);
					callback(result);
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}

		//logic for showing the relevant section after filling in form 1
		function warehouseSelection(form) {
			warehouse = null;
			warehouse = form.warehouse.value;
			retrieveWarehouseData(draw);

		}
	</script>

	If you require further details shown on this report please email
	energycertificate@dhl.com

</body>
</html>
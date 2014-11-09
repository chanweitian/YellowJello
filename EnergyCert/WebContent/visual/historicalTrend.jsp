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
	String company = (String) request.getAttribute("company");
	ArrayList<String> warehouses1 = (ArrayList<String>) request.getAttribute("warehouses");
	boolean status = true;
	if (warehouses1 == null){
		status = false;
	}
	//convert Java ArrayList to js
%>
<script>
	google.load('visualization', '1.0', {'packages':['table']});
	var warehouses =[];
	var warehouse = "";
	var company = "<%=company%>";
	var chartSRC = "";
	var tableSRC = "";
<%//Pushing the data into dropdown
	if(status == true){
	for(int i = 0; i <warehouses1.size(); i++){%>
	warehouses.push("<%=warehouses1.get(i)%>");
	
<%}}%>
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
<body>
	<%@include file="../header.jsp"%>
	<br />
	<br />
	<div class="header">Historical Site Trend</div>

	<%
		if(status){
	%>
	<form name="form1" action="" method="get"  class="form-horizontal">
		
		<div class="form-group">
        <div class="row">
		
			<div class="form-group" style="width: 50%; float: left;">
	        	<label class="col-lg-5 control-label">Select the site desired for visualisation</label>
	        	<div class="col-lg-6">
				<select id="warehouse" class="form-control">
				<script>
					//dynamically generates dropdown options
					var warehouseOptions = document.forms["form1"].elements["warehouse"];
	
					for (var i = 0; i < warehouses.length; ++i) {
						addOption(warehouseOptions, warehouses[i], warehouses[i]);
					}
				</script>
				</select>
				</div>
			</div>
			<input type="button" name="button" class="btn btn-primary" value="Generate"
			onClick="warehouseSelection(this.form)">
		</div>
		</div> 
		
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
					+ warehouse;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					var result = JSON.parse(request.responseText);
					document.getElementById("share").style.display = "block";
					callback(result);
				}
			}
			request.open('GET', urlValue, true);
			request.send();
		}

		//logic for showing the relevant section after filling in form 1
		function warehouseSelection(form) {
			warehouse = form.warehouse.value;
			retrieveWarehouseData(draw);
		}
		
		var sendEmail = function(form) {
			var email = form.Email.value;
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "emailWarehouseData?site="
					+ warehouse + "&chartSRC="+ chartSRC + "&email= " + email;
			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					var result = JSON.parse(request.responseText);
					emailSuccess();
				}
			}
			request.open('get', urlValue, true);
			request.send();
		}
		
		var emailSuccess = function(){
			$('#emailModal').modal('show');
		}
	</script>

	<form id="share" style="display: none;" action="" method="">
		<div class="form-group">
			<div class="row">
				<div class="col-md-5">
					<label class="control-label">To share this chart, please
						enter the email address of the intended receipient:</label> <input
						type="text" id="Email" class="form-control"
						placeholder="Enter receipient's email">
				</div>
			</div>
		</div>
		<div class="col-md-0">
			<input type="button" id="emailBtn" class="btn btn-primary"
				onClick="sendEmail(this.form)" value="Email">
		</div>
	</form>
	<br>
	If you require further details shown on this report please email
	energycertificate@dhl.com

</body>

<%-- Modal --%>
<div class="modal fade" id="emailModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="left: 0px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">x</button>
				<h4 class="modal-title">Email Sent</h4>
			</div>

			<div class="modal-body">
				<!-- The form is placed inside the body of modal -->
				Your email has been successfully sent!
			</div>
		</div>
	</div>
</div>


<style type="text/css">
/* Adjust feedback icon position */
#share .form-control-feedback {
	right: 15px;
}
</style>

<script>
	$(document).ready(function() {
		$('#share').bootstrapValidator({

			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				email : {
					selector : '[id="Email"]',
					validators : {
						notEmpty : {
							message : 'This field is required'
						},
						emailAddress : {
							message : 'This is not a valid email address'
						}
					}
				}
			}
		}).on('error.field.bv', function(e, data) {
			console.log('error.field.bv -->', data);
			document.getElementById("emailBtn").disabled = true;
		}).on('success.field.bv', function(e, field, $field) {
			console.log(field, $field, '-->success');
			document.getElementById("emailBtn").disabled = false;
		});
	});
</script>
</html>
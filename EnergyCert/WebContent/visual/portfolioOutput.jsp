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
<link href="../css/questionnaire.css" rel="stylesheet">

<%-- Questionnaire validation --%>
<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	

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
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	var years = [];
	var regionList = [];
	var countryList = [];
	var master = [];
	var year = "";
	var selectFilter = "none";
	var filterValue = "none";
	var axis = "carbon";
<%//Pushing the data into years
	for(int i = 0; i <years.size(); i++){%>
	years.push(
<%=years.get(i)%>
	);
	year =
<%=years.get(0)%>
	
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
	<div class="header">Manage Site Portfolio</div>

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
            <div class="col-md-4 selectContainer">
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

	<div id=chart></div>

	<script type="text/javascript">
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
		var generate = function(form) {
			switch (form.axis.value){
			case 'Carbon Emission':
				axis = 'carbon'
				break;
			case 'Energy Consumption':
				axis = 'energy'
				break;
			};
			var request = '';
			switch (selectFilter) {
			case 'Region':
				filterValue = form.region.value;
				request = new XMLHttpRequest(), typeValue = "get",
						urlValue = "generate?year=" + year + "&filter="
								+ selectFilter + "&value=" + filterValue;
				break;
			case 'Country':
				filterValue = form.country.value;
				request = new XMLHttpRequest(), typeValue = "get",
						urlValue = "generate?year=" + year + "&filter="
								+ selectFilter + "&value=" + filterValue;
				break;
			case 'none':
				filterValue = 'none';
				request = new XMLHttpRequest(), typeValue = "get",
						urlValue = "generate?year=" + year + "&filter="
								+ selectFilter + "&value=" + filterValue;
				break;
			}
			;

			request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {
					var result = JSON.parse(request.responseText);
					if (axis == 'carbon') {
						document.getElementById("share").style.display = "block";
						drawCarbon(result);

					} else {
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
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "retrieveCountry?year="
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
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "retrieveRegion?year="
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
		
		var sendEmail = function(form) {
			var email = form.Email.value;
			var request = new XMLHttpRequest(), typeValue = "get", urlValue = "portfolioEmail?year="
					+ year + "&filter="+ selectFilter + "&filterValue="+ filterValue +"&axis="+ axis + "&email=" + email
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
				document.getElementById("showAll").style.display = "none";
				break;
			case 'Region':
				selectFilter = "Region";
				retrieveRegion(val, generateRegionList);
				document.getElementById("country").style.display = "none";
				document.getElementById("region").style.display = "block";
				document.getElementById("showAll").style.display = "none";
				break;
			default:
				selectFilter = "none";
				document.getElementById("region").style.display = "none";
				document.getElementById("country").style.display = "none";
				document.getElementById("showAll").style.display = "block";
				break;
			}

		}
	</script>
	
	<form id="share" style="display: none;" action="" method="">
	 <div class="form-group">
        <div class="row">
            <div class="col-md-5">
                <label class="control-label">To share this chart, please enter the email address of the intended receipient:</label>
				<input type="text" id="Email" class="form-control" placeholder="Enter receipient's email">
            </div>
		</div>
    </div>
 	<div class="col-md-0">
		<input type="button" id="emailBtn" class="btn btn-primary" onClick = "sendEmail(this.form)" value="Email">
	</div>
	</form>
	
	<br> If you require further details shown on this report please
	email energycertificate@dhl.com
</body>

<%-- Modal --%>
<div class="modal fade" id="emailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="left:0px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
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
    	
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
    		email: {
            	selector: '[id="Email"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    emailAddress: {
                        message: 'This is not a valid email address'
                    }
                }
            } 
        }
    })
    .on('error.field.bv', function(e, data) {
	    console.log('error.field.bv -->', data);
	    document.getElementById("emailBtn").disabled = true; 
	})
	.on('success.field.bv', function(e, field, $field) {
		console.log(field, $field, '-->success');
		document.getElementById("emailBtn").disabled = false; 
    });
});
</script>
</html>
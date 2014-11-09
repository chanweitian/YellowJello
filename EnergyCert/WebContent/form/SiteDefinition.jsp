<%-- Questionnaire.jsp before validation is added --%>
<%@page import="java.util.*,utility.*,java.sql.ResultSet,db.*" %>
<%@include file="../protectusers.jsp" %>

<%-- Get previous year --%>
<%
String company = (String) session.getAttribute("company");
int month = PeriodManager.getMonthInt(company);
Calendar cal = Calendar.getInstance();
cal.set(Calendar.MONTH,month);
cal.set(Calendar.DATE,1);
Calendar today = Calendar.getInstance();
int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
if (today.before(cal)) {
	previousYear -= 1;
}
String site_id = request.getParameter("site_id");

//check if there is past data for this site
String where = "site_id = \'" + request.getParameter("site_id") + "\' and year = \'" + (previousYear-1) + "\'";
RetrievedObject ro = SQLManager.retrieveRecords("questionnaire", where);
ResultSet rs = ro.getResultSet();
if (rs.next() ) {  
	System.out.println("!!!!");
	request.setAttribute("hasPastData","true");
	RequestDispatcher rd = request.getRequestDispatcher("processsitedef");
	rd.forward(request, response);
}


%>

<!DOCTYPE html>
<html lang="en">
	<head>
	
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>GTL Energy Certificate Questionnaire</title>
		
		<%-- JQuery script --%>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		
		
		
		<%-- Questionnaire validation --%>
		<link rel="stylesheet" href="../css/bootstrap.css"/>
		<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	
		<script type="text/javascript" src="../js/bootstrapValidator.js"></script>	
		<script type="text/javascript" src="../js/validation.js"></script>	
		
		<%-- This is for SiteInfo.jsp --%>
		<link href="../css/siteInfo.css" rel="stylesheet">
		<script type="text/javascript" src="../js/siteInfo.js"></script>	
		<script type="text/javascript" src="../js/expand.js"></script>	
			
		<%-- Questionnaire.jsp --%>
		<link href="../css/questionnaire.css" rel="stylesheet">
		<script type="text/javascript" src="../js/questionnaire.js"></script>
		
		<%-- This is for SiteDef.jsp --%>
		<script type="text/javascript" src="../js/siteDef.js"></script>

	</head>
  
	<body>
  		<%@include file="../header.jsp" %>
	  	<script type='text/javascript'>
	  		function removeZone(thisZone){
	  			var rowzone, buildingID;
	  			
	  			if (thisZone.id == 'remove1') {
	  	    		rowzone = "rowzone1";
	  	    		buildingID = 'building1';
	  	    	} else if (thisZone.id == 'remove2') {
	  	    		rowzone = "rowzone2";
	  	    		buildingID = 'building2';
	  	    	} else if (thisZone.id == 'remove3') {
	  	    		rowzone = "rowzone3";
	  	    		buildingID = 'building3';
	  	    	} else if (thisZone.id == 'remove4') {
	  	    		rowzone = "rowzone4";
	  	    		buildingID = 'building4';
	  	    	} else if (thisZone.id == 'remove5') {
	  	    		rowzone = "rowzone5";
	  	    		buildingID = 'building5';
	  	    	} else if (thisZone.id == 'remove6') {
	  	    		rowzone = "rowzone6";
	  	    		buildingID = 'building6';
	  	    	}
	  			//remove the whole div of this row
	  			var elem = document.getElementById(rowzone);
	  			elem.parentNode.removeChild(elem);
	  			
	  			//checks how many remove buttons there are, if is last one, disable
                var $zoneclassEle = $('#' + buildingID).find('.zone');
	  			//alert($zoneclassEle);
         		if ($zoneclassEle.size()<=2){
	           		alert($zoneclassEle.eq(0).attr('class') + " " + $zoneclassEle.eq(0).find('button').attr('style'));
	            	$zoneclassEle.eq(0).find('button').attr('style','width:70px;visibility:hidden;')
	        	} 
	  		}
		</script>
	  	<br><br>
	  	<div class="main">
			<div class="header">
	            GTL Energy Certificate Questionnaire
	        </div>

		<div id="site-def-alert" style="width: 35%; padding-left: 2em; display: none;">
			<div id="site-def-alert-text" class="alert alert-danger">
			</div>
		</div>


		<form id="questionnaire" method="post" class="form-horizontal" action="processsitedef">

	        	<input type="hidden" name="site_id" value="<%=site_id %>" />
	        	
	        	<div class="container">
			    <div class="row">
			        <!-- form: -->
			        <section>
			        	<div>
			                <div class="page-header" style="padding-left:0em;">
			                    <img src="../icons/icon_definition.png" height="5%" width="5%">&nbsp;&nbsp;Site Definition
			                </div>
			
			                    <h5><font color="red">* Required</font></h5><br>
			                    <div id="buildingButtons" style="display:inline-flex;">
				                    <div class="form-group" style="padding-right:2em;">
				                    	<div class="col-lg-4">
				                            <button type="button" id="add_building" class="btn btn-info addBuildingButton" style="width:150px;">Add New Building</button>
				                        </div>
									</div>
								
									<div class="form-group" style="padding-right:2em;">
				                    	<div class="col-lg-4">
				                            <button type="button" id="delete_building" class="btn btn-info removeBuildingButton" style="width:170px;display:none;">Remove Last Building</button>
				                        </div>
									</div>
								</div>
			                    
			                    <br><br>
			                    
			                    <%-- Hidden building to be used for cloning --%>
			                    <div id="building0" class="building0 hide">
			              
			                    	<div class="form-group">
										<label id="label_building_name" for="building_name[]" class="col-lg-5 control-label">Building Name <font color="red">*</font></label>
										<div class="col-lg-3">
											<input name="building_name" type="text"  class="form-control" id="building_name" style="width: 270px;"/>
										</div>	
									</div>
									
									<%-- Headings in table --%>
									<div class="zone_headings" style="display:inline-flex;width:100%;">
										<div class="form-group" style="padding-right:2em;width:19%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Name <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:18%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Activity <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:18%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Heating or <br>Cooling <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:17%;">
											<div class="col-lg-12">
												<label id="label_building_name">Min Temp. Set-point (&deg;C) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:17%;">
											<div class="col-lg-12">
												<label id="label_building_name">Max Temp. Set-point (&deg;C) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:16%;">
											<div class="col-lg-12">
												<label id="label_building_name">Months of Zone Operation in <%=previousYear %> <font color="red">*</font></label>
											</div>
										</div>
									</div>
									
				                    <%-- 1st row of zone in table --%>
				                    <div class="zone" id="rowzone0" style="display:inline-flex;width:100%;">
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="test_name" type="text" class="form-control" id="zone_name" style="width: 160px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
							                    <select class="form-control" name="zone_activity[]" id="zone_type" style="width:150px;" onChange="updateHeatingCooling(this)">
							                        <option value="">-- Select one --</option>
							                        <option value="offices">Offices</option>
													<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
													<option value="wh_mezzanine">Warehouse - Mezzanine</option>
													<option value="wh_value_add">Warehouse - Value add</option>
							                    </select>
							                </div>
							            </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
					                        <div class="col-lg-12">
												<select name="zone_heating_cooling[]" class="form-control" id="zone_heating_cooling" style="width: 160px;" onChange="updateMinMaxTemp(this)">
													<option value="">-- Select one --</option>
												</select>
					                        </div>
					                    </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_min_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>
										</div>
										
										<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_max_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
												<select class="form-control" name="zone_operation[]" id="zone_operation" style="width: 150px;">
													<option value="">-- Select one --</option>
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</div>
										</div>
				                    	<div class="form-group" style="padding-right:2em;">
					                    	<div class="col-lg-4">
					                            <button type="button" class="btn btn-default btn-sm removeButton" id="remove0" onclick="removeZone(this)" style="width:70px;visibility:hidden;">Remove</button>
					                        </div>
										</div>    
				                    
				                    </div>
				                   
				                   <%-- Hidden row of zone to be used for cloning --%>
				                    <div class="zone hide" id="zone-container-0" style="display:inline-flex;width:100%;">
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_name[]" type="text" class="form-control" id="zone_name" style="width: 160px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
							                    <select class="form-control" name="zone_activity[]" id="zone_type" style="width:150px;" onChange="updateHeatingCooling(this)">
							                        <option value="">-- Select one --</option>
							                        <option value="offices">Offices</option>
													<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
													<option value="wh_mezzanine">Warehouse - Mezzanine</option>
													<option value="wh_value_add">Warehouse - Value add</option>
							                    </select>
							                </div>
							            </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
					                        <div class="col-lg-12">
												<select name="zone_heating_cooling[]" id="zone_heating_cooling" class="form-control" style="width: 160px;" onChange="updateMinMaxTemp(this)">
													<option value="">-- Select one --</option>
												</select>
					                        </div>
					                    </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_min_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>
										</div>
										
										<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_max_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
												<select class="form-control" name="zone_operation[]" id="zone_operation" style="width: 150px;">
													<option value="">-- Select one --</option>
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</div>
										</div>
				                    
					                  	<div class="form-group" style="padding-right:2em;">
					                    	<div class="col-lg-4">
					                            <button type="button" class="btn btn-default btn-sm removeButton" style="width:70px;">Remove</button>
					                        </div>
										</div>    
				                    </div>
				                    
				                    <div class="form-group" style="padding-right:2em;">
						               	<div class="col-lg-4">
					                      	<button type="button" class="btn btn-default btn-sm addButton" id="button0" style="width:70px;" data-template="textbox">Add</button>
					                  	</div>
									</div>
									
				                    <br><br>
				            	</div>
			                    
			                    <%-- Building 1 --%>
			                    <div id="building1" class="building1">
			                    	<div class="form-group">
										<label id="label_building_name" for="building_name[]" class="col-lg-5 control-label">Building Name <font color="red">*</font></label>
										<div class="col-lg-3">
											<input name="building_name[]" type="text"  class="form-control" id="building_name" style="width: 270px;"/>
										</div>	
									</div>
									
									<%-- Headings in table --%>
									<div class="zone_headings" style="display:inline-flex;width:100%;">
										<div class="form-group" style="padding-right:2em;width:19%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Name <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:18%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Activity <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:18%;">
											<div class="col-lg-12">
												<label id="label_building_name">Zone Heating or <br>Cooling <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:17%;">
											<div class="col-lg-12">
												<label id="label_building_name">Min Temp. Set-point (&deg;C) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:17%;">
											<div class="col-lg-12">
												<label id="label_building_name">Max Temp. Set-point (&deg;C) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:16%;">
											<div class="col-lg-12">
												<label id="label_building_name">Months of Zone Operation in <%=previousYear %> <font color="red">*</font></label>
											</div>
										</div>
									</div>
									
				                    <%-- 1st row of zone in table --%>
				                    <div class="zone" id="rowzone1" style="display:inline-flex;width:100%;">
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="b1_zone_name[]" type="text" class="form-control" id="zone_name" style="width: 160px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
							                    <select class="form-control" name="b1_zone_activity[]" id="zone_type" style="width:150px;" onChange="updateHeatingCooling(this)">
							                        <option value="">-- Select one --</option>
							                        <option value="offices">Offices</option>
													<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
													<option value="wh_mezzanine">Warehouse - Mezzanine</option>
													<option value="wh_value_add">Warehouse - Value add</option>
							                    </select>
							                </div>
							            </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
					                        <div class="col-lg-12">
												<select name="b1_zone_heating_cooling[]" class="form-control" id="zone_heating_cooling" style="width: 160px;" onChange="updateMinMaxTemp(this)">
													<option value="">-- Select one --</option>
												</select>
					                        </div>
					                    </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="b1_zone_min_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>
										</div>
										
										<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="b1_zone_max_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
												<select class="form-control" name="b1_zone_operation[]" id="zone_operation" style="width: 150px;">
													<option value="">-- Select one --</option>
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</div>
										</div>
										
										<div class="form-group" style="padding-right:2em;">
					                    	<div class="col-lg-4">
					                            <button type="button" class="btn btn-default btn-sm removeButton" id="remove1" onclick="removeZone(this)" style="width:70px;visibility:hidden;">Remove</button>
					                        </div>
										</div>   
				                    
				                    </div>
				                   
				                   <%-- Hidden row of zone to be used for cloning --%>
				                    <div class="zone hide" id="zone-container-1" style="display:inline-flex;width:100%;">
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_name[]" type="text" class="form-control" id="zone_name" style="width: 160px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
							                    <select class="form-control" name="zone_activity[]" id="zone_type" style="width:150px;" onChange="updateHeatingCooling(this)">
							                        <option value="">-- Select one --</option>
							                        <option value="offices">Offices</option>
													<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
													<option value="wh_mezzanine">Warehouse - Mezzanine</option>
													<option value="wh_value_add">Warehouse - Value add</option>
							                    </select>
							                </div>
							            </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
					                        <div class="col-lg-12">
												<select name="zone_heating_cooling[]" class="form-control" id="zone_heating_cooling" style="width: 160px;" onChange="updateMinMaxTemp(this)">
													<option value="">-- Select one --</option>
												</select>
					                        </div>
					                    </div>
					                    
					                    <div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_min_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>
										</div>
										
										<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12">
												<input name="zone_max_temp[]" type="text" class="form-control" id="integer" style="width: 140px;"/>
											</div>	
										</div>
										
										<div class="form-group" style="padding-right:2em;">
							                <div class="col-lg-12">
												<select class="form-control" name="zone_operation[]" id="zone_operation" style="width: 150px;">
													<option value="">-- Select one --</option>
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</div>
										</div>
				                    
					                  	<div class="form-group" style="padding-right:2em;">
					                    	<div class="col-lg-4">
					                            <button type="button" class="btn btn-default btn-sm removeButton" style="width:70px;">Remove</button>
					                        </div>
										</div>    
				                    </div>
				                    
				                    <div class="form-group" style="padding-right:2em;">
						            	<div class="col-lg-4">
					                    	<button type="button" class="btn btn-default btn-sm addButton" id="button1" style="width:70px;" data-template="textbox">Add</button>
					                	</div>
									</div>
				                    
				                    <br>
				            	</div>
			            </div>
					</section>
				</div>
			</div> 
	        
	        <div>
		        <div class="col-md-offset-9">
		            <button type="submit" id="generatequest" onclick="submitSiteDefFunction()" class="btn btn-primary">Generate Questionnaire</button>
		        </div>
		    </div>
	       <br><br>
	        </form>
	    </div>
	</body>

</html>

<script>
function submitSiteDefFunction() {
	var form = $('#questionnaire');
	form.submit(function (e) {
		$.ajax({
			type: form.attr('method'),
			url: form.attr('action'),
			data: form.serialize(),
			success: function (data) {
				var result=data;
				//$('#resultAdd').text(result);
				if (data.trim() == "yes") {
					setTimeout(function () {
						window.location.replace("Questionnaire.jsp");
					}, 2000);
				} else {
					var e = document.getElementById('site-def-alert-text');
					var text = "<b>Error!</b> ";
					var data_array = data.split(";");
					for (var x = 0 ; x < data_array.length; x++) {
						text = text + "<br />" + data_array[x];
					}
					e.innerHTML = text;
					document.getElementById('site-def-alert').style.display = 'block';
				}
				
			}
		});
		e.preventDefault(); //STOP default action
		e.unbind(); //unbind. to stop multiple form submit.
		return false;
	});
}
</script>


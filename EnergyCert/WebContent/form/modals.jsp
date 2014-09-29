<%
String q_id = (String) session.getAttribute("quest_id");
String where_modal = "questionnaire_id=\'"+ q_id + "\'";
ro = SQLManager.retrieveRecords("site_definition", where_modal);
ResultSet rs_modal = ro.getResultSet();
%>

<%-- Modal for Add Zone --%>

<div class="modal fade" id="addZoneModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="left:0px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Add Zone</h4>
            </div>

            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form name="add-zone-form" method="POST" action="processaddzone" class="form-horizontal" id="add-zone-form">
				    <div class="form-group">
				        <label class="col-md-5 control-label">Building Name <font color="red">*</font></label>
				        <div class="col-md-5">
					        <select class="form-control" name="building_name" onchange="buildingNameChange(this.value)">
		                        <%
		                        while (rs_modal.next()) {
		                        	String building_name = rs_modal.getString("site_def_building_name");
		                        	String[] b_array = building_name.split("\\*");
		                        	for (String b_name : b_array) {

		                        %>
		                        		<option value="<%=b_name%>"><%=b_name%></option>
								<%
		                        	}
								}
		                        ro.close();
								%>
								<option value="add_new">Select to add new building</option>
		                    </select>
		            	</div>
				    </div>
				    <div id="new_building_name" class="form-group" style="display:none;">
				        <label class="col-md-5 control-label">New Building Name <font color="red">*</font></label>
				        <div class="col-md-5">
				            <input type="text" class="form-control" name="new_building_name" />
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-md-5 control-label">Zone Name <font color="red">*</font></label>
				        <div class="col-md-5">
				            <input type="text" class="form-control" name="zone_name" />
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-md-5 control-label">Zone Activity <font color="red">*</font></label>
				        <div class="col-md-5">
				            <select class="form-control" name="zone_activity" onChange="updateHeatingCooling(this)">
		                        <option value="">-- Select one --</option>
		                        <option value="offices">Offices</option>
								<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
								<option value="wh_mezzanine">Warehouse - Mezzanine</option>
								<option value="wh_value_add">Warehouse - Value add</option>
		                    </select>
       					</div>
				    </div>
				    <div class="form-group">
				    	<label class="col-md-5 control-label">Zone Heating or Cooling <font color="red">*</font></label>
                        <div class="col-md-5">
							<select name="zone_heating_cooling" class="form-control" onChange="updateMinMaxTemp(this)">
								<option value="">-- Select one --</option>
							</select>
                        </div>
                    </div>    
				    <div class="form-group">
				    	<label class="col-md-5 control-label">Min Temp. Set-point (&deg;C) <font color="red">*</font></label>
						<div class="col-md-5">
							<input name="zone_min_temp" type="text" class="form-control"/>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-5 control-label">Max Temp. Set-point (&deg;C) <font color="red">*</font></label>
						<div class="col-md-5">
							<input name="zone_max_temp" type="text" class="form-control"/>
						</div>	
					</div>
					
					<div class="form-group">
						<label class="col-md-5 control-label">Months of Zone Operation in 2013 <font color="red">*</font></label>
		                <div class="col-md-5">
							<select class="form-control" name="zone_operation">
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
				    <div class="form-group">
				        <div class="col-md-5 col-md-offset-5">
				            <button type="submit" onclick="addZoneFunction()" class="btn btn-primary" >Add Zone</button>
				        </div>
				    </div>
				    <div class="form-group">
				        <div class="col-md-5 col-md-offset-5">
				        	<font color="maroon"><div id="resultAdd"></div></font>
				        </div>
				    </div>
				</form>
            </div>
        </div>
    </div>
</div>

<%
RetrievedObject ro_del = SQLManager.retrieveRecords("site_definition", where_modal);
rs_modal = ro_del.getResultSet();
%>

<%-- Modal for Delete Zone --%>

<div class="modal fade" id="deleteZoneModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="left:0px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Delete Zone</h4>
            </div>

			<%
			ArrayList<String> optionList = new ArrayList<String>();
			ArrayList<String> valueList = new ArrayList<String>();
			while (rs_modal.next()) {
             	String site_def_info = rs_modal.getString("site_def_info");
             	String site_def_activity = rs_modal.getString("site_def_activity");
             	String[] b_array = site_def_info.split("\\^");
             	String[] act_array = site_def_activity.split("\\^");
             	for (int i = 0; i < b_array.length; i++) {
             		String b_name = b_array[i];
             		String act_name = act_array[i];
             		String[] z_array = b_name.split("\\*");
             		String[] z_act_array = act_name.split("\\*");
             		for (int j = 0; j < z_array.length; j++) {
             			String z_name = z_array[j];
             			String z_act = z_act_array[j];
             			String option_value = z_name + "//" + z_act;
             			String[] z_name_edit_array = z_name.split("\\-");
             			optionList.add(option_value);
             			valueList.add(z_name_edit_array[1]);
             		}
            	}
			}
            ro_del.close();
			%>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form name="delete-zone-form" method="POST" action="processdeletezone" class="form-horizontal" id="delete-zone-form">
                	<% if (optionList.size() == 1) { %>
                		 Each Questionnaire needs to have <b>at least one building and one zone</b>. You cannot delete any more zone.
                	<% } else { %>
					    <div class="form-group">
					        <label class="col-md-5 control-label">Zone ID <font color="red">*</font></label>
					        <div class="col-md-5">
						        <select class="form-control" name="zone_id">
			                        <%
			                        for (int i = 0; i < optionList.size(); i++) {
			                        %>
			                        	<option value="<%=optionList.get(i)%>"><%=valueList.get(i)%></option>
									<%
									}
									%>
			                    </select>
			            	</div>
					    </div>
					    <div class="form-group">
					        <div class="col-md-5 col-md-offset-5">
					            <button type="submit" onclick="deleteZoneFunction()" class="btn btn-primary" >Delete Zone</button>
					        </div>
					    </div>
					    <div class="form-group">
					        <div class="col-md-5 col-md-offset-5">
					        	<font color="maroon"><div id="resultDelete"></div></font>
					        </div>
					    </div>
					<% } %>
				</form>
            </div>
        </div>
    </div>
</div>

<%-- Modal for Assign Questions --%>
<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="left:0px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h4 class="modal-title">Assign Questions</h4>
            </div>

            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form name="assign-form" method="GET" action="processsendemail" class="form-horizontal" id="assign-form">
				    <div class="form-group">
				        <label class="col-md-5 control-label">Receiver's Name</label>
				        <div class="col-md-5">
				            <input type="text" class="form-control" name="receiver_name" />
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-md-5 control-label">Receiver's Email</label>
				        <div class="col-md-5">
				            <input type="text" class="form-control" name="receiver_email" />
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-md-5 control-label">Message to Receiver</label>
				        <div class="col-md-5">
				            <textarea class="form-control" name="message"></textarea>
				        </div>
				    </div>    
				    <div class="form-group">
						<label class="col-lg-5 control-label" for="sections_assigned">Sections Assigned</label>
						<div class="col-lg-6">
							<div class="checkbox">
								<label><input type="checkbox" name="sections_assigned" value="a" />Site Information</label><br>
								<label><input type="checkbox" name="sections_assigned" value="b" />Usage</label><br>
								<% 
								for (int i = 0; i < zone_list.size(); i++) {
									String[] this_zone = zone_list.get(i).split(",");
									
									String building_name = this_zone[0];
									String zone_name = this_zone[1];
									
									String tab_title = building_name + "_" + zone_name;
									
								%>
									<label><input type="checkbox" name="sections_assigned" value="<%=i%>" /><%=tab_title%></label><br>
								<%
								}
								%>
							</div>
						</div>
					</div>               
				    <div class="form-group">
				        <div class="col-md-5 col-md-offset-5">
				            <button type="submit" class="btn btn-primary">Send Email</button>
				        </div>
				    </div>
				    <div class="form-group">
				        <div class="col-md-5 col-md-offset-5">
				        	<font color="maroon"><div id="result"></div></font>
				        </div>
				    </div>
				</form>
            </div>
        </div>
    </div>
</div>

<script>
function addZoneFunction() {
	var form = $('#add-zone-form');
	form.submit(function (e) {
		$.ajax({
			type: form.attr('method'),
			url: form.attr('action'),
			data: form.serialize(),
			success: function (data) {
				var result=data;
				$('#resultAdd').text(result);
				saveToDb();
				if (data.trim() == "New zone has been added! The page will be reloaded.") {
					setTimeout(function () {
						window.location.replace("Questionnaire.jsp");
					}, 2000);
				}
				
			}
		});
		e.preventDefault(); //STOP default action
		e.unbind(); //unbind. to stop multiple form submit.
		return false;
	});
}

function deleteZoneFunction() {
	//alert("delete");
	var form = $('#delete-zone-form');
	var resultText;
	form.submit(function (e) {
		$.ajax({
			type: form.attr('method'),
			url: form.attr('action'),
			data: form.serialize(),
			success: function (data) {
				var result=data;
				$('#resultDelete').text(result);
				resultText = $('#resultDelete').text();
			}
		});
		e.preventDefault(); //STOP default action
		e.unbind(); //unbind. to stop multiple form submit.
		return false;
	});
	saveToDb();
	setTimeout(function () {
		window.location.replace("Questionnaire.jsp");
	}, 2000);
}

function buildingNameChange(str) {
	if (str == "add_new") {
		document.getElementById('new_building_name').style.display = 'block';
	} else {
		document.getElementById('new_building_name').style.display = 'none';
	}
}

function saveToDb() {
	form = $('#master_form');
	$.ajax({
		url: "processmaster",
		type: "POST",
		data: form.serialize(), // serializes the form's elements.
		beforeSend: function(xhr) {
            // Let them know we are saving
			//$('.form-status-holder').html('Saving...');
			//alert('Saving to the db');
		},
		success: function(data) {
			var jqObj = jQuery(data); // You can get data returned from your ajax call here. ex. jqObj.find('.returned-data').html()
            // Now show them we saved and when we did
            //var d = new Date();
            //$('.form-status-holder').html('Saved! Last: ' + d.toLocaleTimeString());
		},
	});
}
</script>

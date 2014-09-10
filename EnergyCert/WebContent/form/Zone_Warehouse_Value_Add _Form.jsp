
<%
	//String building_name = request.getParameter("building_name");
	//String zone_name = request.getParameter("zone_name");

	String building3 = (String) session.getAttribute("building_name");
	String zone3 = (String) session.getAttribute("zone_name");

	String identifier = "-" + building3 + "_" + zone3;
	
	String zone_id_wva = session.getAttribute("quest_id") + identifier;
	
	String where_wva = "zone_id = \'" + zone_id_wva + "\'";
	RetrievedObject ro_wva = SQLManager.retrieveRecords("warehouse_value_add_form", where_wva);
	ResultSet rs_wva = ro_wva.getResultSet();
	
	String zone_operationalhrs_mon = "";
	String zone_operationalhrs_tues = "";
	String zone_operationalhrs_wed = "";
	String zone_operationalhrs_thurs = "";
	String zone_operationalhrs_fri = "";
	String zone_operationalhrs_sat = "";
	String zone_operationalhrs_sun = "";
	String zone_floorarea = "";
	String zone_numoffloors = "";
	String zone_numofmanualws = "";
	String zone_manualpower = "";
	String zone_numoflightws = "";
	String zone_lightpower = "";
	String zone_numofheavyws = "";
	String zone_heavypower = "";
	String zone_lighting = "";
	String zone_fluorescent_tube = "";
	String zone_t8_ballasttype = "";
	String zone_lightcontroltype = "";
	
	while(rs_wva.next()) {
		zone_operationalhrs_mon = rs_wva.getString("zone_operationalhrs_mon");
		zone_operationalhrs_tues = rs_wva.getString("zone_operationalhrs_tues");
		zone_operationalhrs_wed = rs_wva.getString("zone_operationalhrs_wed");
		zone_operationalhrs_thurs = rs_wva.getString("zone_operationalhrs_thurs");
		zone_operationalhrs_fri = rs_wva.getString("zone_operationalhrs_fri");
		zone_operationalhrs_sat = rs_wva.getString("zone_operationalhrs_sat");
		zone_operationalhrs_sun = rs_wva.getString("zone_operationalhrs_sun");
		zone_floorarea = rs_wva.getString("zone_floorarea");
		zone_numoffloors = rs_wva.getString("zone_numoffloors");
		zone_numofmanualws = rs_wva.getString("zone_numofmanualws");
		zone_manualpower = rs_wva.getString("zone_manualpower");
		zone_numoflightws = rs_wva.getString("zone_numoflightws");
		zone_lightpower = rs_wva.getString("zone_lightpower");
		zone_numofheavyws = rs_wva.getString("zone_numofheavyws");
		zone_heavypower = rs_wva.getString("zone_heavypower");	
		zone_lighting = rs_wva.getString("zone_lighting");
		zone_fluorescent_tube = rs_wva.getString("zone_fluorescent_tube");
		zone_t8_ballasttype = rs_wva.getString("zone_t8_ballasttype");
		zone_lightcontroltype = rs_wva.getString("zone_lightcontroltype");
	}
	ro_wva.close();
	
%>
<div class="section">
	<div class="container">
		<div class="row">
			<!-- form: -->
			<section>
				<div>
					<div class="page-header">
						<img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=building3%>_<%=zone3%>:
						Warehouse - Value add
					</div>
					<div id="wrapper">
						<div id="content">
						<h5><font color="red">* Required</font></h5>
						
							<div class="demo">
								<div class="form-group">
								<label style="margin-left:4.5%">How many hours per day is this zone typically operational for?</label>
								<br>
								<br>
									<label class="col-lg-5 control-label">Monday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_mon<%=identifier%>" value="<%=zone_operationalhrs_mon%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Tuesday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_tues<%=identifier%>" value="<%=zone_operationalhrs_tues%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Wednesday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_wed<%=identifier%>" value="<%=zone_operationalhrs_wed%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Thursday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_thurs<%=identifier%>" value="<%=zone_operationalhrs_thurs%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Friday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_fri<%=identifier%>" value="<%=zone_operationalhrs_fri%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Saturday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_sat<%=identifier%>" value="<%=zone_operationalhrs_sat%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Sunday <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="hours_per_day"
											name="zone_operationalhrs_sun<%=identifier%>" value="<%=zone_operationalhrs_sun%>" />
									</div>
								</div>
								<hr>
								<div class="form-group">
									<label class="col-lg-5 control-label">What is the total	floor area of this zone? <font color="red">* </font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers"
											name="zone_floorarea<%=identifier%>" value="<%=zone_floorarea%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">How many floors does this zone occupy? <font color="red">* </font></label><br>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers"
											name="zone_numoffloors<%=identifier%>" value="<%=zone_numoffloors%>" />
									</div>
								</div>
								<hr>
								<div class="form-group">
								<label style="margin-left:4.5%">How many work stations are in this zone and what are their power consumption? (Modify default work station power consumption if actual values are known)</label>
								<br>
								<br>
									<label class="col-lg-5 control-label">Number: Manual (E.g. Co packing)</label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers_opt"
											name="zone_numofmanualws<%=identifier%>" value="<%=zone_numofmanualws%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Power (watts) per	work station: Manual (E.g. Co packing)</label>
									<br>
									<div class="col-lg-6">
										<% if (zone_manualpower.equals("")) { %>
											<input type="text" class="form-control" id="numbers_opt" value="0" name="zone_manualpower<%=identifier%>" />
										<% } else { %>
											<input type="text" class="form-control" id="numbers_opt" name="zone_manualpower<%=identifier%>" value="<%=zone_manualpower%>" />
										<% } %>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Number: Light (E.g. Testing, Simcard flashing)</label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers_opt"
											name="zone_numoflightws<%=identifier%>" value="<%=zone_numoflightws%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Power (watts) per work station: Light (E.g. Testing, Simcard flashing)</label>
									<div class="col-lg-6">
										<% if (zone_lightpower.equals("")) { %>
											<input type="text" class="form-control" id="numbers_opt" value="200" name="zone_lightpower<%=identifier%>" />
										<% } else { %>
											<input type="text" class="form-control" id="numbers_opt" name="zone_lightpower<%=identifier%>" value="<%=zone_lightpower%>" />
										<% } %>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Number: Heavy (E.g. Manufacturing, Automated packaging)</label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers_opt"
											name="zone_numofheavyws<%=identifier%>" value="<%=zone_numofheavyws%>" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Power (watts) per	work station: Heavy (E.g. Manufacturing, Automated packaging)</label>
									<div class="col-lg-6">
										<% if (zone_heavypower.equals("")) { %>
											<input type="text" class="form-control" id="numbers_opt" value="400" name="zone_heavypower<%=identifier%>" />
										<% } else { %>
											<input type="text" class="form-control" id="numbers_opt" name="zone_heavypower<%=identifier%>" value="<%=zone_heavypower%>" />
										<% } %>
									</div>
								</div>
								<hr>
								<div class="form-group">
									<label class="col-lg-5 control-label">What is the main type of warehouse lighting installed? <font color="red">* </font></label>
									<div class="col-lg-6">
										<select class="form-control" id="zone_wva_lighting"
											name="zone_lighting<%=identifier%>">
										<% if (zone_lighting.equals("")) { %>
											<option value="" selected>-- Select one --</option>
										<% } else { %>
											<option value="">-- Select one --</option>
										<% } %>
										<% if (zone_lighting.equals("LED")) { %>
											<option value="LED" selected>LED</option>
										<% } else { %>
											<option value="LED">LED</option>
										<% } %>
										<% if (zone_lighting.equals("Halogen")) { %>
											<option value="Halogen" selected>Halogen</option>
										<% } else { %>
											<option value="Halogen">Halogen</option>
										<% } %>
										<% if (zone_lighting.equals("Fluorescent tube")) { %>
											<option value="Fluorescent tube" selected>Fluorescent tube</option>
										<% } else { %>
											<option value="Fluorescent tube">Fluorescent tube</option>
										<% } %>
										<% if (zone_lighting.equals("Others")) { %>
											<option value="Others" selected>Others</option>
										<% } else { %>
											<option value="Others">Others</option>
										<% } %>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">If fluoresent	what are the main type of tubes are installed?</label>
									<div class="col-lg-6">
										<select class="form-control" id="fluoresent_tube_installed"
											name="zone_fluorescent_tube<%=identifier%>">
										<% if (zone_fluorescent_tube.equals("")) { %>
											<option value="" selected>-- Select one --</option>
										<% } else { %>
											<option value="">-- Select one --</option>
										<% } %>
										<% if (zone_fluorescent_tube.equals("T12")) { %>
											<option value="T12" selected>T12</option>
										<% } else { %>
											<option value="T12">T12</option>
										<% } %>									
										<% if (zone_fluorescent_tube.equals("T8")) { %>
											<option value="T8" selected>T8</option>
										<% } else { %>
											<option value="T8">T8</option>
										<% } %>	
										<% if (zone_fluorescent_tube.equals("T5")) { %>
											<option value="T5" selected>T5</option>
										<% } else { %>
											<option value="T5">T5</option>
										<% } %>
										<% if (zone_fluorescent_tube.equals("Compact")) { %>
											<option value="Compact" selected>Compact</option>
										<% } else { %>
											<option value="Compact">Compact</option>
										<% } %>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">If T8 tubes are used, what type of ballast is installed?</label>
									<div class="col-lg-6">
										<select class="form-control" id="ballast"
											name="zone_t8_ballasttype<%=identifier%>">
										<% if (zone_t8_ballasttype.equals("")) { %>
											<option value="" selected>-- Select one --</option>
										<% } else { %>
											<option value="">-- Select one --</option>
										<% } %>
										<% if (zone_t8_ballasttype.equals("Magnetic/Wire wound")) { %>
											<option value="Magnetic/Wire wound" selected>Magnetic/Wire wound</option>
										<% } else { %>
											<option value="Magnetic/Wire wound">Magnetic/Wire wound</option>
										<% } %>
										<% if (zone_t8_ballasttype.equals("Electronic/High frequency")) { %>
											<option value="Electronic/High frequency" selected>Electronic/High frequency</option>
										<% } else { %>
											<option value="Electronic/High frequency">Electronic/High frequency</option>
										<% } %>
										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">What type of control is used on this zone's main warehouse lighting system?</label>
									<div class="col-lg-6">
										<select class="form-control" id="zone_wva_light_control"
											name="zone_lightcontroltype<%=identifier%>">
										<% if (zone_lightcontroltype.equals("")) { %>
											<option value="" selected>-- Select one --</option>
										<% } else { %>
											<option value="">-- Select one --</option>
										<% } %>
										<% if (zone_lightcontroltype.equals("Manual")) { %>
											<option value="Manual" selected>Manual</option>
										<% } else { %>
											<option value="Manual">Manual</option>
										<% } %>
										<% if (zone_lightcontroltype.equals("Occupancy")) { %>
											<option value="Occupancy" selected>Occupancy</option>
										<% } else { %>
											<option value="Occupancy">Occupancy</option>
										<% } %>
										<% if (zone_lightcontroltype.equals("Daylight Sensors")) { %>
											<option value="Daylight Sensors" selected>Daylight Sensors</option>
										<% } else { %>
											<option value="Daylight Sensors">Daylight Sensors</option>
										<% } %>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
			</section>
		</div>
	</div>
	<div class="btn-group" style="margin-left:77%">
		<button class="btn" id="prevtab" type="button" onclick="prev_tab();">Previous</button>
    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
    	
	</div>
</div>
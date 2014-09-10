
<%
	String building2 = (String) session.getAttribute("building_name");
	String zone2 = (String) session.getAttribute("zone_name");

	String identifier = "-" + building2 + "_" + zone2;
	
	String zone_id_gtr = session.getAttribute("quest_id") + identifier;
	
	String where_gtr = "zone_id = \'" + zone_id_gtr + "\'";
	RetrievedObject ro_gtr = SQLManager.retrieveRecords("ground_to_roof_form", where_gtr);
	ResultSet rs_gtr = ro_gtr.getResultSet();
	
	String zone_operationalhrs_mon = "";
	String zone_operationalhrs_tues = "";
	String zone_operationalhrs_wed = "";
	String zone_operationalhrs_thurs = "";
	String zone_operationalhrs_fri = "";
	String zone_operationalhrs_sat = "";
	String zone_operationalhrs_sun = "";
	String zone_floorarea = "";
	String zone_zoneprop_narrow = "";
	String zone_zoneprop_wide = "";
	String zone_zoneprop_open = "";
	String zone_height = "";
	String zone_sorting_conveyor = "";
	String zone_ismotordrivenconveyor = "";
	String zone_conveyor_hours = "";
	String zone_conveyor_isturnedoff = "";
	String zone_hasskylights = "";
	String zone_isskylightsufficient = "";
	String zone_isskylightcleaned = "";
	String zone_lighting = "";
	String zone_fluorescent_tube = "";
	String zone_t8_ballasttype = "";
	String zone_powerrating = "";
	String zone_numoflightings = "";
	String zone_lightcontroltype = "";
	String zone_ismanuallyturnedoff = "";
	String zone_hasradiantheaters = "";
	
	while(rs_gtr.next()) {
		zone_operationalhrs_mon = rs_gtr.getString("zone_operationalhrs_mon");
		zone_operationalhrs_tues = rs_gtr.getString("zone_operationalhrs_tues");
		zone_operationalhrs_wed = rs_gtr.getString("zone_operationalhrs_wed");
		zone_operationalhrs_thurs = rs_gtr.getString("zone_operationalhrs_thurs");
		zone_operationalhrs_fri = rs_gtr.getString("zone_operationalhrs_fri");
		zone_operationalhrs_sat = rs_gtr.getString("zone_operationalhrs_sat");
		zone_operationalhrs_sun = rs_gtr.getString("zone_operationalhrs_sun");
		zone_floorarea = rs_gtr.getString("zone_floorarea");
		zone_zoneprop_narrow = rs_gtr.getString("zone_zoneprop_narrow");
		zone_zoneprop_wide = rs_gtr.getString("zone_zoneprop_wide");
		zone_zoneprop_open = rs_gtr.getString("zone_zoneprop_open");
		zone_height = rs_gtr.getString("zone_height");
		zone_sorting_conveyor = rs_gtr.getString("zone_sorting_conveyor");
		zone_ismotordrivenconveyor = rs_gtr.getString("zone_ismotordrivenconveyor");
		zone_conveyor_hours = rs_gtr.getString("zone_conveyor_hours");
		zone_conveyor_isturnedoff = rs_gtr.getString("zone_conveyor_isturnedoff");
		zone_hasskylights = rs_gtr.getString("zone_hasskylights");
		zone_isskylightsufficient = rs_gtr.getString("zone_isskylightsufficient");
		zone_isskylightcleaned = rs_gtr.getString("zone_isskylightcleaned");
		zone_lighting = rs_gtr.getString("zone_lighting");
		zone_fluorescent_tube = rs_gtr.getString("zone_fluorescent_tube");
		zone_t8_ballasttype = rs_gtr.getString("zone_t8_ballasttype");
		zone_powerrating = rs_gtr.getString("zone_powerrating");
		zone_numoflightings = rs_gtr.getString("zone_numoflightings");
		zone_lightcontroltype = rs_gtr.getString("zone_lightcontroltype");
		zone_ismanuallyturnedoff = rs_gtr.getString("zone_ismanuallyturnedoff");
		zone_hasradiantheaters = rs_gtr.getString("zone_hasradiantheaters");
	}
	ro_gtr.close();
%>
<div class="section">
	<div class="container">
		<div class="row">
			<!-- form: -->
			<section>
				<div class="page-header">
					<img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=building2%>_<%=zone2%>:Warehouse - Ground to roof
				</div>

					<div id="wrapper">
						<div id="content">
						<h5><font color="red">* Required</font></h5>
						
							<div class="demo">
								<div class="form-group">
								<label style="margin-left:4.5%">How many hours per day is this zone typically operational for? </label>
								<br>
								<br>
								<label class="col-lg-5 control-label">Monday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_mon<%=identifier%>" value="<%=zone_operationalhrs_mon%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Tuesday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_tues<%=identifier%>" value="<%=zone_operationalhrs_tues%>"/>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Wednesday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_wed<%=identifier%>" value="<%=zone_operationalhrs_wed%>"/>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Thursday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_thurs<%=identifier%>" value="<%=zone_operationalhrs_thurs%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Friday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_fri<%=identifier%>" value="<%=zone_operationalhrs_fri%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Saturday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_sat<%=identifier%>" value="<%=zone_operationalhrs_sat%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Sunday <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="hours_per_day" name="zone_operationalhrs_sun<%=identifier%>" value="<%=zone_operationalhrs_sun%>" />
								</div>
								</div>
								<hr>
								<div class="form-group">
								<label class="col-lg-5 control-label">What is the total floor area of this zone? <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers" name="zone_floorarea<%=identifier%>" value="<%=zone_floorarea%>" />
								</div>
								</div>
								<hr>
								<label style="margin-left:16.5%">What proportion of this zone is: </label>
								<br>
								<br>
								
								<div class="form-group">
								<label class="col-lg-5 control-label">Narrow Aisle Racking (%) <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="percentage" name="zone_zoneprop_narrow<%=identifier%>" value="<%=zone_zoneprop_narrow%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Wide Aisle Racking (%) <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="percentage" name="zone_zoneprop_wide<%=identifier%>" value="<%=zone_zoneprop_wide%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Open Area (no racking) (%) <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="percentage" name="zone_zoneprop_open<%=identifier%>" value="<%=zone_zoneprop_open%>" />
								</div>
								</div>
								<hr>
								<div class="form-group">
								<label class="col-lg-5 control-label">What is the height from the ground to the top of the external wall? <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers" name="zone_height<%=identifier%>" value="<%=zone_height%>" />
								</div>
								</div>

								<div class="form-group">
									<label class="col-lg-5 control-label">Does this zone have a sorting machine or conveyor system? <font color="red">*</font></label>
									<div class="col-lg-6">
									<select class="form-control" id="zone_grf_sorting_machine" name="zone_sorting_conveyor<%=identifier%>">
										<% if (zone_sorting_conveyor.equals("")) { %>
											<option value="" selected>-- Select Yes/No --</option>
										<% } else { %>
											<option value="">-- Select Yes/No --</option>
										<% } %>
										<% if (zone_sorting_conveyor.equals("Yes")) { %>
											<option value="Yes" selected>Yes</option>
										<% } else { %>
											<option value="Yes">Yes</option>
										<% } %>
										<% if (zone_sorting_conveyor.equals("No")) { %>
											<option value="No" selected>No</option>
										<% } else { %>
											<option value="No">No</option>
										<% } %>
									</select>
									
									</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">If yes, how many meters of motor driven conveyors are installed?</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers_opt" name="zone_ismotordrivenconveyor<%=identifier%>" value="<%=zone_ismotordrivenconveyor%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">How many hours per week do these conveyors run?</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers_opt" name="zone_conveyor_hours<%=identifier%>" value="<%=zone_conveyor_hours%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Are conveyors turned off when no goods are in the system?</label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_conveyor_isturnedoff.equals("Yes")) { %>
											<label><input type="radio" id="is_conveyors_off" value="Yes" name="zone_conveyor_isturnedoff<%=identifier%>" checked />Yes</label>
										<% } else { %>	
											<label><input type="radio" id="is_conveyors_off" value="Yes" name="zone_conveyor_isturnedoff<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_conveyor_isturnedoff.equals("Yes")) { %>
											<label><input type="radio" id="is_conveyors_off" value="No" name="zone_conveyor_isturnedoff<%=identifier%>" checked />No</label>
										<% } else { %>	
											<label><input type="radio" id="is_conveyors_off" value="No" name="zone_conveyor_isturnedoff<%=identifier%>" />No</label>
										<% } %>
									</div>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Does this zone have warehouse roof skylights? </label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_hasskylights.equals("Yes")) { %>
											<label><input type="radio" id="has_roof_skylights" value="Yes" name="zone_hasskylights<%=identifier%>" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="has_roof_skylights" value="Yes" name="zone_hasskylights<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_hasskylights.equals("No")) { %>
											<label><input type="radio" id="has_roof_skylights" value="No" name="zone_hasskylights<%=identifier%>" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="has_roof_skylights" value="No" name="zone_hasskylights<%=identifier%>" />No</label>
										<% } %>
									</div>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Do the skylights provide sufficient daylight to light this warehouse zone? </label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_isskylightsufficient.equals("Yes")) { %>
											<label><input type="radio" id="sufficient_skylight" value="Yes" name="zone_isskylightsufficient<%=identifier%>" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="sufficient_skylight" value="Yes" name="zone_isskylightsufficient<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_isskylightsufficient.equals("Yes")) { %>
											<label><input type="radio" id="sufficient_skylight" value="No" name="zone_isskylightsufficient<%=identifier%>" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="sufficient_skylight" value="No" name="zone_isskylightsufficient<%=identifier%>" />No</label>
										<% } %>
									</div>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Are the skylights regulary cleaned?</label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_isskylightcleaned.equals("Yes")) { %>
											<label><input type="radio" id="skylights_cleaned" value="Yes" name="zone_isskylightcleaned<%=identifier%>" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="skylights_cleaned" value="Yes" name="zone_isskylightcleaned<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_isskylightcleaned.equals("No")) { %>
											<label><input type="radio" id="skylights_cleaned" value="No" name="zone_isskylightcleaned<%=identifier%>" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="skylights_cleaned" value="No" name="zone_isskylightcleaned<%=identifier%>" />No</label>
										<% } %>
									</div>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">What is the main type of lighting installed? <font color="red">*</font></label>
								<div class="col-lg-6">
									<select class="form-control" id="zone_grf_lighting" name="zone_lighting<%=identifier%>">
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
								<label class="col-lg-5 control-label">If fluoresent what are the main type of tubes are installed? </label>
								<div class="col-lg-6">
									<select class="form-control" id="fluoresent_tube_installed" name="zone_fluorescent_tube<%=identifier%>">
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
								<label class="col-lg-5 control-label">If T8 tubes are used, what type of ballast is installed? </label>
								<div class="col-lg-6">
									<select class="form-control" id="ballast" name="zone_t8_ballasttype<%=identifier%>">
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
								<label class="col-lg-5 control-label">What is the power rating of each fitting in this zone's main warehouse lighting system?</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers_opt" name="zone_powerrating<%=identifier%>" value="<%=zone_powerrating%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Approximately how many lighting fittings make up this zone's main lighting system? </label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="numbers_opt" name="zone_numoflightings<%=identifier%>" value="<%=zone_numoflightings%>" />
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">What type of control is used on this zone's main warehouse lighting system?</label>
								<div class="col-lg-6">
									<select class="form-control" id="wh_light_control" name="zone_lightcontroltype<%=identifier%>">
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

								<div class="form-group">
								<label class="col-lg-5 control-label">If manual, are the lights turned off if there is natural daylight or during non-working time?</label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_ismanuallyturnedoff.equals("Yes")) { %>
											<label><input type="radio" id="manual_lights_off" value="Yes" name="zone_ismanuallyturnedoff<%=identifier%>" checked />Yes</label>
										<% } else { %>	
											<label><input type="radio" id="manual_lights_off" value="Yes" name="zone_ismanuallyturnedoff<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_ismanuallyturnedoff.equals("No")) { %>
											<label><input type="radio" id="manual_lights_off" value="No" name="zone_ismanuallyturnedoff<%=identifier%>" checked />No</label>
										<% } else { %>	
											<label><input type="radio" id="manual_lights_off" value="No" name="zone_ismanuallyturnedoff<%=identifier%>" />No</label>
										<% } %>
									</div>
								</div>
								</div>

								<div class="form-group">
								<label class="col-lg-5 control-label">Is part or all of this zone heated with radiant heaters?</label>
								<div class="col-lg-6">
									<div class="radio">
										<% if (zone_hasradiantheaters.equals("Yes")) { %>
											<label><input type="radio" id="radiant_heaters" value="Yes" name="zone_hasradiantheaters<%=identifier%>" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="radiant_heaters" value="Yes" name="zone_hasradiantheaters<%=identifier%>" />Yes</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (zone_hasradiantheaters.equals("No")) { %>
											<label><input type="radio" id="radiant_heaters" value="No" name="zone_hasradiantheaters<%=identifier%>" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="radiant_heaters" value="No" name="zone_hasradiantheaters<%=identifier%>" />No</label>
										<% } %>
									</div>
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


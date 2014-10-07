
<%
	String building4 = (String) session.getAttribute("building_name");
	String zone4 = (String) session.getAttribute("zone_name");

	String identifier = "-" + building4 + "_" + zone4;
	
	String zone_id_mez = session.getAttribute("quest_id") + identifier;
	
	String where_mez = "zone_id = \'" + zone_id_mez + "\'";
	RetrievedObject ro_mez = SQLManager.retrieveRecords("mezzanine_form", where_mez);
	ResultSet rs_mez = ro_mez.getResultSet();
	
	String zone_operationalhrs_mon = "";
	String zone_operationalhrs_tues = "";
	String zone_operationalhrs_wed = "";
	String zone_operationalhrs_thurs = "";
	String zone_operationalhrs_fri = "";
	String zone_operationalhrs_sat = "";
	String zone_operationalhrs_sun = "";
	String zone_floorarea = "";
	String zone_numoffloors = "";
	String zone_zoneprop_narrow = "";
	String zone_zoneprop_wide = "";
	String zone_zoneprop_open = "";
	String zone_lighting = "";
	String zone_fluorescent_tube = "";
	String zone_t8_ballasttype = "";
	String zone_lightcontroltype = "";
	String zone_hasgoodslift = "";
	
	while(rs_mez.next()) {
		zone_operationalhrs_mon = rs_mez.getString("zone_operationalhrs_mon");
		zone_operationalhrs_tues = rs_mez.getString("zone_operationalhrs_tues");
		zone_operationalhrs_wed = rs_mez.getString("zone_operationalhrs_wed");
		zone_operationalhrs_thurs = rs_mez.getString("zone_operationalhrs_thurs");
		zone_operationalhrs_fri = rs_mez.getString("zone_operationalhrs_fri");
		zone_operationalhrs_sat = rs_mez.getString("zone_operationalhrs_sat");
		zone_operationalhrs_sun = rs_mez.getString("zone_operationalhrs_sun");
		zone_floorarea = rs_mez.getString("zone_floorarea");
		zone_numoffloors = rs_mez.getString("zone_numoffloors");
		zone_zoneprop_narrow = rs_mez.getString("zone_zoneprop_narrow");
		zone_zoneprop_wide = rs_mez.getString("zone_zoneprop_wide");
		zone_zoneprop_open = rs_mez.getString("zone_zoneprop_open");
		zone_lighting = rs_mez.getString("zone_lighting");
		zone_fluorescent_tube = rs_mez.getString("zone_fluorescent_tube");
		zone_t8_ballasttype = rs_mez.getString("zone_t8_ballasttype");
		zone_lightcontroltype = rs_mez.getString("zone_lightcontroltype");
		zone_hasgoodslift = rs_mez.getString("zone_hasgoodslift");
	}
	ro_mez.close();
%>
<div class="section">
	<div class="container">
		<div class="row">
			<!-- form: -->
			<section>
				<div class="page-header">
					<img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=building4%>_<%=zone4%>:Warehouse - Mezzanine
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
									<div class="col-lg-4 inputGroupContainer">
										<div class="input-group">
										<input type="text" class="form-control" id="hours_per_day_mon" name="zone_operationalhrs_mon<%=identifier%>" value="<%=zone_operationalhrs_mon%>" />
										<span class="input-group-addon">hours</span>
										</div>
									</div>
									</div>
								

							<div class="form-group">
							<label class="col-lg-5 control-label">Tuesday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_tue" name="zone_operationalhrs_tues<%=identifier%>" value="<%=zone_operationalhrs_tues%>"/>
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Wednesday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_wed" name="zone_operationalhrs_wed<%=identifier%>" value="<%=zone_operationalhrs_wed%>"/>
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Thursday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_thu" name="zone_operationalhrs_thurs<%=identifier%>" value="<%=zone_operationalhrs_thurs%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Friday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_fri" name="zone_operationalhrs_fri<%=identifier%>" value="<%=zone_operationalhrs_fri%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Saturday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_sat" name="zone_operationalhrs_sat<%=identifier%>" value="<%=zone_operationalhrs_sat%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Sunday <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="hours_per_day_sun" name="zone_operationalhrs_sun<%=identifier%>" value="<%=zone_operationalhrs_sun%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>
							
							<hr>
							<div class="form-group">
							<label class="col-lg-5 control-label">What is the total floor area of this zone? <font color="red">* </font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="numbers" name="zone_floorarea<%=identifier%>"  value="<%=zone_floorarea%>" />
								<span class="input-group-addon">m<sup>2</sup></span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">How many floors does this zone occupy? <font color="red">* </font></label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="integer_positive_required" name="zone_numoffloors<%=identifier%>" value="<%=zone_numoffloors%>" />
							</div>
							</div>
							<hr>
							<label style="margin-left:16.5%">What proportion of this zone is: </label>
							<br>
							<br>
							<div class="form-group">
							<label class="col-lg-5 control-label">Narrow Aisle Racking <font color="red">* </font></label>
							<div class="col-lg-4 inputGroupContainer">
									<div class="input-group">
								<input type="text" class="form-control" id="percentage_narrow" name="zone_zoneprop_narrow<%=identifier%>" value="<%=zone_zoneprop_narrow%>" />
								<span class="input-group-addon">%</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Wide Aisle Racking <font color="red">* </font></label>
							<div class="col-lg-4 inputGroupContainer">
									<div class="input-group">
								<input type="text" class="form-control" id="percentage_wide" name="zone_zoneprop_wide<%=identifier%>" value="<%=zone_zoneprop_wide%>" />
								<span class="input-group-addon">%</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Open Area (no racking) <font color="red">* </font></label>
							<div class="col-lg-4 inputGroupContainer">
									<div class="input-group">
								<input type="text" class="form-control" id="percentage_open" name="zone_zoneprop_open<%=identifier%>" value="<%=zone_zoneprop_open%>" />
								<span class="input-group-addon">%</span>
								</div>
							</div>
							</div>
							
							<hr>
							
							<div class="form-group">
							<label class="col-lg-5 control-label">What is the main type of warehouse lighting installed? <font color="red">* </font></label>
							<div class="col-lg-4">
								<select class="form-control" id="zone_mez_lighting" name="zone_lighting<%=identifier%>">
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
							<label class="col-lg-5 control-label">If fluoresent, what are the main type of tubes are installed? </label>
							<div class="col-lg-4">
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
							<div class="col-lg-4">
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
							<label class="col-lg-5 control-label">What type of control is used on this zone's main warehouse lighting system?</label>
							<div class="col-lg-4">
								<select class="form-control" id="zone_mez_light_control" name="zone_lightcontroltype<%=identifier%>">
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
							<label class="col-lg-5 control-label">Are goods lifts (elevators) used in the mezzaine zone?</label>
							<div class="col-lg-4">
								<div class="radio">
								<% if (zone_hasgoodslift.equals("Yes")) { %>
										<label><input type="radio" id="goods_lift" name="zone_hasgoodslift<%=identifier%>" value="Yes" checked />Yes</label>
									<% } else { %>
										<label><input type="radio" id="goods_lift" name="zone_hasgoodslift<%=identifier%>" value="Yes" />Yes</label>
									<% } %>
								</div>
								<div class="radio">
								<% if (zone_hasgoodslift.equals("No")) { %>
										<label><input type="radio" id="goods_lift" name="zone_hasgoodslift<%=identifier%>" value="No" checked />No</label>
									<% } else { %>
										<label><input type="radio" id="goods_lift" name="zone_hasgoodslift<%=identifier%>" value="No" />No</label>
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
		<% if (session.getAttribute("last_tab")==null) { %>
    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
    	<% }
		session.removeAttribute("last_tab");%>
    	
	</div>
</div>

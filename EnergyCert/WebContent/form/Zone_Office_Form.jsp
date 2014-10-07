
<%
	String building1 = (String) session.getAttribute("building_name");
	String zone1 = (String) session.getAttribute("zone_name");

	String identifier = "-" + building1 + "_" + zone1;
	
	String zone_id_office = session.getAttribute("quest_id") + identifier;
	
	String where_office = "zone_id = \'" + zone_id_office + "\'";
	RetrievedObject ro_office = SQLManager.retrieveRecords("office_form", where_office);
	ResultSet rs_office = ro_office.getResultSet();
	
	String zone_operationalhrs_mon = "";
	String zone_operationalhrs_tues = "";
	String zone_operationalhrs_wed = "";
	String zone_operationalhrs_thurs = "";
	String zone_operationalhrs_fri = "";
	String zone_operationalhrs_sat = "";
	String zone_operationalhrs_sun = "";
	String zone_floorarea = "";
	String zone_numoffloors = "";
	String zone_aveemployees = "";
	String zone_numoflaptops = "";
	String zone_numofflatscreen = "";
	String zone_numofCRTmonitor = "";
	String zone_isalwaysshutdown = "";
	String zone_ispowersavingmode = "";
	String zone_lighting = "";
	String zone_fluorescent_tube = "";
	String zone_t8_ballasttype = "";
	String zone_lightcontroltype = "";
	String zone_externalglazingtype = "";
	
	while(rs_office.next()) {
		zone_operationalhrs_mon = rs_office.getString("zone_operationalhrs_mon");
		zone_operationalhrs_tues = rs_office.getString("zone_operationalhrs_tues");
		zone_operationalhrs_wed = rs_office.getString("zone_operationalhrs_wed");
		zone_operationalhrs_thurs = rs_office.getString("zone_operationalhrs_thurs");
		zone_operationalhrs_fri = rs_office.getString("zone_operationalhrs_fri");
		zone_operationalhrs_sat = rs_office.getString("zone_operationalhrs_sat");
		zone_operationalhrs_sun = rs_office.getString("zone_operationalhrs_sun");
		zone_floorarea = rs_office.getString("zone_floorarea");
		zone_numoffloors = rs_office.getString("zone_numoffloors");
		zone_aveemployees = rs_office.getString("zone_aveemployees");
		zone_numoflaptops = rs_office.getString("zone_numoflaptops");
		zone_numofflatscreen = rs_office.getString("zone_numofflatscreen");
		zone_numofCRTmonitor = rs_office.getString("zone_numofCRTmonitor");
		zone_isalwaysshutdown = rs_office.getString("zone_isalwaysshutdown");
		zone_ispowersavingmode = rs_office.getString("zone_ispowersavingmode");
		zone_lighting = rs_office.getString("zone_lighting");
		zone_fluorescent_tube = rs_office.getString("zone_fluorescent_tube");
		zone_t8_ballasttype = rs_office.getString("zone_t8_ballasttype");
		zone_lightcontroltype = rs_office.getString("zone_lightcontroltype");
		zone_externalglazingtype = rs_office.getString("zone_externalglazingtype");
	}
	ro_office.close();
%>
<div class="section">
	<div class="container">
		<div class="row">
			<!-- form: -->
			<section>
				<div class="page-header">
					<img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=building1%>_<%=zone1%>:Offices
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
								<input type="text" class="form-control" id="numbers" name="zone_floorarea<%=identifier%>" value="<%=zone_floorarea%>" />
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

							<div class="form-group">
							<label class="col-lg-5 control-label">What is the average number of office employees during the typical working hours? <font color="red">* </font></label>
							<div class="col-lg-4">
								<input type="text" class="form-control" id="integer_positive_required" name="zone_aveemployees<%=identifier%>" value="<%=zone_aveemployees%>" />
							</div>
							</div>
							<hr>
							<label style="margin-left:4.5%">How many hours per day is this zone typically operational for? </label>
							<br>
							<br>
							<div class="form-group">
							<label class="col-lg-5 control-label">Laptop <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="integer_positive_required" name="zone_numoflaptops<%=identifier%>" value="<%=zone_numoflaptops%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Desktop with flat screen monitor <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="integer_positive_required" name="zone_numofflatscreen<%=identifier%>" value="<%=zone_numofflatscreen%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Desktop with CRT monitor <font color="red">*</font></label>
							<div class="col-lg-4 inputGroupContainer">
								<div class="input-group">
								<input type="text" class="form-control" id="integer_positive_required" name="zone_numofCRTmonitor<%=identifier%>" value="<%=zone_numofCRTmonitor%>" />
								<span class="input-group-addon">hours</span>
								</div>
							</div>
							</div>
							
							<hr>
							
							<div class="form-group">
							<label class="col-lg-5 control-label">Are all PCs and monitors always shutdown overnight? <font color="red">*</font></label>
							<div class="col-lg-4">
								<select class="form-control" id="pc_monitor_shutdown" name="zone_isalwaysshutdown<%=identifier%>">
									<% if (zone_isalwaysshutdown.equals("")) { %>
										<option value="" selected>-- Select Yes/No --</option>
									<% } else { %>
										<option value="">-- Select Yes/No --</option>
									<% } %>
									<% if (zone_isalwaysshutdown.equals("Yes")) { %>
										<option value="Yes" selected>Yes</option>
									<% } else { %>
										<option value="Yes">Yes</option>
									<% } %>
									<% if (zone_isalwaysshutdown.equals("No")) { %>
										<option value="No" selected>No</option>
									<% } else { %>
										<option value="No">No</option>
									<% } %>
								</select>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">Are power saving settings enabled, for example do PCs go to sleep mode if not used for a short time? <font color="red">* </font></label>
							<div class="col-lg-4">
								<select class="form-control" id="power_savings" name="zone_ispowersavingmode<%=identifier%>">
									<% if (zone_ispowersavingmode.equals("")) { %>
										<option value="" selected>-- Select Yes/No --</option>
									<% } else { %>
										<option value="">-- Select Yes/No --</option>
									<% } %>
									<% if (zone_ispowersavingmode.equals("Yes")) { %>
										<option value="Yes" selected>Yes</option>
									<% } else { %>
										<option value="Yes">Yes</option>
									<% } %>
									<% if (zone_ispowersavingmode.equals("No")) { %>
										<option value="No" selected>No</option>
									<% } else { %>
										<option value="No">No</option>
									<% } %>
								</select>
							</div>
							</div>

							<div class="form-group">
							<label class="col-lg-5 control-label">What is the main type of lighting installed? <font color="red">* </font></label>
							<div class="col-lg-4">
								<select class="form-control" id="zone_office_lighting" name="zone_lighting<%=identifier%>">
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
							<label class="col-lg-5 control-label">If fluoresent, what are the main type of tubes are installed?</label>
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
							<label class="col-lg-5 control-label">If T8 tubes are used, what type of ballast is installed?</label>
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
								<select class="form-control" id="zone_office_light_control" name="zone_lightcontroltype<%=identifier%>">
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
							<label class="col-lg-5 control-label">If the office has external glazing is it?</label>
							<div class="col-lg-4">
								<select class="form-control" id="external_glazing" name="zone_externalglazingtype<%=identifier%>">
									<% if (zone_externalglazingtype.equals("")) { %>
										<option value="" selected>-- Select one --</option>
									<% } else { %>
										<option value="">-- Select one --</option>
									<% } %>
									<% if (zone_externalglazingtype.equals("No External")) { %>
										<option value="No External" selected>No External</option>
									<% } else { %>
										<option value="No External">No External</option>
									<% } %>
									<% if (zone_externalglazingtype.equals("Single glazed")) { %>
										<option value="Single glazed" selected>Single glazed</option>
									<% } else { %>
										<option value="Single glazed">Single glazed</option>
									<% } %>
									<% if (zone_externalglazingtype.equals("Double glazed")) { %>
										<option value="Double glazed" selected>Double glazed</option>
									<% } else { %>
										<option value="Double glazed">Double glazed</option>
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
		<% if (session.getAttribute("last_tab")==null) { %>
    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
    	<% }
		session.removeAttribute("last_tab");%>    	
	</div>
</div>

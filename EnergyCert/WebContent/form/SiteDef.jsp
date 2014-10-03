<%
//retrieveRecords(String tableName, String whereClause)
String where = "questionnaire_id = \'" + session.getAttribute("quest_id") + "\'";
RetrievedObject site_def_ro = SQLManager.retrieveRecords("site_definition", where);
ResultSet site_def_rs = site_def_ro.getResultSet();
String details = "";
String activity = "";
String bName = "";
while (site_def_rs.next()) {
	details = site_def_rs.getString("site_def_info");
	activity = site_def_rs.getString("site_def_activity");
	bName = site_def_rs.getString("site_def_building_name");
}

site_def_ro.close();
String[] details_array = details.split("\\^");
String[] activity_array = activity.split("\\^");
String[] building_name_array = bName.split("\\*");

%>

<div class="container">
    <div class="row">
        <!-- form: -->
        <section>
        	<div>
                <div class="page-header" style="padding-left:0em;">
                    <img src="../icons/icon_definition.png" height="5%" width="5%">&nbsp;&nbsp;Site Definition
                </div>
                <% if (!fromLink) {%>
                <div id="buildingButtons" style="display:inline-flex;">
                    <div class="form-group" style="padding-right:2em;">
                    	<div class="col-lg-4">
                            <button type="button" data-toggle="modal" data-target="#addZoneModal" class="btn btn-default" style="width:120px;"><span class="glyphicon glyphicon-plus-sign"></span> Add Zone</button>
                        </div>
					</div>
				
					<div class="form-group" style="padding-right:2em;">
                    	<div class="col-lg-4">
                            <button type="button" data-toggle="modal" data-target="#deleteZoneModal" class="btn btn-default" style="width:130px;"><span class="glyphicon glyphicon-minus-sign"></span> Delete Zone</button>
                        </div>
					</div>
				</div>  
				<% } %>  
                    <% 
                    for (int i = 0; i < details_array.length; i++) { 
                    	String det = details_array[i];
                    	String act = activity_array[i];
                    	String building_name = building_name_array[i];
                    %>
                    <%-- Building 1 --%>
                    <div>
                    	<div class="form-group">
							<label id="label_building_name" for="building_name[]" class="col-lg-5 control-label">Building Name</label>
							<div class="col-lg-3">
								<input name="building_name[]" type="text"  class="form-control" style="width: 270px;" value="<%=building_name%>" disabled />
							</div>	
						</div>
						
						<%-- Headings in table --%>
						<div class="zone_headings" style="display:inline-flex;width:100%;">
							<div class="form-group" style="padding-right:2em;width:18%;">
								<div class="col-lg-12">
									<label>Zone Name</label>
								</div>
							</div>
							<div class="form-group" style="width:25%;">
								<div class="col-lg-12">
									<label>Zone Activity</label>
								</div>
							</div>
							<div class="form-group" style="width:23%;">
								<div class="col-lg-12">
									<label>Zone Heating or Cooling</label>
								</div>
							</div>
							<div class="form-group" style="width:16%;">
								<div class="col-lg-12">
									<label>Min Temp. <br> Set-point (&deg;C)</label>
								</div>
							</div>
							<div class="form-group" style="width:16%;">
								<div class="col-lg-12">
									<label>Max Temp. <br> Set-point (&deg;C)</label>
								</div>
							</div>
							<div class="form-group" style="width:16%;">
								<div class="col-lg-12">
									<label>Months of Zone Operation in <%=previousYear %></label>
								</div>
							</div>
						</div>
						<%
						String[] zone_details_array = det.split("\\*");
						String[] zone_act_array = act.split("\\*");
						String tableNameZone = "";
						String where_zone = "";
						for (int j = 0; j < zone_details_array.length; j++) {
							String zone = zone_details_array[j];
							String zone_act = zone_act_array[j];
							if (zone_act.equals("offices")) {
								tableNameZone = "office_form";
							} else if (zone_act.equals("wh_ground_to_roof")) {
								tableNameZone = "ground_to_roof_form";
							} else if (zone_act.equals("wh_mezzanine")) {
								tableNameZone = "mezzanine_form";
							} else if (zone_act.equals("wh_value_add")) {
								tableNameZone = "warehouse_value_add_form";
							}
							where_zone = "zone_id = \'" + zone + "\'";
							
							RetrievedObject ro_zone = SQLManager.retrieveRecords(tableNameZone, where_zone);
							ResultSet rs_zone = ro_zone.getResultSet();
							//String building_name = "";
							String zone_name = "";
							String zone_activity = "";
							String zone_heating_cooling = "";
							String zone_min_temp = "";
							String zone_max_temp = "";
							String zone_operation = "";
							while (rs_zone.next()) {
								//building_name = rs_zone.getString("building_name");
								zone_name = rs_zone.getString("zone_name");
								zone_activity = rs_zone.getString("zone_activity");
								zone_heating_cooling = rs_zone.getString("zone_heating_cooling");
								zone_min_temp = rs_zone.getString("zone_min_temp");
								zone_max_temp = rs_zone.getString("zone_max_temp");
								zone_operation = rs_zone.getString("zone_operation");
							}
							ro_zone.close();
							
						%>
	                    <%-- 1st row of zone in table --%>
	                    <div class="zone" style="display:inline-flex;width:100%;">
		                    <div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="b1_zone_name[]" type="text" class="form-control" style="width: 160px;" value="<%=zone_name%>" disabled />
								</div>	
							</div>
							
							<div class="form-group" style="padding-right:2em;">
				                <div class="col-lg-12">
				                    <select class="form-control" name="b1_zone_activity[]" style="width:250px;" onChange="updateHeatingCooling(this)" disabled >
				                        <%
				                        String zone_activity_value = "";
				                        if (zone_activity.equals("offices")) {
				                        	zone_activity_value = "Offices";
				                        } else if (zone_activity.equals("wh_ground_to_roof")) {
				                        	zone_activity_value = "Warehouse - Ground to roof";
				                        } else if (zone_activity.equals("wh_mezzanine")) {
				                        	zone_activity_value = "Warehouse - Mezzanine";
				                        } else if (zone_activity.equals("wh_value_add")) {
				                        	zone_activity_value = "Warehouse - Value add";
				                        }
				                        %>
				                        <option value="<%=zone_activity%>"><%=zone_activity_value%></option>
				                    </select>
				                </div>
				            </div>
		                    
		                    <div class="form-group" style="padding-right:2em;">
		                        <div class="col-lg-12">
									<select name="b1_zone_heating_cooling[]" class="form-control" style="width: 220px;" onChange="updateMinMaxTemp(this)" disabled >
				                         <%
				                        String zone_heating_cooling_value = "";
				                        if (zone_heating_cooling.equals("heated_20")) {
				                        	zone_heating_cooling_value = "Heated";
				                        } else if (zone_heating_cooling.equals("air_conditioned")) {
				                        	zone_heating_cooling_value = "Air Conditioned";
				                        } else if (zone_heating_cooling.equals("heated_air_conditioned")) {
				                        	zone_heating_cooling_value = "Heated + Air Conditioned";
				                        } else if (zone_heating_cooling.equals("other")) {
				                        	zone_heating_cooling_value = "Other";
				                        } else if (zone_heating_cooling.equals("frost_protected")) {
				                        	zone_heating_cooling_value = "Frost Protected";
				                        } else if (zone_heating_cooling.equals("heated_14")) {
				                        	zone_heating_cooling_value = "Heated";
				                        } else if (zone_heating_cooling.equals("chilled")) {
				                        	zone_heating_cooling_value = "Chilled";
				                        } else if (zone_heating_cooling.equals("frozen")) {
				                        	zone_heating_cooling_value = "Frozen";
				                        } else if (zone_heating_cooling.equals("temp_controlled")) {
				                        	zone_heating_cooling_value = "Temperature Controlled";
				                        }
				                        %>
				                        <option value="<%=zone_heating_cooling%>"><%=zone_heating_cooling_value%></option>
									</select>
		                        </div>
		                    </div>
		                    
		                    <div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="b1_zone_min_temp[]" type="text" class="form-control" style="width: 140px;" value="<%=zone_min_temp%>" disabled />
								</div>
							</div>
							
							<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="b1_zone_max_temp[]" type="text" class="form-control" style="width: 140px;" value="<%=zone_max_temp%>" disabled />
								</div>	
							</div>
							
							<div class="form-group" style="padding-right:2em;">
				                <div class="col-lg-12">
									<select class="form-control" name="b1_zone_operation[]" style="width: 150px;" disabled >
										<option value="<%=zone_operation%>"><%=zone_operation%></option>
									</select>
								</div>
							</div>
	                    </div>
	                   
	                    <% } %>
	                    <br><br>
	                    
	                    
	                    
						
						
	            	</div>
	            	<% } %>
	            	
	            	
	            	<div class="btn-group" style="margin-left:88%">
                    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
					</div>
            
            </div>
		</section>
	</div>
</div>
       
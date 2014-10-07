<%
quest_id = (String) session.getAttribute("quest_id");

String where_info = "questionnaire_id = \'" + quest_id + "\'";
RetrievedObject ro = SQLManager.retrieveRecords("questionnaire", where_info);
ResultSet rs = ro.getResultSet();

String site_info_reference = "";
String site_info_business_unit = "";
String site_info_leasehold_freehold = "";
String site_info_lease_expire = "";
String site_info_contract_expire = "";
//thinking if contact_name, job_title, phone, etc should be in accts mgmt then populate here based on login user
String site_info_contact_name = "";
String site_info_contact_job_title = "";
String site_info_contact_phone = "";
String site_info_contact_email = "";
String site_info_activities_services = "";
String site_info_sustainability_champion = "";
String site_info_reduction_targets = "";
String site_info_targets_level = "";
String site_info_carbon_reduction_targets = "";
String site_info_employee_awareness_program = "";
String site_info_access_to_energy_data = "";
String site_info_truck_loading_bays = "";
String site_info_bays_dock_seals = "";
String ehe_type = "";
String ampere_hours = "";
String voltage = "";
String total_charges = "";
String total_charge_duration = "";
String site_info_ext_area_illuminated = "";
String site_info_hours_area_lit = "";
String site_info_ext_area_controlled = "";
String site_info_office_heating = "";
String site_info_age_heating_system = "";
String site_info_serviced_heating_system = "";
String site_info_length_uninsulated_pipes = "";
String site_info_num_uninsulated_valves = "";
String site_info_hot_water_toilets_washing = "";
String site_info_storage_tank_insulated = "";
String site_info_hot_water_heating_controlled = "";
String site_info_office_cooling = "";
String site_info_cooling_age = "";
String site_info_cooling_serviced = "";
String site_info_warehouse_heating = "";
String site_info_warehouse_heating_age = "";
String site_info_warehouse_heating_serviced = "";
String site_info_central_fan = "";
String site_info_fan_controlled = "";
String site_info_vol_red_opt_eq = "";
String site_info_electricity_meter = "";
String site_info_sub_meters  = "";
String site_info_initiatives_done = "";
String site_info_initiatives_done_when = "";
String site_info_initiatives_done_zone = "";
String site_info_initiatives_done_impact = "";
String site_info_initiatives_planned = "";
String site_info_initiatives_planned_when = "";
String site_info_initiatives_planned_zone = "";
String site_info_initiatives_planned_impact = "";

String site_info_name = "";
String site_info_address_street = "";
String site_info_address_city = "";
String site_info_address_postal = "";
String site_info_address_country = "";

while (rs.next()) {
	site_info_reference = rs.getString("site_info_reference");
	site_info_business_unit = rs.getString("site_info_business_unit");
	site_info_leasehold_freehold = rs.getString("site_info_leasehold_freehold");
	site_info_lease_expire = rs.getString("site_info_lease_expire");
	site_info_contract_expire = rs.getString("site_info_contract_expire");
	//thinking if contact_name, job_title, phone, etc should be in accts mgmt then populate here based on login user
	site_info_contact_name = rs.getString("site_info_contact_name");
	site_info_contact_job_title = rs.getString("site_info_contact_job_title");
	site_info_contact_phone = rs.getString("site_info_contact_phone");
	site_info_contact_email = rs.getString("site_info_contact_email");
	site_info_activities_services = rs.getString("site_info_activities_services");
	site_info_sustainability_champion = rs.getString("site_info_sustainability_champion");
	site_info_reduction_targets = rs.getString("site_info_reduction_targets");
	site_info_targets_level = rs.getString("site_info_targets_level");
	site_info_carbon_reduction_targets = rs.getString("site_info_carbon_reduction_targets");
	site_info_employee_awareness_program = rs.getString("site_info_employee_awareness_program");
	site_info_access_to_energy_data = rs.getString("site_info_access_to_energy_data");
	site_info_truck_loading_bays = rs.getString("site_info_truck_loading_bays");
	site_info_bays_dock_seals = rs.getString("site_info_bays_dock_seals");
	ehe_type = rs.getString("ehe_type");
	ampere_hours = rs.getString("ampere_hours");
	voltage = rs.getString("voltage");
	total_charges = rs.getString("total_charges");
	total_charge_duration = rs.getString("total_charge_duration");
	site_info_ext_area_illuminated = rs.getString("site_info_ext_area_illuminated");
	site_info_hours_area_lit = rs.getString("site_info_hours_area_lit");
	site_info_ext_area_controlled = rs.getString("site_info_ext_area_controlled");
	site_info_office_heating = rs.getString("site_info_office_heating");
	site_info_age_heating_system = rs.getString("site_info_age_heating_system");
	site_info_serviced_heating_system = rs.getString("site_info_serviced_heating_system");
	site_info_length_uninsulated_pipes = rs.getString("site_info_length_uninsulated_pipes");
	site_info_num_uninsulated_valves = rs.getString("site_info_num_uninsulated_valves");
	site_info_hot_water_toilets_washing = rs.getString("site_info_hot_water_toilets_washing");
	site_info_storage_tank_insulated = rs.getString("site_info_storage_tank_insulated");
	site_info_hot_water_heating_controlled = rs.getString("site_info_hot_water_heating_controlled");
	site_info_office_cooling = rs.getString("site_info_office_cooling");
	site_info_cooling_age = rs.getString("site_info_cooling_age");
	site_info_cooling_serviced = rs.getString("site_info_cooling_serviced");
	site_info_warehouse_heating = rs.getString("site_info_warehouse_heating");
	site_info_warehouse_heating_age = rs.getString("site_info_warehouse_heating_age");
	site_info_warehouse_heating_serviced = rs.getString("site_info_warehouse_heating_serviced");
	site_info_central_fan = rs.getString("site_info_central_fan");
	site_info_fan_controlled = rs.getString("site_info_fan_controlled");
	site_info_vol_red_opt_eq = rs.getString("site_info_vol_red_opt_eq");
	site_info_electricity_meter = rs.getString("site_info_electricity_meter");
	site_info_sub_meters  = rs.getString("site_info_sub_meters");
	site_info_initiatives_done = rs.getString("site_info_initiatives_done");
	site_info_initiatives_done_when = rs.getString("site_info_initiatives_done_when");
	site_info_initiatives_done_zone = rs.getString("site_info_initiatives_done_zone");
	site_info_initiatives_done_impact = rs.getString("site_info_initiatives_done_impact");
	site_info_initiatives_planned = rs.getString("site_info_initiatives_planned");
	site_info_initiatives_planned_when = rs.getString("site_info_initiatives_planned_when");
	site_info_initiatives_planned_zone = rs.getString("site_info_initiatives_planned_zone");
	site_info_initiatives_planned_impact = rs.getString("site_info_initiatives_planned_impact");	
	if (request.getParameter("site_id")!=null) {
		where_info = "Site_ID=\'" + request.getParameter("site_id") + "\'";
	} else {
		where_info = "Site_ID=\'" + rs.getString("site_id") + "\'";
	}
	RetrievedObject ro2 = SQLManager.retrieveRecords("site", where_info);
	ResultSet rs2 = ro2.getResultSet();
	rs2.next();
	site_info_name = rs2.getString("site_info_name");
	site_info_address_street = rs2.getString("site_info_address_street");
	site_info_address_city = rs2.getString("site_info_address_city");
	site_info_address_postal = rs2.getString("site_info_address_postal");
	site_info_address_country = rs2.getString("site_info_address_country");
	ro2.close();
}
ro.close();
%>
		<div class="container">
		<div class="row">
		<!-- form: -->
			<section>
				<div>
					<div class="page-header">
						<img src="../icons/icon_info.png" height="4.5%" width="4.5%">&nbsp;&nbsp;Site Information
					</div>
					<div id="wrapper"> 
						<div id="content">  
						<h5><font color="red">* Required</font></h5>
						
							<div class="demo">
							<br>
							<h4 class="expand">Site Data and User Information</h4>
							<div class="collapse">
							<%--for ProcessMasterServlet to know if SiteInfo.jsp is included--%>
							<input type="hidden" class="form-control" name="site_info" value="exists"></input>
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_name">What is the name of the site? <font color="red">*</font></label>
								<div class="col-lg-6">
								    <input type="text" class="form-control" id="" name="site_info_name" style="width: 420px;" placeholder="Enter the name that your site is commonly known as." value="<%=site_info_name %>" disabled></input>
								</div>
								</div> 
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_reference">Site Reference?</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" name="site_info_reference" style="width: 420px;" value="<%=site_info_reference%>"></input>
								</div>
								</div>
								
								<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_business_unit">Site Business Unit? <font color="red">*</font></label>
									<div class="col-lg-6">
									<div class="radio">
										<% if (site_info_business_unit.equals("Warehouse Primary")) { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Primary" checked />Warehouse Primary</label>
										<% } else { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Primary" />Warehouse Primary</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (site_info_business_unit.equals("Warehouse Secondary")) { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Secondary" checked />Warehouse Secondary</label>
										<% } else { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Secondary" />Warehouse Secondary</label>
										<% } %>		
									</div>
									<div class="radio">
										<% if (site_info_business_unit.equals("Warehouse Transport")) { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Transport" checked />Warehouse Transport</label>
										<% } else { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Warehouse Transport" />Warehouse Transport</label>
										<% } %>			
									</div>
									<div class="radio">
										<% if (site_info_business_unit.equals("Other")) { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Other" checked />Other</label>
										<% } else { %>
											<label><input type="radio" id="site_business_unit" name="site_info_business_unit" value="Other" />Other</label>
										<% } %>																			
									</div>
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_leasehold_freehold">Is the site under a leasehold or freehold? <font color="red">*</font></label>
									<div class="col-lg-6">
									<div class="radio">
										<% if (site_info_leasehold_freehold.equals("Leasehold")) { %>
											<label><input type="radio" id="leasehold_freehold" name="site_info_leasehold_freehold" value="Leasehold" checked />Leasehold</label>
										<% } else { %>
											<label><input type="radio" id="leasehold_freehold" name="site_info_leasehold_freehold" value="Leasehold" />Leasehold</label>
										<% } %>
									</div>
									<div class="radio">
										<% if (site_info_leasehold_freehold.equals("Freehold")) { %>
											<label><input type="radio" id="leasehold_freehold" name="site_info_leasehold_freehold" value="Freehold" checked />Freehold</label>
										<% } else { %>
											<label><input type="radio" id="leasehold_freehold" name="site_info_leasehold_freehold" value="Freehold" />Freehold</label>
										<% } %>
									</div>
									</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_lease_expire">If leasehold, when does the current lease expire?</label>
								<div class="col-lg-6 inputGroupContainer">
									<div class="input-group date" id="datetimePicker1">
										<input type="text" class="form-control" id="date1" placeholder="DD/MM/YYYY" data-date-format="DD/MM/YYYY" name="site_info_lease_expire" style="width: 380px;" value="<%=site_info_lease_expire%>"></input>
										<span class="input-group-addon">
						                    <span class="glyphicon glyphicon-calendar"></span>
						                </span>
									</div>
								</div>
							    </div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_contract_expire">If applicable, when does the current customer contract expire?</label>
								<div class="col-lg-6 inputGroupContainer">
									<div class="input-group date" id="datetimePicker2">
									<input type="text" class="form-control" id="date2" placeholder="DD/MM/YYYY" data-date-format="DD/MM/YYYY" name="site_info_contract_expire" style="width: 380px;" value="<%=site_info_contract_expire%>"></input>
									<span class="input-group-addon">
						                    <span class="glyphicon glyphicon-calendar"></span>
						                </span>
									</div>
								</div>
								</div>
								
								<hr>
								<div class="form-group">
								<label class="col-lg-5 control-label">What is the site address?</label>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_address_street">Street + Number <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="required_value" name="site_info_address_street" style="width: 420px;" value="<%=site_info_address_street %>" disabled ></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_address_city">State <font color="red">*</font></label>
								<div class="col-lg-6">
									<input type="text" class="form-control" id="required_value" name="site_info_address_city" style="width: 420px;" value="<%=site_info_address_city %>" disabled ></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_address_postal">Postal <font color="red">*</font></label>
								<div class="col-lg-6">	
									<input type="text" class="form-control" id="numbers" name="site_info_address_postal" style="width: 420px;" value="<%=site_info_address_postal %>" disabled></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_address_country">Country <font color="red">*</font></label>
								<div class="col-lg-6">		
									<input type="text" class="form-control" id="required_value" name="site_info_address_country" style="width: 420px;" value="<%=site_info_address_country %>" disabled></input>
								</div>
								</div>
								
								<hr>
								<div class="form-group">
								<label class="col-lg-5 control-label">What is your contact information?</label>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_contact_name">Name</label>
								<div class="col-lg-6">
									<input type="text" class="form-control" name="site_info_contact_name" style="width: 420px;" value="<%=site_info_contact_name%>"></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_contact_job_title">Job Title</label>
								<div class="col-lg-6">	
									<input type="text" class="form-control" name="site_info_contact_job_title" style="width: 420px;" value="<%=site_info_contact_job_title%>" ></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_contact_phone">Phone Number</label>
								<div class="col-lg-6">	
									<input type="text" class="form-control" id="numbers_opt" name="site_info_contact_phone" style="width: 420px;" value="<%=site_info_contact_phone%>"></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_contact_email">Email Address</label>
								<div class="col-lg-6">	
									<input type="text" class="form-control" id="email_optional" name="site_info_contact_email" style="width: 420px;" value="<%=site_info_contact_email%>"></input>
								</div>
								</div>
								
								<div class="form-group">
								<label class="col-lg-5 control-label" for="site_info_activities_services">What activities and services are carried out on site?</label>
								<div class="col-lg-6">
									<textarea rows="4" cols="60" class="form-control" name="site_info_activities_services" placeholder="Please provide a brief description of the type of activities and services carried out at the site."><%=site_info_activities_services%></textarea>
								</div>
								</div>
								<br><br>	
							</div>
							<h4 class="expand">Communication and Energy Management</h4>
							<div class="collapse">
						            <div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_sustainability_champion">Do you have a nominated Sustainability Champion?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_sustainability_champion.equals("Yes")) { %>
												<label><input type="radio" name="site_info_sustainability_champion" value="Yes" checked />Yes</label>
											<% } else { %>
												<label><input type="radio" name="site_info_sustainability_champion" value="Yes" />Yes</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_sustainability_champion.equals("No")) { %>
												<label><input type="radio"  name="site_info_sustainability_champion" value="No" checked />No</label>
											<% } else { %>
												<label><input type="radio" name="site_info_sustainability_champion" value="No" />No</label>
											<% } %>
										</div>
									</div>
									</div>
						            
						            
						            
						            <div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_reduction_targets">Whose reduction targets are you working towards?</label>
									<div class="col-lg-6">
										<input type="text" class="form-control" name="site_info_reduction_targets" style="width: 420px;" value="<%=site_info_reduction_targets%>"></input>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_targets_level">At what level are these targets set?</label>
									<div class="col-lg-6">
										<select name="site_info_targets_level" class="form-control">
											<% if (site_info_targets_level.equals("")) { %>
												<option value="" selected>-- Select one --</option>
											<% } else { %>
												<option value="">-- Select one --</option>
											<% } %>
											<% if (site_info_targets_level.equals("Global")) {%>
												<option value="Global" selected>Global</option>
											<% } else { %>
												<option value="Global">Global</option>
											<% } %>
											<% if (site_info_targets_level.equals("Country")) {%>
												<option value="Country" selected>Country</option>
											<% } else { %>
												<option value="Country">Country</option>
											<% } %>
											<% if (site_info_targets_level.equals("Regional")) {%>
												<option value="Regional" selected>Regional</option>
											<% } else { %>
												<option value="Regional">Regional</option>
											<% } %>
											<% if (site_info_targets_level.equals("Site")) {%>
												<option value="Site" selected>Site</option>
											<% } else { %>
												<option value="Site">Site</option>
											<% } %>
											<% if (site_info_targets_level.equals("Unknown")) {%>
												<option value="Unknown" selected>Unknown</option>
											<% } else { %>
												<option value="Unknown">Unknown</option>
											<% } %>
										</select>
									</div>
									</div>
									
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_carbon_reduction_targets">Are these carbon reduction targets communicated to employees? If so how? <font color="red">*</font></label>
									<div class="col-lg-6">
										<div class="checkbox">
											<% if (site_info_carbon_reduction_targets.equals("Not communicated")) { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Not communicated" checked />Not communicated</label>
											<% } else { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Not communicated" />Not communicated</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_carbon_reduction_targets.equals("Communicated through emails")) { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through emails" checked />Communicated through emails</label>
											<% } else { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through emails" />Communicated through emails</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_carbon_reduction_targets.equals("Communicated through posters")) { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through posters" checked />Communicated through posters</label>
											<% } else { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through posters" />Communicated through posters</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_carbon_reduction_targets.equals("Communicated through staff briefings")) { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through staff briefings" checked />Communicated through staff briefings</label>
											<% } else { %>
												<label><input type="checkbox" id="carbon_reduction_targets" name="site_info_carbon_reduction_targets" value="Communicated through staff briefings" />Communicated through staff briefings</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_employee_awareness_program">Have you launched an employee awareness program?</label>
									<div class="col-lg-6">	
										<div class="radio">
										<% if (site_info_employee_awareness_program.equals("Yes")) { %>
											<label><input type="radio" name="site_info_employee_awareness_program" value="Yes" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" name="site_info_employee_awareness_program" value="Yes" />Yes</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_employee_awareness_program.equals("No")) { %>
											<label><input type="radio" name="site_info_employee_awareness_program" value="No" checked />No</label>
										<% } else { %>
											<label><input type="radio" name="site_info_employee_awareness_program" value="No" />No</label>
										<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_access_to_energy_data">Does your site have easy access to your sites energy data? <font color="red">*</font></label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_access_to_energy_data.equals("Not available or annual consumption data")) { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Not available or annual consumption data" checked />Not available or annual consumption data</label>
											<% } else { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Not available or annual consumption data" />Not available or annual consumption data</label>
											<% } %>
										</div>		
										<div class="radio">
											<% if (site_info_access_to_energy_data.equals("Easily available monthly consumption data")) { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Easily available monthly consumption data" checked />Easily available monthly consumption data</label>
											<% } else { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Easily available monthly consumption data" />Easily available monthly consumption data</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_access_to_energy_data.equals("Detailed energy data (from automatic meters allowing daily profile curves)")) { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Detailed energy data (from automatic meters allowing daily profile curves)" checked />Detailed energy data (from automatic meters <br> allowing daily profile curves)</label>
											<% } else { %>
												<label><input type="radio" id="access_to_energy_data" name="site_info_access_to_energy_data" value="Detailed energy data (from automatic meters allowing daily profile curves)" />Detailed energy data (from automatic meters <br> allowing daily profile curves)</label>
											<% } %>
										</div>															
									</div>
									</div>
				
                					<br><br>
								</div>
						        <h4 class="expand">Site Construction and Other Information</h4>
						        <div class="collapse">
						        	<h5>Loading Bays</h5>
						        	
						        	<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_truck_loading_bays">How many truck loading bays does your site have in total? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" name="site_info_truck_loading_bays" style="width: 420px;" value="<%=site_info_truck_loading_bays%>" ></input>
									</div>
									</div>
						
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_bays_dock_seals">How many of your bays have dock seals? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" name="site_info_bays_dock_seals"  id="site_info_bays_dock_seals" style="width: 420px;" value="<%=site_info_bays_dock_seals%>" ></input>
									</div>
									</div>
									
									<hr>
									
									<h5>Electric Handling Equipment</h5>
									<div id="elect_handling_equipment">
								
										<%-- Headings in table --%>
										<div class="EHE_headings" style="display:inline-flex;width:100%;">
										<div class="form-group" style="padding-right:2em;width:21.5%;">
											<div class="col-lg-12">
												<label>Type <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="padding-right:2em;width:20.5%;">
											<div class="col-lg-12">
												<label>Ampere-hours <br> (Ah) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:21%;">
											<div class="col-lg-12">
												<label>Voltage (V) <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:24.5%;">
											<div class="col-lg-12">
												<label>Total number of <br> charges per week for all <br> batteries of this type <font color="red">*</font></label>
											</div>
										</div>
										<div class="form-group" style="width:22.5%;">
												<div class="col-lg-12">
													<label>Typical charge <br> duration for single <br> charge (hours) <font color="red">*</font></label>
												</div>
											</div>
										</div>
										
										<%
										String[] ehe_type_array = {""};
										String[] ampere_hours_array = {""};
										String[] voltage_array = {""};
										String[] total_charges_array = {""};
										String[] total_charge_duration_array = {""};
										if (ampere_hours.length() != 0) {
											ehe_type_array = ehe_type.split("\\*");
											ampere_hours_array = ampere_hours.split("\\*");
											voltage_array = voltage.split("\\*");
											total_charges_array = total_charges.split("\\*");
											total_charge_duration_array = total_charge_duration.split("\\*");
										}
										%>
																				
										<%-- 1st row of EHE in table --%>
										<div class="elect_handling_equipment" style="display:inline-flex;width:100%;">
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="ehe_type[]" type="text" id="required_value" value="<%=ehe_type_array[0]%>" class="form-control" style="width: 140px;"/>
											</div>	
											</div>
											
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="ampere_hours[]" type="text" id="integer" value="<%=ampere_hours_array[0]%>" class="form-control" style="width: 140px;"/>
											</div>	
											</div>
							               
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="voltage[]" type="text" id="integer"  value="<%=voltage_array[0]%>" class="form-control" style="width: 140px;"/>
							               	</div>
							               	</div>
							               
							               	<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="total_charges[]" type="text" id="integer"  value="<%=total_charges_array[0]%>" class="form-control" style="width: 170px;"/>
											</div>
											</div>
							
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="total_charge_duration[]" type="text" id="integer" value="<%=total_charge_duration_array[0]%>" class="form-control" style="width: 150px;"/>
											</div>	
											</div>
							
							              	<div class="form-group" style="padding-right:0.5em;">
							              	<div class="col-lg-4">
							                       <button type="button" class="btn btn-default btn-sm add_EHE_Button" id="EHE_button" style="width:70px;" data-template="textbox">Add</button>
							                </div>
											</div>
										</div>
										
										<% 
										if (fromEdit != null || fromLink == true) { 
											if (ampere_hours_array.length > 1) {
												for (int i = 1; i < ampere_hours_array.length; i++) {
										%>
												<div class="elect_handling_equipment" style="display:inline-flex;width:100%;">
													<div class="form-group" style="padding-right:2em;">
													<div class="col-lg-12 EHE">
														<input name="ehe_type[]" type="text" id="required_value" value="<%=ehe_type_array[i]%>" class="form-control" style="width: 140px;"/>
													</div>	
													</div>
													
													<div class="form-group" style="padding-right:2em;">
													<div class="col-lg-12 EHE">
														<input name="ampere_hours[]" type="text" id="integer" value="<%=ampere_hours_array[i]%>" class="form-control" style="width: 140px;"/>
													</div>	
													</div>
									               
													<div class="form-group" style="padding-right:2em;">
													<div class="col-lg-12 EHE">
														<input name="voltage[]" type="text" id="integer"  value="<%=voltage_array[i]%>" class="form-control" style="width: 140px;"/>
									               	</div>
									               	</div>
									               
									               	<div class="form-group" style="padding-right:2em;">
													<div class="col-lg-12 EHE">
														<input name="total_charges[]" type="text" id="integer"  value="<%=total_charges_array[i]%>" class="form-control" style="width: 170px;"/>
													</div>
													</div>
									
													<div class="form-group" style="padding-right:2em;">
													<div class="col-lg-12 EHE">
														<input name="total_charge_duration[]" type="text" id="integer" value="<%=total_charge_duration_array[i]%>" class="form-control" style="width: 150px;"/>
													</div>	
													</div>
									
									              	<div class="form-group" style="padding-right:0.5em;">
									              	<div class="col-lg-4">
									                       <button type="button" class="btn btn-default btn-sm remove_EHE_Button" id="remove_EHE_Button" style="width:70px;">Remove</button>
									                </div>
													</div>
												</div>										
										<% 
												}
											}
										}
										%>
						             
						             	<%-- Hidden row of zone to be used for cloning --%>
										<div id='elect_handling_equipment_row' class="elect_handling_equipment_row hide" style="display:inline-flex;width:100%;">
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="ehe_type[]" type="text" class="form-control" style="width: 140px;"/>
											</div>	
											</div>
											
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="ampere_hours[]" type="text" class="form-control" style="width: 140px;"/>
												</div>	
											</div>
     
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="voltage[]" type="text" class="form-control" style="width: 140px;"/>
											</div>
											</div>

											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="total_charges[]" type="text" class="form-control" style="width: 170px;"/>
											</div>
											</div>
						
											<div class="form-group" style="padding-right:2em;">
											<div class="col-lg-12 EHE">
												<input name="total_charge_duration[]" type="text" class="form-control" style="width: 150px;"/>
											</div>	
											</div>
						              
											<div class="form-group" style="padding-right:0.5em;">
											<div class="col-lg-4">
											       <button type="button" class="btn btn-default btn-sm remove_EHE_Button" style="width:70px;">Remove</button>
											</div>
											</div>    
										</div>
						                 
						                 <br><br><br>
									</div>
						  	
									<hr>
									
									<h5>External Lighting</h5>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_ext_area_illuminated">What is the total external area illuminated? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers" name="site_info_ext_area_illuminated" style="width: 420px;" value="<%=site_info_ext_area_illuminated%>"></input>&nbsp;&nbsp;m<sup>2</sup>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_hours_area_lit">How many hours on average is this area lit per week? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers" name="site_info_hours_area_lit" style="width: 420px;" value="<%=site_info_hours_area_lit%>"></input>&nbsp;&nbsp;hours
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_ext_area_controlled">How is the external lighting controlled? <font color="red">*</font></label>
									<div class="col-lg-6">
										<div class="checkbox">
											<% if (site_info_ext_area_controlled.equals("Manually controlled")) { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Manually controlled" checked />Manually controlled</label>
											<% } else { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Manually controlled" />Manually controlled</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_ext_area_controlled.equals("Timers that do not adjust for different daylight hours throughout the year")) { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Timers that do not adjust for different daylight hours throughout the year" checked />Timers that <u>do not</u> adjust for different daylight hours throughout the year</label>
											<% } else { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Timers that do not adjust for different daylight hours throughout the year" />Timers that <u>do not</u> adjust for different daylight hours throughout the year</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_ext_area_controlled.equals("Timers that adjust for different daylight hours throughout the year")) { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Timers that adjust for different daylight hours throughout the year" checked />Timers that adjust for different daylight hours throughout the year</label>
											<% } else { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Timers that adjust for different daylight hours throughout the year" />Timers that adjust for different daylight hours throughout the year</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_ext_area_controlled.equals("Daylight sensors")) { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Daylight sensors" checked />Daylight sensors</label>
											<% } else { %>
												<label><input type="checkbox" id="site_info_ext_area_controlled" name="site_info_ext_area_controlled" value="Daylight sensors" />Daylight sensors</label>
											<% } %>
										</div>
									</div>
									</div>
									<hr>
									
									<h5>Office Heating</h5>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_office_heating">What type of office heating is installed?</label>
									<div class="col-lg-6">
										<div class="checkbox">
											<% if (site_info_office_heating.equals("No heating system installed")) { %>
												<label><input type="checkbox" name="site_info_office_heating" value="No heating system installed" checked />No heating system installed</label>
											<% } else { %>
												<label><input type="checkbox" name="site_info_office_heating" value="No heating system installed" />No heating system installed</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_office_heating.equals("Central boiler with radiators")) { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Central boiler with radiators" checked />Central boiler with radiators</label>
											<% } else { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Central boiler with radiators" />Central boiler with radiators</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_office_heating.equals("Electrical heating (heatpumps)")) { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Electrical heating (heatpumps)" checked />Electrical heating (heatpumps)</label>
											<% } else { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Electrical heating (heatpumps)" />Electrical heating (heatpumps)</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_office_heating.equals("Electrical heating (other)")) { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Electrical heating (other)" checked />Electrical heating (other)</label>
											<% } else { %>
												<label><input type="checkbox" name="site_info_office_heating" value="Electrical heating (other)" />Electrical heating (other)</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_age_heating_system">What is the age of the site's main office heating system?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_age_heating_system.equals("0 to 5 years")) { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="0 to 5 years" checked />0 to 5 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="0 to 5 years" />0 to 5 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_age_heating_system.equals("6 to 10 years")) { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="6 to 10 years" checked />6 to 10 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="6 to 10 years" />6 to 10 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_age_heating_system.equals("11 to 15 years")) { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="11 to 15 years" checked />11 to 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="11 to 15 years" />11 to 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_age_heating_system.equals("Over 15 years")) { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="Over 15 years" checked />Over 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="Over 15 years" />Over 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_age_heating_system.equals("Don\'t know")) { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="Don\'t know" checked />Don't know</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_age_heating_system" value="Don\'t know" />Don't know</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_serviced_heating_system">How often is the main office heating system serviced?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_serviced_heating_system.equals("Annually")) { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="Annually" checked />Annually</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="Annually" />Annually</label>
											<% } %>
										</div>										
										<div class="radio">
											<% if (site_info_serviced_heating_system.equals("Every 2 years")) { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="Every 2 years" checked />Every 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="Every 2 years" />Every 2 years</label>
											<% } %>
										</div>	
										<div class="radio">
											<% if (site_info_serviced_heating_system.equals("More than 2 years")) { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="More than 2 years" checked />More than 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_serviced_heating_system" value="More than 2 years" />More than 2 years</label>
											<% } %>
										</div>	
									</div>
									</div>
						            
						            <div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_length_uninsulated_pipes">What is the estimated length of uninsulated pipes in the boiler room? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers" name="site_info_length_uninsulated_pipes" style="width: 420px;" value="<%=site_info_length_uninsulated_pipes%>"></input>&nbsp;&nbsp;m
									</div>
									</div>
						
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_num_uninsulated_valves">What is the estimated number of uninsulated valves in the boiler room? <font color="red">*</font></label>
									<div class="col-lg-6">
										<input type="text" class="form-control" id="numbers" name="site_info_num_uninsulated_valves" style="width: 420px;" value="<%=site_info_num_uninsulated_valves%>"></input>
									</div>
									</div>
						            
									<hr>
									
									<h5>Hot Water Production</h5>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_hot_water_toilets_washing">How is hot water for toilets and washing produced?</label>
									<div class="col-lg-6">
										<div class="checkbox">
											<% if (site_info_hot_water_toilets_washing.equals("Gas boiler with storage tank")) { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Gas boiler with storage tank" checked />Gas boiler with storage tank</label>
											<% } else { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Gas boiler with storage tank" />Gas boiler with storage tank</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_hot_water_toilets_washing.equals("Electrical heater with storage tank")) { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Electrical heater with storage tank" checked />Electrical heater with storage tank</label>
											<% } else { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Electrical heater with storage tank" />Electrical heater with storage tank</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_hot_water_toilets_washing.equals("Local heating in each toilet/kitchen")) { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Local heating in each toilet/kitchen" checked />Local heating in each toilet/kitchen</label>
											<% } else { %>
												<label><input type="checkbox" id="" name="site_info_hot_water_toilets_washing" value="Local heating in each toilet/kitchen" />Local heating in each toilet/kitchen</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_storage_tank_insulated">If there is a storage tank is it well insulated?</label>
									<div class="col-lg-6">
										<div class="radio">
										<% if (site_info_storage_tank_insulated.equals("Yes")) { %>
											<label><input type="radio" id="" name="site_info_storage_tank_insulated" value="Yes" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_storage_tank_insulated" value="Yes" />Yes</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_storage_tank_insulated.equals("No")) { %>
											<label><input type="radio" id="" name="site_info_storage_tank_insulated" value="No" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_storage_tank_insulated" value="No" />No</label>
										<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_hot_water_heating_controlled">If there is a storage tank, how is the hot water heating controlled?</label>
									<div class="col-lg-6">
										<div class="radio">
										<% if (site_info_hot_water_heating_controlled.equals("Manual (on all the time)")) { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Manual (on all the time)" checked />Manual (on all the time)</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Manual (on all the time)" />Manual (on all the time)</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_hot_water_heating_controlled.equals("Manual (turned off during low demand)")) { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Manual (turned off during low demand))" checked />Manual (turned off during low demand)</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Manual (turned off during low demand)" />Manual (turned off during low demand)</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_hot_water_heating_controlled.equals("Timers")) { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Timers" checked />Timers</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_hot_water_heating_controlled" value="Timers" />Timers</label>
										<% } %>
										</div>
									</div>
									</div>
						            
						            <hr>
						            
						            <h5>Office Cooling</h5>
						            <div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_office_cooling">What type of office cooling is installed?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_office_cooling.equals("No cooling system is installed")) { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="No cooling system is installed" checked />No cooling system is installed</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="No cooling system is installeds" />No cooling system is installed</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_office_cooling.equals("Split cooling system")) { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="Split cooling system" checked />Split cooling system</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="Split cooling system" />Split cooling system</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_office_cooling.equals("Central cooling with ducted air system")) { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="Central cooling with ducted air system" checked />Central cooling with ducted air system</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_office_cooling" value="Central cooling with ducted air system" />Central cooling with ducted air system</label>
											<% } %>
										</div>
						            </div>
						            </div>
						            
						            <div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_cooling_age">What is the age of the site's main cooling system?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_cooling_age.equals("0 to 5 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="0 to 5 years" checked />0 to 5 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="0 to 5 years" />0 to 5 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_cooling_age.equals("6 to 10 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="6 to 10 years" checked />6 to 10 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="6 to 10 years" />6 to 10 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_cooling_age.equals("11 to 15 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="11 to 15 years" checked />11 to 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="11 to 15 years" />11 to 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_cooling_age.equals("Over 15 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="Over 15 years" checked />Over 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="Over 15 years" />Over 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_cooling_age.equals("Don\'t know")) { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="Don\'t know" checked />Don't know</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_age" value="Don\'t know" />Don't know</label>
											<% } %>
										</div>
									</div>
									</div>
						
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_cooling_serviced">How often is the main cooling system serviced?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_cooling_serviced.equals("Annually")) { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="Annually" checked />Annually</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="Annually" />Annually</label>
											<% } %>
										</div>										
										<div class="radio">
											<% if (site_info_cooling_serviced.equals("Every 2 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="Every 2 years" checked />Every 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="Every 2 years" />Every 2 years</label>
											<% } %>
										</div>	
										<div class="radio">
											<% if (site_info_cooling_serviced.equals("More than 2 years")) { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="More than 2 years" checked />More than 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_cooling_serviced" value="More than 2 years" />More than 2 years</label>
											<% } %>
										</div>	
									</div>
									</div>
									<hr>
						
									<h5>Warehouse Heating</h5>
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_warehouse_heating">What type of warehouse heating is installed?</label>
									<div class="col-lg-6">
										<div class="checkbox">
											<% if (site_info_warehouse_heating.equals("No warehouse heating system installed")) { %>
												<label><input type="checkbox" id="" name="site_info_warehouse_heating" value="No warehouse heating system installed" checked />No warehouse heating system installed</label>
											<% } else { %>
												<label><input type="checkbox" id="" name="site_info_warehouse_heating" value="No warehouse heating system installed" />No warehouse heating system installed</label>
											<% } %>
										</div>
										<div class="checkbox">
											<% if (site_info_warehouse_heating.equals("Ceiling mounted gas burners")) { %>
												<label><input type="checkbox" id="" name="site_info_warehouse_heating" value="Ceiling mounted gas burners" checked />Ceiling mounted gas burners</label>
											<% } else { %>
												<label><input type="checkbox" id="" name="site_info_warehouse_heating" value="Ceiling mounted gas burners" />Ceiling mounted gas burners</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_warehouse_heating_age">What is the age of the site's main warehouse heating system?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_warehouse_heating_age.equals("0 to 5 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="0 to 5 years" checked />0 to 5 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="0 to 5 years" />0 to 5 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_warehouse_heating_age.equals("6 to 10 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="6 to 10 years" checked />6 to 10 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="6 to 10 years" />6 to 10 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_warehouse_heating_age.equals("11 to 15 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="11 to 15 years" checked />11 to 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="11 to 15 years" />11 to 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_warehouse_heating_age.equals("Over 15 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="Over 15 years" checked />Over 15 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="Over 15 years" />Over 15 years</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_warehouse_heating_age.equals("Don\'t know")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="Don\'t know" checked />Don't know</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_age" value="Don\'t know" />Don't know</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_warehouse_heating_serviced">How often is the main warehouse heating system serviced?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_warehouse_heating_serviced.equals("Annually")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="Annually" checked />Annually</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="Annually" />Annually</label>
											<% } %>
										</div>										
										<div class="radio">
											<% if (site_info_warehouse_heating_serviced.equals("Every 2 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="Every 2 years" checked />Every 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="Every 2 years" />Every 2 years</label>
											<% } %>
										</div>	
										<div class="radio">
											<% if (site_info_warehouse_heating_serviced.equals("More than 2 years")) { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="More than 2 years" checked />More than 2 years</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_warehouse_heating_serviced" value="More than 2 years" />More than 2 years</label>
											<% } %>
										</div>	
									</div>
									</div>
									<hr>
									
									<h5>Office Ventilation</h5>	
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_central_fan">Are any office areas mechanically ventilated with a central fan?</label>
									<div class="col-lg-6">
										<div class="radio">
										<% if (site_info_central_fan.equals("Yes")) { %>
											<label><input type="radio" id="" name="site_info_central_fan" value="Yes" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_central_fan" value="Yes" />Yes</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_central_fan.equals("No")) { %>
											<label><input type="radio" id="" name="site_info_central_fan" value="No" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_central_fan" value="No" />No</label>
										<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_fan_controlled">If yes, how if the fan controlled?</label>
									<div class="col-lg-6">
										<div class="radio">
										<% if (site_info_fan_controlled.equals("Not controlled (on all the time)")) { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Not controlled (on all the time)" checked />Not controlled (on all the time)</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Not controlled (on all the time)" />Not controlled (on all the time)</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_fan_controlled.equals("Timer")) { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Timer" checked />Timer</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Timer" />Timer</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_fan_controlled.equals("Variable speed")) { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Variable speed" checked />Variable speed</label>
										<% } else { %>
											<label><input type="radio" id="" name="site_info_fan_controlled" value="Variable speed" />Variable speed</label>
										<% } %>
										</div>
									</div>
									</div>
									<hr>
						
									<h5>Electrical Infrastructure</h5>
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_vol_red_opt_eq">Does the site have voltage reduction or optimising equipment installed?</label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_vol_red_opt_eq.equals("Yes")) { %>
												<label><input type="radio" id="" name="site_info_vol_red_opt_eq" value="Yes" checked />Yes</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_vol_red_opt_eq" value="Yes" />Yes</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_vol_red_opt_eq.equals("No")) { %>
												<label><input type="radio" id="" name="site_info_vol_red_opt_eq" value="No" checked />No</label>
											<% } else { %>
												<label><input type="radio" id="" name="site_info_vol_red_opt_eq" value="No" />No</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_electricity_meter">Does your site have more than one electricity meter for billing? <font color="red">*</font></label>
									<div class="col-lg-6">
										<div class="radio">
											<% if (site_info_electricity_meter.equals("Yes")) { %>
												<label><input type="radio" id="site_info_electricity_meter" name="site_info_electricity_meter" value="Yes" checked />Yes</label>
											<% } else { %>
												<label><input type="radio" id="site_info_electricity_meter" name="site_info_electricity_meter" value="Yes" />Yes</label>
											<% } %>
										</div>
										<div class="radio">
											<% if (site_info_electricity_meter.equals("No")) { %>
												<label><input type="radio" id="site_info_electricity_meter" name="site_info_electricity_meter" value="No" checked />No</label>
											<% } else { %>
												<label><input type="radio" id="site_info_electricity_meter" name="site_info_electricity_meter" value="No" />No</label>
											<% } %>
										</div>
									</div>
									</div>
									
									<div class="form-group">
									<label class="col-lg-5 control-label" for="site_info_sub_meters">Does your site have any sub-meters? <font color="red">*</font></label>
									<div class="col-lg-6">
										<div class="radio">
										<% if (site_info_sub_meters.equals("Yes")) { %>
											<label><input type="radio" id="site_info_sub_meters" name="site_info_sub_meters" value="Yes" onchange="function1(this.id)" checked />Yes</label>
										<% } else { %>
											<label><input type="radio" id="site_info_sub_meters" name="site_info_sub_meters" value="Yes" onchange="function1(this.id)" />Yes</label>
										<% } %>
										</div>
										<div class="radio">
										<% if (site_info_sub_meters.equals("No")) { %>
											<label><input type="radio" id="site_info_sub_meters" name="site_info_sub_meters" value="No" checked />No</label>
										<% } else { %>
											<label><input type="radio" id="site_info_sub_meters" name="site_info_sub_meters" value="No" />No</label>
										<% } %>
										</div>
									</div>
									</div>
									<hr>
						
						
									<%--INCOMPLETE--%>
									<h5>Energy Reduction Initiatives</h5>
										<div id="energy_red_initiatives_done">
											<%-- Headings in table --%>
											<div class="ERI_done_headings" style="display:inline-flex;width:100%;">
											<div class="form-group" style="padding-right:2em;width:26%;">
												<div class="col-lg-12">
													<label>What was done?</label>
												</div>
											</div>
											<div class="form-group" style="width:24%;">
												<div class="col-lg-12">
													<label>When?</label>
												</div>
											</div>
											<div class="form-group" style="width:27%;">
												<div class="col-lg-12">
													<label>Which Zone?</label>
												</div>
											</div>
											<div class="form-group" style="width:25%;">
													<div class="col-lg-12">
														<label>What was the impact?</label>
													</div>
												</div>
											</div>
									
											<%-- 1st row of Energy Reduction Initiatives - Done in table --%>
											<div class="ERI_done" style="display:inline-flex;width:100%;">
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done[]" type="text" class="form-control" id="" style="width: 180px;"/>
												</div>	
												</div>
									              
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_when[]" type="text"  class="form-control" id="" style="width: 160px;"/>
									              	</div>
									              	</div>
									              
									              	<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_zone[]" type="text" class="form-control" id="" style="width: 180px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_impact[]" type="text" class="form-control" id="" style="width: 180px;"/>
												</div>	
												</div>
									
									             	<div class="form-group" style="padding-right:2em;">
									             	<div class="col-lg-4">
									                      <button type="button" class="btn btn-default btn-sm add_ERI_done_Button" id="ERI_done_button" style="width:70px;" data-template="textbox">Add</button>
									               </div>
												</div>
											</div>
									           
									           	<%-- Hidden row of zone to be used for cloning --%>
											<div id='ERI_done_row' class="ERI_done_row hide" style="display:inline-flex;width:100%;">
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done[]" type="text" class="form-control" id="" style="width: 180px;"/>
													</div>	
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_when[]" type="text"  class="form-control" id="" style="width: 160px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_zone[]" type="text" class="form-control" id="" style="width: 180px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_done_impact[]" type="text" class="form-control" id="" style="width: 180px;"/>
												</div>	
												</div>
									            
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-4">
												       <button type="button" class="btn btn-default btn-sm remove_ERI_done_Button" style="width:70px;">Remove</button>
												</div>
												</div>    
											</div> 
										</div>
										<hr>
										<div id="energy_red_initiatives_planned">
											<%-- Headings in table --%>
											<div class="ERI_planned_headings" style="display:inline-flex;width:100%;">
											<div class="form-group" style="padding-right:2em;width:26%;">
												<div class="col-lg-12">
													<label>What is planned?</label>
												</div>
											</div>
											<div class="form-group" style="width:24%;">
												<div class="col-lg-12">
													<label>By When?</label>
												</div>
											</div>
											<div class="form-group" style="width:27%;">
												<div class="col-lg-12">
													<label>Which Zone?</label>
												</div>
											</div>
											<div class="form-group" style="width:25%;">
													<div class="col-lg-12">
														<label>What is the expected impact?</label>
													</div>
												</div>
											</div>
									
											<%-- 1st row of Energy Reduction Initiatives - Planned in table --%>
											<div class="ERI_planned" style="display:inline-flex;width:100%;">
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned[]" type="text" class="form-control" style="width: 180px;"/>
												</div>	
												</div>
									              
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_when[]" type="text"  class="form-control" style="width: 160px;"/>
									              	</div>
									              	</div>
									              
									              	<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_zone[]" type="text" class="form-control" style="width: 180px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_impact[]" type="text" class="form-control" style="width: 180px;"/>
												</div>	
												</div>
									
									             	<div class="form-group" style="padding-right:2em;">
									             	<div class="col-lg-4">
									                      <button type="button" class="btn btn-default btn-sm add_ERI_planned_Button" id="ERI_done_button" style="width:70px;" data-template="textbox">Add</button>
									               </div>
												</div>
											</div>
									           
									           	<%-- Hidden row of zone to be used for cloning --%>
											<div id='ERI_planned_row' class="ERI_done_row hide" style="display:inline-flex;width:100%;">
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned[]" type="text" class="form-control" style="width: 180px;"/>
													</div>	
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_zone[]" type="text"  class="form-control" style="width: 160px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_when[]" type="text" class="form-control" style="width: 180px;"/>
												</div>
												</div>
									
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-12">
													<input name="site_info_initiatives_planned_impact[]" type="text" class="form-control" style="width: 180px;"/>
												</div>	
												</div>
									            
												<div class="form-group" style="padding-right:2em;">
												<div class="col-lg-4">
												       <button type="button" class="btn btn-default btn-sm remove_ERI_planned_Button" style="width:70px;">Remove</button>
												</div>
												</div>    
											</div>
									               
									               
										</div>		
						            <br><br>
            					</div>
          					</div>
        				</div>
    				</div>
				</div>
			</section>
		</div>
		<div class="btn-group" style="margin-left: 82%">
			<button class="btn" id="prevtab" type="button" onclick="prev_tab();">Previous</button>
	    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
	    	
		</div>
	</div>
 
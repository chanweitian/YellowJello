<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.*,utility.*" %>
<%@include file="../protectusers.jsp" %>

<%String company = (String) session.getAttribute("company");
int month = PeriodManager.getMonthInt(company);
Calendar cal = Calendar.getInstance();
cal.set(Calendar.MONTH,month);
cal.set(Calendar.DATE,1);
Calendar today = Calendar.getInstance();
int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
if (today.before(cal)) {
	previousYear -= 1;
}%>
			
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../header.jsp" %>

	<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>GTL Energy Certificate Questionnaire</title>
		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		
		<%-- JQuery script --%>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		
		<%-- Questionnaire validation --%>
		<link rel="stylesheet" href="../css/bootstrap.css"/>
		<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	
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
		  
  	<br><br>
  	
 	<%
    String quest_id = request.getParameter("quest_id");
	session.setAttribute("quest_id",quest_id);
			
	String where_past = "questionnaire_id = \'" + quest_id + "\'";
	RetrievedObject past_quest_ro = SQLManager.retrieveRecords("questionnaire", where_past);
	ResultSet past_quest_rs = past_quest_ro.getResultSet();
	
    %>
  	
  	<div class="main">
		<div class="header">
           View Past GTL Energy Certificate Questionnaires
        </div>
        <div class="page-header" style="padding-left:2.5em;">
			Questionnaire ID: <%=quest_id%>
        </div>
        <% while (past_quest_rs.next()) { 
		        String quest_year = past_quest_rs.getString("year");
		%>
		<form action="../visual/calculate" class="form-horizontal" method="post">
			<%-- to pass to VisualOutput.jsp --%>
			<input type="hidden" name="quest_id" value="<%=quest_id%>" />
			<%@include file="PastQuestionnaire/SiteDef.jsp" %>
			
			<div class="container">
				<div class="row">
					<%-- Site Info part --%>
					<div class="page-header">
						<br><img src="../icons/icon_info.png" height="4%" width="4%">&nbsp;&nbsp;Site Information
					</div>
					<div class="quest_subtitle">
						Site Data and User Information<br><br>
					</div>
					<% 	String site_id = past_quest_rs.getString("site_id");
					String where_site = "Site_ID = \'" + site_id + "\'";
					RetrievedObject past_site_ro = SQLManager.retrieveRecords("site", where_site);
					ResultSet past_site_rs = past_site_ro.getResultSet();
					try {
						while(past_site_rs.next()) { %>
							<div class="past_quest_table">
								<div class="col1">What is the name of the site?</div>
								<div class="col2"><%=past_site_rs.getString("site_info_name")%></div>
								<div class="col3"></div>
								<div class="col4">Site Reference?</div>
								<div class="col5"><%=past_quest_rs.getString("site_info_reference")%></div>
							</div>
							<div class="past_quest_table">	
								<div class="col1">Site Business Unit?</div>
								<div class="col2"><%=past_quest_rs.getString("site_info_business_unit")%></div>
								<div class="col3"></div>
								<div class="col4">Is the site under a leasehold or freehold?</div>
								<div class="col5"><%=past_quest_rs.getString("site_info_leasehold_freehold")%></div>
							</div>
							<div class="past_quest_table">	
								<div class="col1">If leasehold, when does the current lease expire?</div>
								<div class="col2"><%=past_quest_rs.getString("site_info_lease_expire")%></div>
								<div class="col3"></div>
								<div class="col4">If applicable, when does the current customer contract expire?</div>
								<div class="col5"><%=past_quest_rs.getString("site_info_contract_expire")%></div>
							</div>	
							<hr>
							<div class="past_quest_table">
								<div class="col1">What is the site address?</div>
							</div>
							<div class="past_quest_table">	
								<div class="col1">Street + Number</div>
								<div class="col2"><%=past_site_rs.getString("site_info_address_street") %></div>
								<div class="col3"></div>
								<div class="col4">State</div>
								<div class="col5"><%=past_site_rs.getString("site_info_address_city")%></div>	
							</div>
							<div class="past_quest_table">	
								<div class="col1">Postal</div>
								<div class="col2"><%=past_site_rs.getString("site_info_address_postal")%></div>
								<div class="col3"></div>
								<div class="col4">Country</div>
								<div class="col5"><%=past_site_rs.getString("site_info_address_country")%></div>	
							</div>
							<% }
						} catch(SQLException e) {
							e.printStackTrace();
						} 
						past_site_ro.close();%>
					<hr>
					<div class="past_quest_table">
						<div class="col1">What is your contact information?</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Name</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_contact_name")%></div>
						<div class="col3"></div>
						<div class="col4">Job title</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_contact_job_title")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Phone Number</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_contact_phone")%></div>
						<div class="col3"></div>
						<div class="col4">Email Address</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_contact_email")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">What activities and services are carried out on site?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_activities_services")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<div class="quest_subtitle">
						<br>Communication and Energy Management<br><br>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Do you have a nominated Sustainability Champion?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_sustainability_champion")%></div>
						<div class="col3"></div>
						<div class="col4">Whose reduction targets are working towards?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_reduction_targets")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">At what level are these targets set?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_targets_level")%></div>
						<div class="col3"></div>
						<div class="col4">Are these carbon reduction targets communicated to employees? If so how?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_carbon_reduction_targets")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Have you launched an employee awareness program?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_employee_awareness_program")%></div>
						<div class="col3"></div>
						<div class="col4">Does your site have easy access to your sites energy data?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_access_to_energy_data")%></div>
					</div>
					<div class="quest_subtitle">
						<br>Site Construction and Other Information<br><br>
					</div>
					<div class="past_quest_table">
						<div class="col1">Loading Bays</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How many truck loading bays does your site have in total?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_truck_loading_bays")%></div>
						<div class="col3"></div>
						<div class="col4">How many of your bays have dock seals?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_bays_dock_seals")%></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Electric Handling Equipment</div>
					</div>
					<%
					String[] ampere_hours_array = past_quest_rs.getString("ampere_hours").split("\\*");
					String[] voltage_array = past_quest_rs.getString("voltage").split("\\*");
					String[] charge_array = past_quest_rs.getString("total_charges").split("\\*");
					String[] duration_array = past_quest_rs.getString("total_charge_duration").split("\\*");
					%>
					<div id="elect_handling_equipment">		
						<%-- Headings in table --%>
						<div class="EHE_headings" style="display:inline-flex;width:75%;">
						<div class="form-group" style="padding-right:2em;width:25%;">
							<div class="col-lg-12">
								<label>Ampere-hours (Ah)</label>
							</div>
						</div>
						<div class="form-group" style="width:25%;">
							<div class="col-lg-12">
								<label>Voltage (V)</label>
							</div>
						</div>
						<div class="form-group" style="width:25%;">
							<div class="col-lg-12">
								<label>Total number of charges <br> per week for all batteries <br> of this type</label>
							</div>
						</div>
						<div class="form-group" style="width:25%;">
								<div class="col-lg-12">
									<label>Typical charge duration (hours)</label>
								</div>
							</div>
						</div>
						<% 
						for (int i = 0; i < ampere_hours_array.length; i++) {
							String ampere_hours = ampere_hours_array[i];
							String voltage = voltage_array[i];
							String charge = charge_array[i];
							String duration = duration_array[i];
						%>
							<%-- 1st row of EHE in table --%>
							<div class="elect_handling_equipment" style="display:inline-flex;width:100%;">
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="ampere_hours[]" type="text"  class="form-control" style="width: 160px;" value="<%=ampere_hours%>" disabled />
								</div>	
								</div>
				               
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="voltage[]" type="text"  class="form-control"  style="width: 160px;" value="<%=voltage%>" disabled />
				               	</div>
				               	</div>
				               
				               	<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="total_charges[]" type="text" class="form-control" style="width: 160px;" value="<%=charge%>" disabled />
								</div>
								</div>
				
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="total_charge_duration[]" type="text" class="form-control" style="width: 160px;" value="<%=duration%>" disabled />
								</div>	
								</div>
							</div>
						<% } %>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">External Lighting</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">What is the total external area illuminated?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_ext_area_illuminated")%>&nbsp;&nbsp;m<sup>2</sup></div>
						<div class="col3"></div>
						<div class="col4">How many hours on average is this area lit per week?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_hours_area_lit")%>&nbsp;&nbsp;hours</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How is the external lighting controlled?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_ext_area_controlled")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Office Heating</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">What type of office heating is installed?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_office_heating")%></div>
						<div class="col3"></div>
						<div class="col4">What is the age of the site's main office heating system?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_age_heating_system")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How often is the main office heating system serviced?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_serviced_heating_system")%>&nbsp;&nbsp;</div>
						<div class="col3"></div>
						<div class="col4">What is the estimated length of uninsulated pipes in the boiler room?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_length_uninsulated_pipes")%></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Hot Water Production</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How is hot water for toilets and washing produced?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_hot_water_toilets_washing")%></div>
						<div class="col3"></div>
						<div class="col4">If there is a storage tank, is it well insulated?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_storage_tank_insulated")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">If there is a storage tank, how is the hot water heating controlled?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_hot_water_heating_controlled")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Office Cooling</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">What type of office cooling is installed?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_office_cooling")%></div>
						<div class="col3"></div>
						<div class="col4">What is the age of the site's main cooling system?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_cooling_age")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How often is the main cooling system serviced?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_cooling_serviced")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Warehouse Heating</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">What type of warehouse heating is installed?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_warehouse_heating")%></div>
						<div class="col3"></div>
						<div class="col4">What is the age of the site's main warehouse heating system?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_warehouse_heating_age")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">How often is the main warehouse heating system serviced?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_warehouse_heating_serviced")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Office Ventilation</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Are any office areas mechanically ventilated with a central fan?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_central_fan")%></div>
						<div class="col3"></div>
						<div class="col4">If yes, how if the fan controlled?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_fan_controlled")%></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">Electrical Infrastructure</div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Does the site have voltage reduction or optimising equipment installed?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_vol_red_opt_eq")%></div>
						<div class="col3"></div>
						<div class="col4">Does your site have more than one electricity meter for billing?</div>
						<div class="col5"><%=past_quest_rs.getString("site_info_electricity_meter")%></div>
					</div>
					<div class="past_quest_table">	
						<div class="col1">Does your site have any sub-meters?</div>
						<div class="col2"><%=past_quest_rs.getString("site_info_sub_meters")%></div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>			
					<hr>
					<div class="past_quest_table">
						<div class="col1">Energy Reduction Initiatives</div>
					</div>
					<%
					String[] done_array = past_quest_rs.getString("site_info_initiatives_done").split("\\*");
					String[] done_when_array = past_quest_rs.getString("site_info_initiatives_done_when").split("\\*");
					String[] done_zone_array = past_quest_rs.getString("site_info_initiatives_done_zone").split("\\*");
					String[] done_impact_array = past_quest_rs.getString("site_info_initiatives_done_impact").split("\\*");
					%>
					<div id="energy_red_initiatives_done">
						<%-- Headings in table --%>
						<div class="ERI_done_headings" style="display:inline-flex;width:100%;">
						<div class="form-group" style="padding-right:2em;width:35%;">
							<div class="col-lg-12">
								<label>What was done?</label>
							</div>
						</div>
						<div class="form-group" style="width:17%;">
							<div class="col-lg-12">
								<label>When?</label>
							</div>
						</div>
						<div class="form-group" style="width:16.5%;">
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
						<% 
						for (int i = 0; i < done_array.length; i++) {
							String done = done_array[i];
							String done_when = done_when_array[i];
							String done_zone = done_zone_array[i];
							String done_impact = done_impact_array[i];
						%>
							<%-- 1st row of Energy Reduction Initiatives - Done in table --%>
							<div class="ERI_done" style="display:inline-flex;width:100%;">
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_done[]" type="text" class="form-control" style="width: 350px;" value="<%=done%>" disabled/>
								</div>	
								</div>
					              
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_done_when[]" type="text"  class="form-control" style="width: 140px;" value="<%=done_when%>" disabled/>
					              	</div>
					              	</div>
					              
					              	<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_done_zone[]" type="text" class="form-control" style="width: 140px;" value="<%=done_zone%>" disabled/>
								</div>
								</div>
					
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_done_impact[]" type="text" class="form-control" style="width: 350px;" value="<%=done_impact%>" disabled/>
								</div>	
								</div>
							</div>
						<% } %>
					</div>
					
					<%
					String[] planned_array = past_quest_rs.getString("site_info_initiatives_planned").split("\\*");
					String[] planned_when_array = past_quest_rs.getString("site_info_initiatives_planned_when").split("\\*");
					String[] planned_zone_array = past_quest_rs.getString("site_info_initiatives_planned_zone").split("\\*");
					String[] planned_impact_array = past_quest_rs.getString("site_info_initiatives_planned_impact").split("\\*");
					%>
					<div id="energy_red_initiatives_planned">
						<%-- Headings in table --%>
						<div class="ERI_planned_headings" style="display:inline-flex;width:100%;">
						<div class="form-group" style="padding-right:2em;width:35%;">
							<div class="col-lg-12">
								<label>What is planned?</label>
							</div>
						</div>
						<div class="form-group" style="width:17%;">
							<div class="col-lg-12">
								<label>By When?</label>
							</div>
						</div>
						<div class="form-group" style="width:16.5%;">
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
						<% 
						for (int i = 0; i < planned_array.length; i++) {
							String planned = planned_array[i];
							String planned_when = planned_when_array[i];
							String planned_zone = planned_zone_array[i];
							String planned_impact = planned_impact_array[i];
						%>
							<%-- 1st row of Energy Reduction Initiatives - Planned in table --%>
							<div class="ERI_planned" style="display:inline-flex;width:100%;">
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_planned[]" type="text" class="form-control" style="width: 350px;" value="<%=planned%>" disabled/>
								</div>	
								</div>
					              
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_planned_when[]" type="text"  class="form-control" style="width: 140px;" value="<%=planned_when%>" disabled/>
					              	</div>
					              	</div>
					              
					              	<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_planned_zone[]" type="text" class="form-control" style="width: 140px;" value="<%=planned_zone%>" disabled/>
								</div>
								</div>
					
								<div class="form-group" style="padding-right:2em;">
								<div class="col-lg-12">
									<input name="site_info_initiatives_planned_impact[]" type="text" class="form-control" style="width: 350px;" value="<%=planned_impact%>" disabled/>
								</div>	
								</div>
							</div>
						<% } %>
					</div>		
					<%-- Site Usage part --%>
					<div class="page-header">
						<br><img src="../icons/icon_info.png" height="4%" width="4%">&nbsp;&nbsp;Usage <%=quest_year%>
					</div>
					<div class="quest_subtitle">
						Electricity<br><br>
					</div>
					<div class="past_quest_table">
						<div class="col1">How many kWh of electricity did your site use in <%=quest_year%>?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_electricity_use")%></div>
						<div class="col3"></div>
						<div class="col4">Data source</div>
						<div class="col5"><%=past_quest_rs.getString("usage_electricity_use_source")%></div>
					</div>
					<div class="past_quest_table">
						<div class="col1">How much did this electricity cost?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_electricty_cost")%>&nbsp;&nbsp;Euro</div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">How many kWh of renewable electricity did your site use in <%=quest_year%>?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_renew_electricity_use")%></div>
						<div class="col3"></div>
						<div class="col4">Data source</div>
						<div class="col5"><%=past_quest_rs.getString("usage_renew_electricity_use_source")%></div>
					</div>
					<div class="past_quest_table">
						<div class="col1">How much did this renewable electricity cost?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_renew_electricty_cost")%>&nbsp;&nbsp;Euro</div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<div class="quest_subtitle">
						Other Fuels<br><br>
					</div>
					<div class="past_quest_table">
						<div class="col1">How many kWh of Natural Gas did your site use in <%=quest_year%>?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_nat_gas_use")%></div>
						<div class="col3"></div>
						<div class="col4">Data source</div>
						<div class="col5"><%=past_quest_rs.getString("usage_nat_gas_use_source")%></div>
					</div>
					<div class="past_quest_table">
						<div class="col1">How much did this Natural Gas cost?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_nat_gas_cost")%>&nbsp;&nbsp;Euro</div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">How many litres of Fuel Oil did your site use in <%=quest_year%>?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_fuel_oil_use")%></div>
						<div class="col3"></div>
						<div class="col4">Data source</div>
						<div class="col5"><%=past_quest_rs.getString("usage_fuel_oil_use_source")%></div>
					</div>
					<div class="past_quest_table">
						<div class="col1">How much did this Fuel Oil cost?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_fuel_oil_cost")%>&nbsp;&nbsp;Euro</div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
					<hr>
					<div class="past_quest_table">
						<div class="col1">How many litres of diesel did your site use in <%=quest_year%>?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_diesel_use")%></div>
						<div class="col3"></div>
						<div class="col4">Data source</div>
						<div class="col5"><%=past_quest_rs.getString("usage_diesel_use_source")%></div>
					</div>
					<div class="past_quest_table">
						<div class="col1">How much did this diesel cost?</div>
						<div class="col2"><%=past_quest_rs.getString("usage_diesel_cost")%>&nbsp;&nbsp;Euro</div>
						<div class="col3"></div>
						<div class="col4"></div>
						<div class="col5"></div>
					</div>
			
			<%
			where_past = "questionnaire_id = \'" + quest_id + "\'";
			RetrievedObject past_site_def_ro = SQLManager.retrieveRecords("site_definition", where_past);
			ResultSet past_site_def_rs = past_site_def_ro.getResultSet();
			
			//store all the zone_ids
			ArrayList<String> site_def_info_list = new ArrayList<String>();
			//store all the all zones' activities
			ArrayList<String> site_def_activity_list = new ArrayList<String>();
			
			while (past_site_def_rs.next()) {
				String site_def_info = past_site_def_rs.getString("site_def_info");
				String site_def_activity = past_site_def_rs.getString("site_def_activity");
				
				//use delimiter ^ to split by building
				String[] site_def_info_array = site_def_info.split("\\^");
				for (String def : site_def_info_array) {
					//use delimiter * to split each building into zones
					String[] def_array = def.split("\\*");
					for (String d : def_array) {
						//add all zones to site_def_info_list regardless of buildings
						site_def_info_list.add(d);
					}
				}
				
				//use delimiter ^ to split by building
				String[] site_def_activity_array = site_def_activity.split("\\^");
				for (String act : site_def_activity_array) {
					//use delimiter * to split each building into zones
					String[] act_array = act.split("\\*");
					for (String a : act_array) {
						//add all zones to site_def_activity_list regardless of buildings
						site_def_activity_list.add(a);
					}
				}
			}
			past_site_def_ro.close();
			
			for (int i = 0; i < site_def_activity_list.size(); i++) {
				
				//set zone_id in session so that each included jsp page (4 diff zones) can use it to retrieve data from table
				session.setAttribute("zone_id",site_def_info_list.get(i));
				
				//retrieve each zone activity to know which file to include
				String act = site_def_activity_list.get(i);
				
				if (act.equals("offices")) { %>
					<%@include file="PastQuestionnaire/Past_Zone_Office.jsp" %>
				<% } else if (act.equals("wh_ground_to_roof")) { %>	
					<%@include file="PastQuestionnaire/Past_Zone_Ground_Roof.jsp" %>
				<% } else if (act.equals("wh_mezzanine")) { %>
					<%@include file="PastQuestionnaire/Past_Zone_Mezzanine.jsp" %>
				<% } else if (act.equals("wh_value_add")) { %>
					<%@include file="PastQuestionnaire/Past_Zone_Warehouse_Value_Add.jsp" %>
				<% 	
				}
			}
			%>
				</div>
			</div>
			<br><br>
			<div class="form-group">
		        <div class="col-md-offset-9">
		            <button type="submit" class="btn btn-primary">View Energy Certificate Visual Output</button>
				</div>
			</div>
		</form>
		<% } 
        past_quest_ro.close();
      		//remove session attribute zone_id and quest_id
			session.removeAttribute("zone_id");
			session.removeAttribute("quest_id");
		%>
	</div>
</body>
</html>
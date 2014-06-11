<fieldset>
	<legend>Site Information</legend>
	
	<div id="wrapper"> 
      <div id="content">  
          <div class="demo">
            <br>
            <h4 class="expand">Site Data and User Information</h4>
            <div class="collapse">
                
                <label for="site_info_name">What is the name of the site?</label>
				<input type="text" name="site_info_name" style="width: 350px;" placeholder="Enter the name that your site is commonly known as."></input>
				
				<label for="site_info_reference">Site Reference?</label>
				<input type="text" name="site_info_reference" style="width: 350px;" ></input>
				
				<label for="site_info_business_unit">Site Business Unit?</label>
				<input type="checkbox" name="site_info_business_unit" value="warehouse_pri">&nbsp;Warehouse Primary&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_business_unit" value="warehouse_sec">&nbsp;Warehouse Secondary&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_business_unit" value="warehouse_transport">&nbsp;Warehouse Transport&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_business_unit" value="other">&nbsp;Other
				
				<label for="site_info_leasehold_freehold">Is the site under a leasehold or freehold?</label>
				<input type="radio" name="site_info_leasehold_freehold" value="leasehold" checked>&nbsp;Leasehold&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_leasehold_freehold" value="freehold">&nbsp;Freehold

				<label for="site_info_lease_expire">If leasehold, when does the current lease expire?</label>
				<input type="text" name="site_info_lease_expire" style="width: 350px;" ></input>
				
				<label for="site_info_contract_expire">If applicable, when does the current customer contract expire?</label>
				<input type="text" name="site_info_contract_expire" style="width: 350px;" ></input>
				
				<label>What is the site address?</label>
				<label for="site_info_address_street">Street + Number</label>
				<input type="text" name="site_info_address_street" style="width: 350px;" ></input>
				<label for="site_info_address_city">City</label>
				<input type="text" name="site_info_address_city" style="width: 350px;" ></input>
				<label for="site_info_address_postal">Postal</label>
				<input type="text" name="site_info_address_postal" style="width: 350px;" ></input>
				<label for="site_info_address_country">Country</label>
				<input type="text" name="site_info_address_country" style="width: 350px;" ></input>
				
				<label>What is your contact information?</label>
				<label for="site_info_contact_name">Name</label>
				<input type="text" name="site_info_contact_name" style="width: 350px;" ></input>
				<label for="site_info_contact_job_title">Job Title</label>
				<input type="text" name="site_info_contact_job_title" style="width: 350px;" ></input>
				<label for="site_info_contact_phone">Phone Number</label>
				<input type="text" name="site_info_contact_phone" style="width: 350px;" ></input>
				<label for="site_info_contact_email">Email Address</label>
				<input type="text" name="site_info_contact_email" style="width: 350px;" ></input>
				
				<label for="site_info_activities_services">What activities and services are carried out on site?</label>
				<textarea rows="4" cols="60" name="site_info_activities_services" placeholder="Please provide a brief description of the type of activities and services carried out at the site."></textarea>
				<br><br>	
            </div>
            <h4 class="expand">Communication and Energy Management</h4>
            <div class="collapse">
                <label for="site_info_sustainability_champion">Do you have a nominated Sustainability Champion?</label>
				<input type="radio" name="site_info_sustainability_champion" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_sustainability_champion" value="no">&nbsp;No
                
                <label for="site_info_reduction_targets">Whose reduction targets are working towards?</label>
				<input type="text" name="site_info_reduction_targets" style="width: 350px;" ></input>
				
				<label for="site_info_targets_level">At what level are these targets set?</label>
				<select name="site_info_targets_level">
					<option value="global">Global</option>
					<option value="country">Country</option>
					<option value="regional">Regional</option>
					<option value="site">Site</option>
					<option value="unknown">Unknown</option>
				</select>
				
				<label for="site_info_carbon_reduction_targets">Are these carbon reduction targets communicated to employees? If so how?</label>
				<input type="checkbox" name="site_info_carbon_reduction_targets" value="not_comm">&nbsp;Not communicated&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_carbon_reduction_targets" value="comm_email">&nbsp;Communicated through emails&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_carbon_reduction_targets" value="comm_posters">&nbsp;Communicated through posters&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_carbon_reduction_targets" value="comm_staff_briefings">&nbsp;Communicated through staff briefings
				
				<label for="site_info_employee_awareness_program">Have you launched an employee awareness program?</label>
				<input type="radio" name="site_info_employee_awareness_program" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_employee_awareness_program" value="no">&nbsp;No
				
				<label for="site_info_access_to_energy_data">Does your site have easy access to your sites energy data?</label>
				<input type="checkbox" name="site_info_access_to_energy_data" value="not_avail">&nbsp;Not available or annual consumption data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_access_to_energy_data" value="easily_avail">&nbsp;Easily available monthly consumption data<br>
				<input type="checkbox" name="site_info_access_to_energy_data" value="detailed_energy_data">&nbsp;Detailed energy data (from automatic meters allowing daily profile curves)
				
                <br><br>
            </div>
            <h4 class="expand">Site Construction and Other Information</h4>
            <div class="collapse">
            	<h5>Loading Bays</h5>
            	<label for="site_info_truck_loading_bays">How many truck loading bays does your site have in total?</label>
				<input type="text" name="site_info_truck_loading_bays" style="width: 350px;" ></input>
            
            	<label for="site_info_bays_dock_seals">How many of your bays have dock seals?</label>
				<input type="text" name="site_info_bays_dock_seals" style="width: 350px;" ></input>
				<hr>
				
				<%-- INCOMPLETE --%>
				<h5>Electric Handling Equipment</h5>
				<label>Typically, this information can be obtained from the person responsible for material handling equipment</label>

		    	
				<hr>
				
				<h5>External Lighting</h5>
				<label for="site_info_ext_area_illuminated">What is the total external area illuminated?</label>
				<input type="text" name="site_info_ext_area_illuminated" style="width: 200px;" ></input>&nbsp;&nbsp;m<sup>2</sup>
				
				<label for="site_info_hours_area_lit">How many hours on average is this area lit per week?</label>
				<input type="text" name="site_info_hours_area_lit" style="width: 200px;" ></input>&nbsp;&nbsp;hours
				
				<label for="site_info_ext_area_controlled">How is the external lighting controlled?</label>
				<input type="checkbox" name="site_info_ext_area_controlled" value="manually controlled">&nbsp;Manually controlled<br>
				<input type="checkbox" name="site_info_ext_area_controlled" value="timers_no_adjust">&nbsp;Timers that do not adjust for different daylight hours throughout the year<br>
				<input type="checkbox" name="site_info_ext_area_controlled" value="timers_adjust">&nbsp;Timers that adjust for different daylight hours throughout the year<br>
				<input type="checkbox" name="site_info_ext_area_controlled" value="daylight_sensors">&nbsp;Daylight sensors
				<hr>
				
				<h5>Office Heating</h5>
				<label for="site_info_office_heating">What type of office heating is installed?</label>
				<input type="checkbox" name="site_info_office_heating" value="no_heating_system">&nbsp;No heating system installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_office_heating" value="central_boiler_radiators">&nbsp;Central boiler with radiators&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_office_heating" value="central_boiler_ducted_air">&nbsp;Central boiler with ducted air<br>
				<input type="checkbox" name="site_info_office_heating" value="electrical_heating_heatpumps">&nbsp;Electrical heating (heatpumps)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_office_heating" value="electrical_heating_other">&nbsp;Electrical heating (other)<br>
				
				<label for="site_info_age_heating_system">What is the age of the site's main office heating system?</label>
				<input type="radio" name="site_info_age_heating_system" value="0_5_years" checked>&nbsp;0 to 5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_age_heating_system" value="6_10_years">&nbsp;6 to 10 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_age_heating_system" value="11_15_years">&nbsp;11 to 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_age_heating_system" value="over_15_years">&nbsp;Over 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_age_heating_system" value="dont_know">&nbsp;Don't know
				
				<label for="site_info_serviced_heating_system">How often is the main office heating system serviced?</label> 
				<input type="radio" name="site_info_serviced_heating_system" value="annually" checked>&nbsp;Annually&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_serviced_heating_system" value="every_2_years">&nbsp;Every 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_serviced_heating_system" value="more_than_2_years">&nbsp;More than 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<label for="site_info_length_uninsulated_pipes">What is the estimated length of uninsulated pipes in the boiler room?</label>
				<input type="text" name="site_info_length_uninsulated_pipes" style="width: 200px;" ></input>&nbsp;&nbsp;m
                
                <label for="site_info_num_uninsulated_valves">What is the estimated number of uninsulated valves in the boiler room?</label>
				<input type="text" name="site_info_num_uninsulated_valves" style="width: 200px;" ></input>&nbsp;&nbsp;
				<hr>
				
				<h5>Hot Water Production</h5>
				<label for="site_info_hot_water_toilets_washing">How is hot water for toilets and washing produced?</label>
				<input type="checkbox" name="site_info_hot_water_toilets_washing" value="gas_boiler">&nbsp;Gas boiler with storage tank&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_hot_water_toilets_washing" value="electrical_heater">&nbsp;Electrical heater with storage tank&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_hot_water_toilets_washing" value="local_heating">&nbsp;Local heating in each toilet/kitchen<br>
				
				<label for="site_info_storage_tank_insulated">If there is a storage tank is it well insulated?</label>
				<input type="radio" name="site_info_storage_tank_insulated" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_storage_tank_insulated" value="no">&nbsp;No
				
				<label for="site_info_hot_water_heating_controlled">If there is a storage tank, how is the hot water heating controlled?</label>
				<input type="radio" name="site_info_hot_water_heating_controlled" value="manual_on" checked>&nbsp;Manual, on all the time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_hot_water_heating_controlled" value="manual_off">&nbsp;Manual, turned off during low demand&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_hot_water_heating_controlled" value="timers">&nbsp;Timers
                <hr>
                
                <h5>Office Cooling</h5>
                <label for="site_info_office_cooling">What type of office cooling is installed?</label>
				<input type="checkbox" name="site_info_office_cooling" value="no_cooling_system">&nbsp;No cooling system is installed&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_office_cooling" value="split_cooling_system">&nbsp;Split cooling system&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_office_cooling" value="central_cooling">&nbsp;Central cooling with ducted air system<br>
                
                <label for="site_info_cooling_age">What is the age of the site's main cooling system?</label>
				<input type="radio" name="site_info_cooling_age" value="0_5_years" checked>&nbsp;0 to 5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_age" value="6_10_years">&nbsp;6 to 10 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_age" value="11_15_years">&nbsp;11 to 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_age" value="over_15_years">&nbsp;Over 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_age" value="dont_know">&nbsp;Don't know
				
				<label for="site_info_cooling_serviced">How often is the main cooling system serviced?</label> 
				<input type="radio" name="site_info_cooling_serviced" value="annually" checked>&nbsp;Annually&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_serviced" value="every_2_years">&nbsp;Every 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_cooling_serviced" value="more_than_2_years">&nbsp;More than 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr>
				
				<h5>Warehouse Heating</h5>
				 <label for="site_info_warehouse_heating">What type of warehouse heating is installed?</label>
				<input type="checkbox" name="site_info_warehouse_heating" value="no_warehouse_heating_system">&nbsp;No warehouse heating system installed&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_warehouse_heating" value="ceiling_mounted_gas_burners">&nbsp;Ceiling mounted gas burners&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="site_info_warehouse_heating" value="ducted_air_distributed_system">&nbsp;Ducted air distributed system<br>

				<label for="site_info_warehouse_heating_age">What is the age of the site's main warehouse heating system?</label>
				<input type="radio" name="site_info_warehouse_heating_age" value="0_5_years" checked>&nbsp;0 to 5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_age" value="6_10_years">&nbsp;6 to 10 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_age" value="11_15_years">&nbsp;11 to 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_age" value="over_15_years">&nbsp;Over 15 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_age" value="dont_know">&nbsp;Don't know
				
				<label for="site_info_warehouse_heating_serviced">How often is the main warehouse heating system serviced?</label> 
				<input type="radio" name="site_info_warehouse_heating_serviced" value="annually" checked>&nbsp;Annually&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_serviced" value="every_2_years">&nbsp;Every 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_warehouse_heating_serviced" value="more_than_2_years">&nbsp;More than 2 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr>
				
				<h5>Office Ventilation</h5>	
				<label for="site_info_central_fan">Are any office areas mechanically ventilated with a central fan?</label>
				<input type="radio" name="site_info_central_fan" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_central_fan" value="no">&nbsp;No
				
				<label for="site_info_fan_controlled">If yes, how if the fan controlled?</label>
				<input type="radio" name="site_info_fan_controlled" value="not_controlled" checked>&nbsp;Not controlled, on all the time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_fan_controlled" value="timer">&nbsp;Timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_fan_controlled" value="variable_speed">&nbsp;Variable speed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr>
				
				<h5>Electrical Infrastructure</h5>
                <label for="site_info_vol_red_opt_eq">Does the site have voltage reduction or optimising equipment installed?</label>
				<input type="radio" name="site_info_vol_red_opt_eq" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_vol_red_opt_eq" value="no">&nbsp;No
				
				<label for="site_info_electricity_meter">Does your site have more than one electricity meter for billing?</label>
				<input type="radio" name="site_info_electricity_meter" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_electricity_meter" value="no">&nbsp;No
				
				<label for="site_info_sub_meters">Does your site have any sub-meters?</label>
				<input type="radio" name="site_info_sub_meters" value="yes" checked>&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="site_info_sub_meters" value="no">&nbsp;No
				<hr>
				
				<%--INCOMPLETE--%>
				<h5>Energy Reduction</h5>
				
                <br><br>
            </div>
          </div>
        </div>
    </div>
	
	
</fieldset>
    
      

 
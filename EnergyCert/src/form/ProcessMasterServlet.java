package form;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.SQLManager;


/**
 * Servlet implementation class ProcessMasterServlet
 */
@WebServlet("/ProcessMasterServlet")
public class ProcessMasterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessMasterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request,response);
	}

	protected void processView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] zone_array = request.getParameter("zone_details").split("//");
		
		HttpSession session = request.getSession();
		
		for(int i = 0; i < zone_array.length; i++) {
			
			String[] this_zone = zone_array[i].split(",");
			
			String building_name = this_zone[0];
			String zone_name = this_zone[1];
			String zone_type = this_zone[2];
			
			String identifier = "-" + building_name + "_" + zone_name;
			
			session.setAttribute("identifier",identifier);
			
			if (!zone_type.isEmpty()){
				
				if (zone_type.equals("wh_mezzanine")){ 
					processMez(request);
					
				} else if (zone_type.equals("wh_ground_to_roof")){
					processGrf(request);
					
				} else if (zone_type.equals("wh_value_add")){
					processWva(request);
					
				} else if (zone_type.equals("offices")){
					processOffice(request);

				} 
			}
		}
	
		processQuestionnaire(request);
		
		String action = request.getParameter("action");
		String redirectURL = "";
		if (action!=null) {
		    redirectURL = "/EnergyCert/visual/calculate";
		} else {
		    redirectURL = "SavedQuestionnaire.jsp";
		}
	    response.sendRedirect(redirectURL);
	}
	
	private void processMez(HttpServletRequest request) {
		String tableName3 = "mezzanine_form"; 
	 	System.out.println("PROCESSED MEZZANINE_FORM");
			
		String values = "";	
		
		HttpSession session = request.getSession();
		String identifier3 = (String) session.getAttribute("identifier");
		String quest_id = (String) session.getAttribute("quest_id");
		String zone_id = quest_id + identifier3;
		session.removeAttribute("identifier");
		
		values = values + "zone_operationalhrs_mon = \'" + request.getParameter("zone_operationalhrs_mon" + identifier3) + "\',";
		values = values + "zone_operationalhrs_tues = \'" + request.getParameter("zone_operationalhrs_tues" + identifier3) + "\',";
		values = values + "zone_operationalhrs_wed = \'" + request.getParameter("zone_operationalhrs_wed" + identifier3) + "\',";
		values = values + "zone_operationalhrs_thurs = \'" + request.getParameter("zone_operationalhrs_thurs" + identifier3) + "\',";
		values = values + "zone_operationalhrs_fri = \'" + request.getParameter("zone_operationalhrs_fri" + identifier3) + "\',";
		values = values + "zone_operationalhrs_sat = \'" + request.getParameter("zone_operationalhrs_sat" + identifier3) + "\',";
		values = values + "zone_operationalhrs_sun = \'" + request.getParameter("zone_operationalhrs_sun" + identifier3) + "\',";
		values = values + "zone_floorarea = \'" + request.getParameter("zone_floorarea" + identifier3) + "\',";
		values = values + "zone_numoffloors = \'" + request.getParameter("zone_numoffloors" + identifier3) + "\',";
		values = values + "zone_zoneprop_narrow = \'" + request.getParameter("zone_zoneprop_narrow" + identifier3) + "\',";
		values = values + "zone_zoneprop_wide = \'" + request.getParameter("zone_zoneprop_wide" + identifier3) + "\',";
		values = values + "zone_zoneprop_open = \'" + request.getParameter("zone_zoneprop_open" + identifier3) + "\',";
		values = values + "zone_lighting = \'" + request.getParameter("zone_lighting" + identifier3) + "\',";
		values = values + "zone_fluorescent_tube = \'" + request.getParameter("zone_fluorescent_tube" + identifier3) + "\',";
		values = values + "zone_t8_ballasttype = \'" + request.getParameter("zone_t8_ballasttype" + identifier3) + "\',";
		values = values + "zone_lightcontroltype = \'" + request.getParameter("zone_lightcontroltype" + identifier3) + "\',";
		values = values + "zone_hasgoodslift = \'" + request.getParameter("zone_hasgoodslift" + identifier3) + "\'";
		
		String where = "zone_id = \'" + zone_id + "\'";
		
		//update record 
		SQLManager.updateRecords(tableName3, values, where); 
	}
	
	private void processGrf(HttpServletRequest request) {
		String tableName1 = "ground_to_roof_form"; 
	 	System.out.println("PROCESSED GROUND_TO_ROOF_FORM");

		String values = "";
		
		HttpSession session = request.getSession();
		String identifier1 = (String) session.getAttribute("identifier");
		String quest_id = (String) session.getAttribute("quest_id");
		String zone_id = quest_id + identifier1;
		session.removeAttribute("identifier");
		
		values = values + "zone_operationalhrs_mon = \'" + request.getParameter("zone_operationalhrs_mon" + identifier1) + "\',";
		values = values + "zone_operationalhrs_tues = \'" + request.getParameter("zone_operationalhrs_tues" + identifier1) + "\',";
		values = values + "zone_operationalhrs_wed = \'" + request.getParameter("zone_operationalhrs_wed" + identifier1) + "\',";
		values = values + "zone_operationalhrs_thurs = \'" + request.getParameter("zone_operationalhrs_thurs" + identifier1) + "\',";
		values = values + "zone_operationalhrs_fri = \'" + request.getParameter("zone_operationalhrs_fri" + identifier1) + "\',";
		values = values + "zone_operationalhrs_sat = \'" + request.getParameter("zone_operationalhrs_sat" + identifier1) + "\',";
		values = values + "zone_operationalhrs_sun = \'" + request.getParameter("zone_operationalhrs_sun" + identifier1) + "\',";
		values = values + "zone_floorarea = \'" + request.getParameter("zone_floorarea" + identifier1) + "\',";
		values = values + "zone_zoneprop_narrow = \'" + request.getParameter("zone_zoneprop_narrow" + identifier1) + "\',";
		values = values + "zone_zoneprop_wide = \'" + request.getParameter("zone_zoneprop_wide" + identifier1) + "\',";
		values = values + "zone_zoneprop_open = \'" + request.getParameter("zone_zoneprop_open" + identifier1) + "\',";
		values = values + "zone_height = \'" + request.getParameter("zone_height" + identifier1) + "\',";
		values = values + "	zone_sorting_conveyor = \'" + request.getParameter("zone_sorting_conveyor" + identifier1) + "\',";
		values = values + "zone_ismotordrivenconveyor = \'" + request.getParameter("zone_ismotordrivenconveyor" + identifier1) + "\',";
		values = values + "zone_conveyor_hours = \'" + request.getParameter("zone_conveyor_hours" + identifier1) + "\',";
		values = values + "zone_conveyor_isturnedoff = \'" + request.getParameter("zone_conveyor_isturnedoff" + identifier1) + "\',";
		values = values + "zone_hasskylights = \'" + request.getParameter("zone_hasskylights" + identifier1) + "\',";
		values = values + "zone_isskylightsufficient = \'" + request.getParameter("zone_isskylightsufficient" + identifier1) + "\',";
		values = values + "zone_isskylightcleaned = \'" + request.getParameter("zone_isskylightcleaned" + identifier1) + "\',";	
		values = values + "zone_lighting = \'" + request.getParameter("zone_lighting" + identifier1) + "\',";
		values = values + "zone_fluorescent_tube = \'" + request.getParameter("zone_fluorescent_tube" + identifier1) + "\',";
		values = values + "zone_t8_ballasttype = \'" + request.getParameter("zone_t8_ballasttype" + identifier1) + "\',";	
		values = values + "zone_powerrating = \'" + request.getParameter("zone_powerrating" + identifier1) + "\',";
		values = values + "zone_numoflightings = \'" + request.getParameter("zone_numoflightings" + identifier1) + "\',";
		values = values + "zone_lightcontroltype = \'" + request.getParameter("zone_lightcontroltype" + identifier1) + "\',";
		values = values + "zone_ismanuallyturnedoff = \'" + request.getParameter("zone_ismanuallyturnedoff" + identifier1) + "\',";
		values = values + "zone_hasradiantheaters = \'" + request.getParameter("zone_hasradiantheaters" + identifier1) + "\'";
		
		String where = "zone_id = \'" + zone_id + "\'";
		
		//update record 
		SQLManager.updateRecords(tableName1, values, where); 
	}

	private void processWva(HttpServletRequest request) {
		String tableName2 = "warehouse_value_add_form"; 
		System.out.println("PROCESSED WAREHOUSE_VALUE_ADD_FORM");
				
		String values = "";
		
		HttpSession session = request.getSession();
		String identifier2 = (String) session.getAttribute("identifier");
		String quest_id = (String) session.getAttribute("quest_id");
		String zone_id = quest_id + identifier2;
		session.removeAttribute("identifier");

		values = values + "zone_operationalhrs_mon = \'" + request.getParameter("zone_operationalhrs_mon" + identifier2) + "\',";
		values = values + "zone_operationalhrs_tues = \'" + request.getParameter("zone_operationalhrs_tues" + identifier2) + "\',";
		values = values + "zone_operationalhrs_wed = \'" + request.getParameter("zone_operationalhrs_wed" + identifier2) + "\',";
		values = values + "zone_operationalhrs_thurs = \'" + request.getParameter("zone_operationalhrs_thurs" + identifier2) + "\',";
		values = values + "zone_operationalhrs_fri = \'" + request.getParameter("zone_operationalhrs_fri" + identifier2) + "\',";
		values = values + "zone_operationalhrs_sat = \'" + request.getParameter("zone_operationalhrs_sat" + identifier2) + "\',";
		values = values + "zone_operationalhrs_sun = \'" + request.getParameter("zone_operationalhrs_sun" + identifier2) + "\',";
		values = values + "zone_floorarea = \'" + request.getParameter("zone_floorarea" + identifier2) + "\',";
		values = values + "zone_numoffloors = \'" + request.getParameter("zone_numoffloors" + identifier2) + "\',";
		values = values + "zone_numofmanualws = \'" + request.getParameter("zone_numofmanualws" + identifier2) + "\',";
		values = values + "zone_manualpower = \'" + request.getParameter("zone_manualpower" + identifier2) + "\',";
		values = values + "zone_numoflightws = \'" + request.getParameter("zone_numoflightws" + identifier2) + "\',";
		values = values + "zone_lightpower = \'" + request.getParameter("zone_lightpower" + identifier2) + "\',";
		values = values + "zone_numofheavyws = \'" + request.getParameter("zone_numofheavyws" + identifier2) + "\',";
		values = values + "zone_heavypower = \'" + request.getParameter("zone_heavypower" + identifier2) + "\',";
		values = values + "zone_lighting = \'" + request.getParameter("zone_lighting" + identifier2) + "\',";
		values = values + "zone_fluorescent_tube = \'" + request.getParameter("zone_fluorescent_tube" + identifier2) + "\',";
		values = values + "zone_t8_ballasttype = \'" + request.getParameter("zone_t8_ballasttype" + identifier2) + "\',";
		values = values + "zone_lightcontroltype = \'" + request.getParameter("zone_lightcontroltype" + identifier2) + "\'";
		
		String where = "zone_id = \'" + zone_id + "\'";
		
		//update record 
		SQLManager.updateRecords(tableName2, values, where); 
	}

	private void processOffice(HttpServletRequest request) {
		String tableName4 = "office_form"; 
		System.out.println("PROCESSED OFFICE_FORM");
		
		String values = "";
		
		HttpSession session = request.getSession();
		String identifier4 = (String) session.getAttribute("identifier");
		String quest_id = (String) session.getAttribute("quest_id");
		String zone_id = quest_id + identifier4;
		session.removeAttribute("identifier");
		
		values = values + "zone_operationalhrs_mon = \'" + request.getParameter("zone_operationalhrs_mon" + identifier4) + "\',";
		values = values + "zone_operationalhrs_tues = \'" + request.getParameter("zone_operationalhrs_tues" + identifier4) + "\',";
		values = values + "zone_operationalhrs_wed = \'" + request.getParameter("zone_operationalhrs_wed" + identifier4) + "\',";
		values = values + "zone_operationalhrs_thurs = \'" + request.getParameter("zone_operationalhrs_thurs" + identifier4) + "\',";
		values = values + "zone_operationalhrs_fri = \'" + request.getParameter("zone_operationalhrs_fri" + identifier4) + "\',";
		values = values + "zone_operationalhrs_sat = \'" + request.getParameter("zone_operationalhrs_sat" + identifier4) + "\',";
		values = values + "zone_operationalhrs_sun = \'" + request.getParameter("zone_operationalhrs_sun" + identifier4) + "\',";
		values = values + "zone_floorarea = \'" + request.getParameter("zone_floorarea" + identifier4) + "\',";
		values = values + "zone_numoffloors = \'" + request.getParameter("zone_numoffloors" + identifier4) + "\',";
		values = values + "zone_aveemployees = \'" + request.getParameter("zone_aveemployees" + identifier4) + "\',";
		values = values + "zone_numoflaptops = \'" + request.getParameter("zone_numoflaptops" + identifier4) + "\',";
		values = values + "zone_numofflatscreen = \'" + request.getParameter("zone_numofflatscreen" + identifier4) + "\',";
		values = values + "zone_numofCRTmonitor = \'" + request.getParameter("zone_numofCRTmonitor" + identifier4) + "\',";
		values = values + "zone_isalwaysshutdown = \'" + request.getParameter("zone_isalwaysshutdown" + identifier4) + "\',";
		values = values + "zone_ispowersavingmode = \'" + request.getParameter("zone_ispowersavingmode" + identifier4) + "\',";
		values = values + "zone_lighting = \'" + request.getParameter("zone_lighting" + identifier4) + "\',";
		values = values + "zone_fluorescent_tube = \'" + request.getParameter("zone_fluorescent_tube" + identifier4) + "\',";
		values = values + "zone_t8_ballasttype = \'" + request.getParameter("zone_t8_ballasttype" + identifier4) + "\',";
		values = values + "zone_lightcontroltype = \'" + request.getParameter("zone_lightcontroltype" + identifier4) + "\',";
		values = values + "zone_externalglazingtype = \'" + request.getParameter("zone_externalglazingtype" + identifier4) + "\'";
		
		String where = "zone_id = \'" + zone_id + "\'";
		
		//update record 
		SQLManager.updateRecords(tableName4, values, where); 
	}

	private void processQuestionnaire(HttpServletRequest request) {
		//DB details
		String tableName = "questionnaire";
		String values = "";
	
		//values = values + "zone_operationalhrs_mon = \'" + request.getParameter("zone_operationalhrs_mon" + identifier4) + "\',";
	
		//retrieves data from all form parameters (Site Info)
		//String siteInfoExists = request.getParameter("site_info");
		//if (siteInfoExists != null) {
			//System.out.println("hi-site info");
			values = values + "site_info_reference = \'" + request.getParameter("site_info_reference") + "\',";
			values = values + "site_info_business_unit = \'" + request.getParameter("site_info_business_unit") + "\',";
			values = values + "site_info_leasehold_freehold = \'" + request.getParameter("site_info_leasehold_freehold") + "\',";
			values = values + "site_info_lease_expire = \'" + request.getParameter("site_info_lease_expire") + "\',";
			values = values + "site_info_contract_expire = \'" + request.getParameter("site_info_contract_expire") + "\',";
			values = values + "site_info_contact_name = \'" + request.getParameter("site_info_contact_name") + "\',";
			values = values + "site_info_contact_job_title = \'" + request.getParameter("site_info_contact_job_title") + "\',";
			values = values + "site_info_contact_phone = \'" + request.getParameter("site_info_contact_phone") + "\',";
			values = values + "site_info_contact_email = \'" + request.getParameter("site_info_contact_email") + "\',";
			values = values + "site_info_activities_services = \'" + request.getParameter("site_info_activities_services") + "\',";
			values = values + "site_info_sustainability_champion = \'" + request.getParameter("site_info_sustainability_champion") + "\',";
			values = values + "site_info_reduction_targets = \'" + request.getParameter("site_info_reduction_targets") + "\',";
			values = values + "site_info_targets_level = \'" + request.getParameter("site_info_targets_level") + "\',";
			values = values + "site_info_carbon_reduction_targets = \'" + request.getParameter("site_info_carbon_reduction_targets") + "\',";
			values = values + "site_info_employee_awareness_program = \'" + request.getParameter("site_info_employee_awareness_program") + "\',";
			values = values + "site_info_access_to_energy_data = \'" + request.getParameter("site_info_access_to_energy_data") + "\',";
			values = values + "site_info_truck_loading_bays = \'" + request.getParameter("site_info_truck_loading_bays") + "\',";
			values = values + "site_info_bays_dock_seals = \'" + request.getParameter("site_info_bays_dock_seals") + "\',";
		
			//Convert ampere_hours[] values into a string delimited by *
			String[] ampere_hours_array = request.getParameterValues("ampere_hours[]");
			String ampere_hours_string = "";
			if (ampere_hours_array != null) {
				for (String am : ampere_hours_array) {
					ampere_hours_string = ampere_hours_string + am + "*";
				}
			}
			if (ampere_hours_string.length() != 0) {
				ampere_hours_string = ampere_hours_string.substring(0,ampere_hours_string.length()-2);
			}
			values = values + "ampere_hours = \'" + ampere_hours_string + "\',";
		
			//Convert voltage[] values into a string delimited by *
			String[] voltage_array = request.getParameterValues("voltage[]");
			String voltage_string = "";
			if (voltage_array != null) {
				for (String volt : voltage_array) {
					voltage_string = voltage_string + volt + "*";
				}
			}
			if (voltage_string.length() != 0) {
				voltage_string = voltage_string.substring(0,voltage_string.length()-2);
			}
			values = values + "voltage = \'" + voltage_string + "\',";
		
			//Convert total_charges[] values into a string delimited by *
			String[] charges_array = request.getParameterValues("total_charges[]");
			String charges_string = "";
			if (charges_array != null) {
				for (String charge : charges_array) {
					charges_string = charges_string + charge + "*";
				}
			}
			if (charges_string.length() != 0) {
				charges_string = charges_string.substring(0,charges_string.length()-2);
			}
			values = values + "total_charges = \'" + charges_string + "\',";
		
			//Convert total_charge_duration[] values into a string delimited by *
			String[] duration_array = request.getParameterValues("total_charge_duration[]");
			String duration_string = "";
			if (duration_array != null) {
				for (String duration : duration_array) {
					duration_string = duration_string + duration + "*";
				}
			}
			if (duration_string.length() != 0) {
				duration_string = duration_string.substring(0,duration_string.length()-2);
			}
			values = values + "total_charge_duration = \'" + duration_string + "\',";
		
			values = values + "site_info_ext_area_illuminated = \'" + request.getParameter("site_info_ext_area_illuminated") + "\',";
			values = values + "site_info_hours_area_lit = \'" + request.getParameter("site_info_hours_area_lit") + "\',";
			values = values + "site_info_ext_area_controlled = \'" + request.getParameter("site_info_ext_area_controlled") + "\',";
			values = values + "site_info_office_heating = \'" + request.getParameter("site_info_office_heating") + "\',";
			values = values + "site_info_age_heating_system = \'" + request.getParameter("site_info_age_heating_system") + "\',";
			values = values + "site_info_serviced_heating_system = \'" + request.getParameter("site_info_serviced_heating_system") + "\',";
			values = values + "site_info_length_uninsulated_pipes = \'" + request.getParameter("site_info_length_uninsulated_pipes") + "\',";
			values = values + "site_info_num_uninsulated_valves = \'" + request.getParameter("site_info_num_uninsulated_valves") + "\',";
			values = values + "site_info_hot_water_toilets_washing = \'" + request.getParameter("site_info_hot_water_toilets_washing") + "\',";
			values = values + "site_info_storage_tank_insulated = \'" + request.getParameter("site_info_storage_tank_insulated") + "\',";
			values = values + "site_info_hot_water_heating_controlled = \'" + request.getParameter("site_info_hot_water_heating_controlled") + "\',";
			values = values + "site_info_office_cooling = \'" + request.getParameter("site_info_office_cooling") + "\',";
			values = values + "site_info_cooling_age = \'" + request.getParameter("site_info_cooling_age") + "\',";
			values = values + "site_info_cooling_serviced = \'" + request.getParameter("site_info_cooling_serviced") + "\',";
			values = values + "site_info_warehouse_heating = \'" + request.getParameter("site_info_warehouse_heating") + "\',";
			values = values + "site_info_warehouse_heating_age = \'" + request.getParameter("site_info_warehouse_heating_age") + "\',";
			values = values + "site_info_warehouse_heating_serviced = \'" + request.getParameter("site_info_warehouse_heating_serviced") + "\',";
			values = values + "site_info_central_fan = \'" + request.getParameter("site_info_central_fan") + "\',";
			values = values + "site_info_fan_controlled = \'" + request.getParameter("site_info_fan_controlled") + "\',";
			values = values + "site_info_vol_red_opt_eq = \'" + request.getParameter("site_info_vol_red_opt_eq") + "\',";
			values = values + "site_info_electricity_meter = \'" + request.getParameter("site_info_electricity_meter") + "\',";
			values = values + "site_info_sub_meters = \'" + request.getParameter("site_info_sub_meters") + "\',";
		
			//Convert site_info_initiatives_done[] values into a string delimited by *
			String[] done_array = request.getParameterValues("site_info_initiatives_done[]");
			String done_string = "";
			if (done_array != null) {
				for (String done : done_array) {
					done_string = done_string + done + "*";
				}
			}
			if (done_string.length() != 0) {
				done_string = done_string.substring(0,done_string.length()-2);
			}
			values = values + "site_info_initiatives_done = \'" + done_string + "\',";
		
			//Convert site_info_initiatives_done_when[] values into a string delimited by *
			String[] done_when_array = request.getParameterValues("site_info_initiatives_done_when[]");
			String done_when_string = "";
			if (done_when_array != null) {
				for (String done_when : done_when_array) {
					done_when_string = done_when_string + done_when + "*";
				}
			}
			if (done_when_string.length() != 0) {
				done_when_string = done_when_string.substring(0,done_when_string.length()-2);
			}
			values = values + "site_info_initiatives_done_when = \'" + done_when_string + "\',";
		
			//Convert site_info_initiatives_done_zone[] values into a string delimited by *
			String[] done_zone_array = request.getParameterValues("site_info_initiatives_done_zone[]");
			String done_zone_string = "";
			if (done_zone_array != null) {
				for (String done_zone : done_zone_array) {
					done_zone_string = done_zone_string + done_zone + "*";
				}
			}
			if (done_zone_string.length() != 0) {
				done_zone_string = done_zone_string.substring(0,done_zone_string.length()-2);
			}
			values = values + "site_info_initiatives_done_zone = \'" + done_zone_string + "\',";
		
			//Convert site_info_initiatives_done_impact[] values into a string delimited by *
			String[] done_impact_array = request.getParameterValues("site_info_initiatives_done_impact[]");
			String done_impact_string = "";
			if (done_impact_array != null) {
				for (String done_impact : done_impact_array) {
					done_impact_string = done_impact_string + done_impact + "*";
				}
			}
			if (done_impact_string.length() != 0) {
				done_impact_string = done_impact_string.substring(0,done_impact_string.length()-2);
			}
			values = values + "site_info_initiatives_done_impact = \'" + done_impact_string + "\',";
		
			//Convert site_info_initiatives_planned[] values into a string delimited by *
			String[] planned_array = request.getParameterValues("site_info_initiatives_planned[]");
			String planned_string = "";
			if (planned_array != null) {
				for (String planned : planned_array) {
					planned_string = planned_string + planned + "*";
				}
			}
			if (planned_string.length() != 0) {
				planned_string = planned_string.substring(0,planned_string.length()-2);
			}
			values = values + "site_info_initiatives_planned = \'" + planned_string + "\',";
		
			//Convert site_info_initiatives_planned_when[] values into a string delimited by *
			String[] planned_when_array = request.getParameterValues("site_info_initiatives_planned_when[]");
			String planned_when_string = "";
			if (planned_when_array != null) {
				for (String planned_when : planned_when_array) {
					planned_when_string = planned_when_string + planned_when + "*";
				}
			}
			if (planned_when_string.length() != 0) {
				planned_when_string = planned_when_string.substring(0,planned_when_string.length()-2);
			}
			values = values + "site_info_initiatives_planned_when = \'" + planned_when_string + "\',";
		
			//Convert site_info_initiatives_planned_zone[] values into a string delimited by *
			String[] planned_zone_array = request.getParameterValues("site_info_initiatives_planned_zone[]");
			String planned_zone_string = "";
			if (planned_zone_array != null) {
				for (String planned_zone : planned_zone_array) {
					planned_zone_string = planned_zone_string + planned_zone + "*";
				}
			}
			if (planned_zone_string.length() != 0) {
				planned_zone_string = planned_zone_string.substring(0,planned_zone_string.length()-2);
			}
			values = values + "site_info_initiatives_planned_zone = \'" + planned_zone_string + "\',";
		
			//Convert site_info_initiatives_planned_impact[] values into a string delimited by *
			String[] planned_impact_array = request.getParameterValues("site_info_initiatives_planned_impact[]");
			String planned_impact_string = "";
			if (planned_impact_array != null) {
				for (String planned_impact : planned_impact_array) {
					planned_impact_string = planned_impact_string + planned_impact + "*";
				}
			}
			if (planned_impact_string.length() != 0) {
				planned_impact_string = planned_impact_string.substring(0,planned_impact_string.length()-2);
			}
			values = values + "site_info_initiatives_planned_impact = \'" + planned_impact_string + "\'";
		//}
		
		//retrieves data from all form parameters (Site Usage)
		//String siteUsageExists = request.getParameter("site_usage");
		//if (siteUsageExists != null) {
			//System.out.println("hi-site usage");
			values = values + ",usage_electricity_use = \'" + request.getParameter("usage_electricity_use") + "\',";
			values = values + "usage_electricity_use_source = \'" + request.getParameter("usage_electricity_use_source") + "\',";
			values = values + "usage_electricty_cost = \'" + request.getParameter("usage_electricty_cost") + "\',";
			values = values + "usage_renew_electricity_use = \'" + request.getParameter("usage_renew_electricity_use") + "\',";
			values = values + "usage_renew_electricity_use_source = \'" + request.getParameter("usage_renew_electricity_use_source") + "\',";
			values = values + "usage_renew_electricty_cost = \'" + request.getParameter("usage_renew_electricty_cost") + "\',";
			values = values + "usage_nat_gas_use = \'" + request.getParameter("usage_nat_gas_use") + "\',";
			values = values + "usage_nat_gas_use_source = \'" + request.getParameter("usage_nat_gas_use_source") + "\',";
			values = values + "usage_nat_gas_cost = \'" + request.getParameter("usage_nat_gas_cost") + "\',";
			values = values + "usage_fuel_oil_use = \'" + request.getParameter("usage_fuel_oil_use") + "\',";
			values = values + "usage_fuel_oil_use_source = \'" + request.getParameter("usage_fuel_oil_use_source") + "\',";
			values = values + "usage_fuel_oil_cost = \'" + request.getParameter("usage_fuel_oil_cost") + "\',";
			values = values + "usage_diesel_use = \'" + request.getParameter("usage_diesel_use") + "\',";
			values = values + "usage_diesel_use_source = \'" + request.getParameter("usage_diesel_use_source") + "\',";
			values = values + "usage_diesel_cost = \'" + request.getParameter("usage_diesel_cost") + "\',";
			values = values + "usage_lpg_use = \'" + request.getParameter("usage_lpg_use") + "\',";
			values = values + "usage_lpg_use_source = \'" + request.getParameter("usage_lpg_use_source") + "\',";
			values = values + "usage_lpg_cost = \'" + request.getParameter("usage_lpg_cost") + "\',";
			values = values + "usage_district_heating_use = \'" + request.getParameter("usage_district_heating_use") + "\',";
			values = values + "usage_district_heating_use_source = \'" + request.getParameter("usage_district_heating_use_source") + "\',";
			values = values + "usage_district_heating_cost = \'" + request.getParameter("usage_district_heating_cost") + "\',";
			values = values + "usage_district_cooling_use = \'" + request.getParameter("usage_district_cooling_use") + "\',";
			values = values + "usage_district_cooling_use_source = \'" + request.getParameter("usage_district_cooling_use_source") + "\',";
			values = values + "usage_district_cooling_cost = \'" + request.getParameter("usage_district_cooling_cost") + "\'";
		//}
<<<<<<< HEAD
=======
	
>>>>>>> FETCH_HEAD
		//retrieve values from session
		HttpSession session = request.getSession();
		String quest_id = (String) session.getAttribute("quest_id");
	
		//update record 
		String where = "questionnaire_id = \'" + quest_id + "\'";
		SQLManager.updateRecords(tableName, values, where); 
	}

}

package form;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.RetrievedObject;
import db.SQLManager;


/**
 * Servlet implementation class ProcessAddZoneServlet
 */
@WebServlet("/ProcessAddZoneServlet")
public class ProcessAddZoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessAddZoneServlet() {
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
		
		PrintWriter out = response.getWriter();
		
		String buildingName = request.getParameter("building_name");
		String zoneName = request.getParameter("zone_name");
		String zoneActivity = request.getParameter("zone_activity");
		String zoneHeatingCooling = request.getParameter("zone_heating_cooling");
		String zoneMinTemp = request.getParameter("zone_min_temp");
		String zoneMaxTemp = request.getParameter("zone_max_temp");
		String zoneOperation = request.getParameter("zone_operation");
		
		String site_def_building_name = "";
		String site_def_info = "";
		String site_def_activity = "";
		
		String new_zone_id = "";
		
		HttpSession session = request.getSession();
		String quest_id = (String) session.getAttribute("quest_id");
		
		int buildingArrayPosition = 0;
		int zoneNum = 0;
		String zone_id = quest_id + "-" + buildingName + "_" + zoneName;
		
		String where = "questionnaire_id = \'" + quest_id + "\'";
		RetrievedObject ro = SQLManager.retrieveRecords("site_definition", where);
		ResultSet rs = ro.getResultSet();
		try {
			while (rs.next()) {
				site_def_building_name = rs.getString("site_def_building_name");
				site_def_info = rs.getString("site_def_info");
				site_def_activity = rs.getString("site_def_activity");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String[] building_name_array = site_def_building_name.split("\\*");
		ArrayList<String> zoneIDList = new ArrayList<String>();
		String[] site_def_array = site_def_info.split("\\^");
		for (String site : site_def_array) {
			String[] site_array = site.split("\\*");
			for (String s : site_array) {
				String[] s_array = s.split("\\-");
				zoneIDList.add(s_array[1]);
			}
		}
		
		
		String error_message = "";
		
		new_zone_id = buildingName;
		
		if (buildingName.equals("add_new")) {
			String new_building_name = request.getParameter("new_building_name");
			new_zone_id = new_building_name;
			if (new_building_name.equals("")) {
				error_message = "New Building Name is required";
			} else if (!new_building_name.matches("^[a-zA-Z0-9]+$")) {
				error_message = "New Building Name: Alphabetical characters & digits only";
			} else {
				for (String b : building_name_array) {
					if (new_building_name.equals(b)) {
						error_message = "New Building Name must be unique";
						break;
					}
				}
			}
		}
		
		if (error_message.length() == 0) {
			if (zoneName.equals("")) {
				error_message = "Zone Name is required";
			} else if (!zoneName.matches("^[a-zA-Z0-9]+$")) {
				error_message = "Zone Name: Alphabetical characters & digits only";
			} else {
				new_zone_id = new_zone_id + "_" + zoneName;
				for (String b : zoneIDList) {
					if (new_zone_id.equals(b)) {
						error_message = "Zone Names within each Building must be unique";
						break;
					}
				}
			}
		}
		
		if (error_message.length() == 0) {
			if (zoneActivity.equals("")) {
				error_message = "Zone Activity is required";
			} else if (zoneHeatingCooling.equals("")) {
				error_message = "Zone Heating or Cooling is required";
			} else if (zoneMinTemp.equals("")) {
				error_message = "Min Temp is required";
			} else if (!zoneMinTemp.matches("^[-]?[0-9]+$")) {
				error_message = "Min Temp: Integer only";
			} else if (zoneMaxTemp.equals("")) {
				error_message = "Max Temp is required";
			} else if (!zoneMaxTemp.matches("^[-]?[0-9]+$")) {
				error_message = "Max Temp: Integer only";
			} else if (Integer.parseInt(zoneMinTemp) > Integer.parseInt(zoneMaxTemp)) {
				error_message = "Min Temp cannot be larger than Max Temp";
			} else if (zoneOperation.equals("")) {
				error_message = "Months of Zone Operation is required";
			} 
		} 
		
		if (error_message.length() != 0) {
			out.println(error_message);
		} else {
			System.out.println("add");	

			String new_site_def_info = "";
			String new_site_def_activity = "";
			String new_site_def_building_name= "";
			
			boolean addNew = false;
			
			if (buildingName.equals("add_new")) {
				addNew = true;
				String new_building_name = request.getParameter("new_building_name");
				
				zone_id = quest_id + "-" + new_building_name + "_" + zoneName;
				new_site_def_info = site_def_info + "^" + zone_id;
				new_site_def_activity = site_def_activity + "^" + zoneActivity;
				
				new_site_def_building_name = site_def_building_name + "*" + new_building_name;
				buildingArrayPosition = site_def_building_name.split("\\*").length;
				zoneNum = 1;
				buildingName = new_building_name;
			} else {
			
				//find the position of the building in the building name array
				String[] buildingNameArray = site_def_building_name.split("\\*");
				for (int i = 0; i < buildingNameArray.length; i++) {
					String name = buildingNameArray[i];
					if (buildingName.equals(name)) {
						buildingArrayPosition = i;
						break;
					}
				}
				
				//update site_def_info and site_def_activity
				String[] siteDefBuildingArray = site_def_info.split("\\^");
				String[] siteDefZoneArray = siteDefBuildingArray[buildingArrayPosition].split("\\*");
				zoneNum = siteDefZoneArray.length + 1;
				siteDefBuildingArray[buildingArrayPosition] = siteDefBuildingArray[buildingArrayPosition] + "*" + zone_id;
				
				String[] siteDefActivityArray = site_def_activity.split("\\^");
				siteDefActivityArray[buildingArrayPosition] = siteDefActivityArray[buildingArrayPosition] + "*" + zoneActivity;
				
				for (String s : siteDefBuildingArray) {
					new_site_def_info = new_site_def_info + s + "^";
				}
				new_site_def_info = new_site_def_info.substring(0,new_site_def_info.length()-1);
			
				for (String s : siteDefActivityArray) {
					new_site_def_activity = new_site_def_activity + s + "^";
				}
				new_site_def_activity = new_site_def_activity.substring(0,new_site_def_activity.length()-1);
			}
			
			String values = "";
			if (addNew) {
				values = "site_def_info = \'" + new_site_def_info + "\', site_def_activity = \'" + new_site_def_activity + "\', site_def_building_name = \'" + new_site_def_building_name + "\'";
			} else {
				values = "site_def_info = \'" + new_site_def_info + "\', site_def_activity = \'" + new_site_def_activity + "\'";
			}
			String whereUpdate = "questionnaire_id = \'" + quest_id + "\'";
			System.out.println("values: " + values);
			//update record 
			SQLManager.updateRecords("site_definition", values, whereUpdate);
				
			String values_zone = "\'" + quest_id + "\',\'" + zone_id + "\',\'" + (buildingArrayPosition+1) + "\',\'" + zoneNum + "\',\'" + buildingName + "\',\'" + zoneName + "\',\'" + zoneActivity + "\',\'" + zoneHeatingCooling + "\',\'" + zoneMinTemp + "\',\'" + zoneMaxTemp + "\',\'" + zoneOperation + "\'";
			System.out.println("values_zone: " + values_zone);
			String tableName = "";
			if (zoneActivity.equals("wh_mezzanine")) {
				tableName = "mezzanine_form";
				values_zone = values_zone + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
			} else if (zoneActivity.equals("wh_ground_to_roof")) {
				tableName = "ground_to_roof_form";
				values_zone = values_zone + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
			} else if (zoneActivity.equals("wh_value_add")) {
				tableName = "warehouse_value_add_form";
				values_zone = values_zone + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
			} else if (zoneActivity.equals("offices")) {
				tableName = "office_form";
				values_zone = values_zone + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
			}
			SQLManager.insertRecord(tableName,values_zone);
			
			out.println("New zone has been added! The page will be reloaded.");
			System.out.println("Done");
			session.setAttribute("quest_id", quest_id);
			session.setAttribute("fromAddZone","true");
		}
	}

}
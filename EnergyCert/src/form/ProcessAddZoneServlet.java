package form;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

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
		
		System.out.println("here!");
		PrintWriter out = response.getWriter();
		
		String buildingName = request.getParameter("building_name");
		String zoneName = request.getParameter("zone_name");
		String zoneActivity = request.getParameter("zone_activity");
		String zoneHeatingCooling = request.getParameter("zone_heating_cooling");
		String zoneMinTemp = request.getParameter("zone_min_temp");
		String zoneMaxTemp = request.getParameter("zone_max_temp");
		String zoneOperation = request.getParameter("zone_operation");
		
		HttpSession session = request.getSession();
		String quest_id = (String) session.getAttribute("quest_id");
		
		int buildingArrayPosition = 0;
		int zoneNum = 0;
		String zone_id = "";
		
		String where = "questionnaire_id = \'" + quest_id + "\'";
		RetrievedObject ro = SQLManager.retrieveRecords("site_definition", where);
		ResultSet rs = ro.getResultSet();
		try {
			while (rs.next()) {
				String site_def_building_name = rs.getString("site_def_building_name");
				String[] buildingNameArray = site_def_building_name.split("\\*");
				for (int i = 0; i < buildingNameArray.length; i++) {
					String name = buildingNameArray[i];
					if (buildingName.equals(name)) {
						buildingArrayPosition = i;
						break;
					}
				}
				
				String site_def_info = rs.getString("site_def_info");
				String[] siteDefBuildingArray = site_def_info.split("\\^");
				String[] siteDefZoneArray = siteDefBuildingArray[buildingArrayPosition].split("\\*");
				zoneNum = siteDefZoneArray.length + 1;
				zone_id = quest_id + "-" + buildingName + "_" + zoneName;
				siteDefBuildingArray[buildingArrayPosition] = siteDefBuildingArray[buildingArrayPosition] + "*" + zone_id;
				
				String site_def_activity = rs.getString("site_def_activity");
				String[] siteDefActivityArray = site_def_activity.split("\\^");
				siteDefActivityArray[buildingArrayPosition] = siteDefActivityArray[buildingArrayPosition] + "*" + zoneActivity;
				
				String new_site_def_info = "";
				for (String s : siteDefBuildingArray) {
					new_site_def_info = new_site_def_info + s + "^";
				}
				new_site_def_info = new_site_def_info.substring(0,new_site_def_info.length()-1);
				
				String new_site_def_activity = "";
				for (String s : siteDefActivityArray) {
					new_site_def_activity = new_site_def_activity + s + "^";
				}
				new_site_def_activity = new_site_def_activity.substring(0,new_site_def_activity.length()-1);
				
				String values = "site_def_info = \'" + new_site_def_info + "\', site_def_activity = \'" + new_site_def_activity + "\'";
				String whereUpdate = "questionnaire_id = \'" + quest_id + "\'";
				
				//update record 
				SQLManager.updateRecords("site_definition", values, whereUpdate);
			}
			
			String values_zone = "\'" + quest_id + "\',\'" + zone_id + "\',\'" + (buildingArrayPosition+1) + "\',\'" + zoneNum + "\',\'" + buildingName + "\',\'" + zoneName + "\',\'" + zoneActivity + "\',\'" + zoneHeatingCooling + "\',\'" + zoneMinTemp + "\',\'" + zoneMaxTemp + "\',\'" + zoneOperation + "\'";
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/*
		String action = request.getParameter("action");
		String redirectURL = "";
		if (action!=null) {
		    redirectURL = "/EnergyCert/visual/calculate";
		} else {
		    redirectURL = "SavedQuestionnaire.jsp";
		}
	    response.sendRedirect(redirectURL);
		*/
		out.println("New zone has been added!");
		System.out.println("Done");
		session.setAttribute("quest_id", quest_id);
		session.setAttribute("fromAddZone","true");
	}

}
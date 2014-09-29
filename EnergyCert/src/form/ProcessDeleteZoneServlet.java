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

import org.apache.commons.lang3.ArrayUtils;

import db.*;


/**
 * Servlet implementation class ProcessDeleteZoneServlet
 */
@WebServlet("/ProcessDeleteZoneServlet")
public class ProcessDeleteZoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessDeleteZoneServlet() {
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
		
		String selectedVal = request.getParameter("zone_id");
		String[] selectedVal_array = selectedVal.split("//");
		String zone_id = selectedVal_array[0];
		String zone_act = selectedVal_array[1];
		
		HttpSession session = request.getSession();
		String quest_id = (String) session.getAttribute("quest_id");
		
		int buildingArrayPosition = 0;
		int zoneArrayPosition = 0;
		//String zone_id = "";
		
		String where = "questionnaire_id = \'" + quest_id + "\'";
		RetrievedObject ro = SQLManager.retrieveRecords("site_definition", where);
		ResultSet rs = ro.getResultSet();
		try {
			boolean exitArray = false;
			while (rs.next()) {
				String site_def_info = rs.getString("site_def_info");
				String[] b_array = site_def_info.split("\\^");
				for (int i = 0; i < b_array.length; i++) {
					String[] z_array = b_array[i].split("\\*");
					for (int j = 0; j < z_array.length; j++) {
						if (z_array[j].equals(zone_id)) {
							buildingArrayPosition = i;
							zoneArrayPosition = j;
							z_array = ArrayUtils.removeElement(z_array, zone_id);
							exitArray = true;
							break;
						}
					}
					if (z_array.length != 0) {
						String new_b_value = "";
						for (String z : z_array) {
							new_b_value = new_b_value + z + "*";
						}
						new_b_value = new_b_value.substring(0,new_b_value.length()-1);
						b_array[i] = new_b_value;
					} else {
						b_array = ArrayUtils.removeElement(b_array, b_array[i]);
					}
					if (exitArray) {
						break;
					}
				}
				
				String new_site_def_info = "";
				for (String b : b_array) {
					new_site_def_info = new_site_def_info + b + "^"; 
				}
				new_site_def_info = new_site_def_info.substring(0,new_site_def_info.length()-1);
				
				//update site_def_activity and site_def_building_name
				String site_def_activity = rs.getString("site_def_activity");
				String site_def_building_name = rs.getString("site_def_building_name");
				String[] bName_array = site_def_building_name.split("\\*");
				
				b_array = site_def_activity.split("\\^");
				String[] z_array = b_array[buildingArrayPosition].split("\\*");
				z_array = ArrayUtils.remove(z_array, zoneArrayPosition);
				
				if (z_array.length != 0) {
					String new_b_value = "";
					for (String z : z_array) {
						new_b_value = new_b_value + z + "*";
					}
					new_b_value = new_b_value.substring(0,new_b_value.length()-1);
					b_array[buildingArrayPosition] = new_b_value;
				} else {
					b_array = ArrayUtils.remove(b_array, buildingArrayPosition);
					bName_array = ArrayUtils.remove(bName_array, buildingArrayPosition);
				}
				
				String new_site_def_activity = "";
				String new_site_def_building_name = "";
				for (int i = 0; i < b_array.length; i++) {
					new_site_def_activity = new_site_def_activity + b_array[i] + "^";
					new_site_def_building_name = new_site_def_building_name + bName_array[i] + "*"; 
				}
				new_site_def_activity = new_site_def_activity.substring(0,new_site_def_activity.length()-1);
				new_site_def_building_name = new_site_def_building_name.substring(0,new_site_def_building_name.length()-1);
				
				String values = "site_def_info = \'" + new_site_def_info + "\', site_def_activity = \'" + new_site_def_activity + "\', site_def_building_name = \'" + new_site_def_building_name + "\'";
				String whereUpdate = "questionnaire_id = \'" + quest_id + "\'";
				
				//update record 
				SQLManager.updateRecords("site_definition", values, whereUpdate);
			}
			
			String tableName = "";
			if (zone_act.equals("wh_mezzanine")) {
				tableName = "mezzanine_form";
			} else if (zone_act.equals("wh_ground_to_roof")) {
				tableName = "ground_to_roof_form";
			} else if (zone_act.equals("wh_value_add")) {
				tableName = "warehouse_value_add_form";
			} else if (zone_act.equals("offices")) {
				tableName = "office_form";
			}
			
			String where_delete = "zone_id = \'" + zone_id + "\'";
			SQLManager.deleteRecords(tableName,where_delete);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		out.println("Zone has been deleted! The page will be reloaded.");
		System.out.println("Done");
		session.setAttribute("quest_id", quest_id);
		session.setAttribute("fromAddZone","true");
	}

}
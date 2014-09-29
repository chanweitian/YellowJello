package form;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.SQLManager;
import utility.PeriodManager;

/**
 * Servlet implementation class ProcessSiteDefServlet
 */
@WebServlet("/ProcessSiteDefServlet")
public class ProcessSiteDefServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessSiteDefServlet() {
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
	
    public static boolean checkDuplicate(String[] input) {
    	for (int i = 0; i < input.length; i++) {
            for (int j = 0; j < input.length; j++) {
                if (input[i].equals(input[j]) && i != j) {
                    return true;
                }
            }
        }
        return false;
    }
	
	protected void processView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<String> errorList = new ArrayList<String>();
		
		String[] zone_name_array;
		String[] zone_type_array;
		String[] zone_heating_cooling_array;
		String[] zone_min_temp_array;
		String[] zone_max_temp_array;
		String[] zone_operation_array;
		
		String[] building_array = request.getParameterValues("building_name[]");
		boolean bNameDup = checkDuplicate(building_array);
		if (bNameDup) {
			errorList.add("Building Names must be unique");
		}
		
		
		for (int i = 0; i < building_array.length; i++) {
			int num = i+1;
			zone_name_array = request.getParameterValues("b" + num + "_zone_name[]");
			boolean zNameDup = checkDuplicate(zone_name_array);
			if (zNameDup) {
				errorList.add("Zone Names with each Building must be unique");
				break;
			}			
		}
		
		for (int i = 0; i < building_array.length; i++) {
			int num = i+1;
			zone_name_array = request.getParameterValues("b" + num + "_zone_name[]");
			zone_min_temp_array = request.getParameterValues("b" + num + "_zone_min_temp[]");
			zone_max_temp_array = request.getParameterValues("b" + num + "_zone_max_temp[]");	
			
			for (int j = 0; j < zone_min_temp_array.length; j++) {
				int minTemp = Integer.parseInt(zone_min_temp_array[j]);
				int maxTemp = Integer.parseInt(zone_max_temp_array[j]);
				if (minTemp > maxTemp) {
					errorList.add(building_array[i] + "_" + zone_name_array[j] + ": Min Temp must be smaller than Max Temp");
				}	
			}
		}
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		if (errorList.size() != 0) {
			String errors = "";
			for (String s : errorList) {
				errors = errors + s + ";";
			}
		
			out.println(errors);
			
		} else {
			String company = (String) session.getAttribute("company");
			int month = PeriodManager.getMonthInt(company);
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.MONTH,month);
			cal.set(Calendar.DATE,1);
			Calendar today = Calendar.getInstance();
			int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
			if (today.before(cal)) {
				previousYear -= 1;
			}
			
			String quest_id = "";
			try {
				quest_id = (SQLManager.getRowCount("questionnaire") + 1) + "";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//store in QUESTIONNAIRE table
			String values_quest = "";
			values_quest = values_quest + "\'" + quest_id  + "\',";
			values_quest = values_quest + "\'" + request.getParameter("site_id")  + "\',";
			values_quest = values_quest + "\'" + previousYear  + "\',";
			for (int i = 0; i < 76; i++) {
				values_quest = values_quest + "\'\',";
			}
			values_quest = values_quest + "0";
			values_quest = values_quest + ",\'\',\'\'";
			SQLManager.insertRecord("questionnaire",values_quest);
			
			session.setAttribute("quest_id",quest_id);
			
			//site_def_details and site_def_activity to store in SITE_DEFINITION table
			String site_def_details = "";
			String site_def_activity = "";
			String site_def_building_name = "";
			
			building_array = request.getParameterValues("building_name[]");
			
			String zone_details = "";
			ArrayList<String> zone_list = new ArrayList<String>();
			String tableName = "";
			String values = "";
	
			for (int i = 0; i < building_array.length; i++) {
				int num = i+1;
				zone_type_array = request.getParameterValues("b" + num + "_zone_activity[]");
				zone_name_array = request.getParameterValues("b" + num + "_zone_name[]");
				zone_heating_cooling_array = request.getParameterValues("b" + num + "_zone_heating_cooling[]");	
				zone_min_temp_array = request.getParameterValues("b" + num + "_zone_min_temp[]");
				zone_max_temp_array = request.getParameterValues("b" + num + "_zone_max_temp[]");
				zone_operation_array = request.getParameterValues("b" + num + "_zone_operation[]");
				
				site_def_building_name = site_def_building_name + building_array[i] + "*";
				
				for (int j = 0; j < zone_type_array.length; j++) {
					String zone_type = zone_type_array[j];
					//add to zone_list
					String zone_element = building_array[i] + "," + zone_name_array[j] + "," + zone_type_array[j];
					zone_list.add(zone_element);
					
					//add to zone_details string
					zone_details = zone_details + zone_element + "//";
					
					//add to site_info_details string to store in SITE_DEFINITION DB
					site_def_details = site_def_details + quest_id + "-" + building_array[i] + "_" + zone_name_array[j] + "*";
					site_def_activity = site_def_activity + zone_type + "*"; 
					
					//add to DB
					values = "";
					values = values + "\'" + quest_id  + "\',";
					values = values + "\'" + quest_id + "-" + building_array[i] + "_" + zone_name_array[j]  + "\',";
					
					values = values + "\'" + (i+1)  + "\',";
					values = values + "\'" + (j+1)  + "\',";
					
					values = values + "\'" + building_array[i]  + "\',";
					values = values + "\'" + zone_name_array[j]  + "\',";
					values = values + "\'" + zone_type_array[j]  + "\',";
					values = values + "\'" + zone_heating_cooling_array[j]  + "\',";
					values = values + "\'" + zone_min_temp_array[j]  + "\',";
					values = values + "\'" + zone_max_temp_array[j]  + "\',";
					values = values + "\'" + zone_operation_array[j]  + "\'";
					
					
					if (zone_type.equals("wh_mezzanine")) {
						tableName = "mezzanine_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("wh_ground_to_roof")) {
						tableName = "ground_to_roof_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("wh_value_add")) {
						tableName = "warehouse_value_add_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					} else if (zone_type.equals("offices")) {
						tableName = "office_form";
						values = values + ",\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\'";
					}
					
					SQLManager.insertRecord(tableName, values);
				}
				//delimit site_def_details and site_def_activity by ^ (to separate by buildings)
				site_def_details = site_def_details.substring(0,site_def_details.length()-1) + "^";
				site_def_activity = site_def_activity.substring(0,site_def_activity.length()-1) + "^";
			} 
			
			//store site_def_details and site_def_activity in SITE_DEFINITION table
			site_def_details = site_def_details.substring(0,site_def_details.length()-1);
			site_def_activity = site_def_activity.substring(0,site_def_activity.length()-1);
			site_def_building_name = site_def_building_name.substring(0,site_def_building_name.length()-1);
			String site_def_values = "\'" + quest_id + "\',\'" + site_def_details + "\',\'" + site_def_activity + "\',\'" + site_def_building_name + "\'";
			SQLManager.insertRecord("site_definition",site_def_values);
			
			session.setAttribute("zone_details",zone_details);
			
			String zone_string = "";
			for (String z : zone_list) {
				zone_string = zone_string + z + "//";
			}
			zone_string = zone_string.substring(0,zone_string.length()-2);
			
			session.setAttribute("zone_string", zone_string);
		    out.println("yes");
		}
		
	}

}

package visual;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utility.FormulaManager;
import utility.PeriodManager;
import utility.WeatherManager;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class CalculateServlet
 */
@WebServlet("/CalculateServlet")
public class CalculateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static double WINDOW_RATIO;
	private static double L_W_RATIO;
	private static double[] OFFICE_PARAMS = new double[3];
	private static double[] WAREHOUSE_GROUND_TO_ROOF_PARAMS = new double[3];
	private static double[] WAREHOUSE_MEZZANINE_PARAMS = new double[3];
	private static double[] WAREHOUSE_VALUE_ADD_PARAMS = new double[3];

	HashMap<String, double[]> ZONETYPE_PARAMS = new HashMap<String, double[]>();

	private static double ROOF_U;
	private static double WALL_U;
	private static double FLOOR_U;
	private static double WINDOWS_U;
	private static double OFFICE_AIR_CHANGES_PER_HOUR;
	private static double WAREHOUSE_AIR_CHANGES_PER_HOUR;
	private static double OFFICE_RADIATOR_EFFICIENCY;
	private static double WAREHOUSE_BURNER_EFFICIENCY;

	private static double EXT_LIGHT;

	private static double WATER_REQ_OFFICE;
	private static double WATER_REQ_WAREHOUSE_GROUND_TO_ROOF;
	private static double WATER_REQ_WAREHOUSE_MEZZANINE;
	private static double WATER_REQ_WAREHOUSE_VALUE_ADD;
	private static double TEMP_RISE;
	private static double BOILER_SYS_EFFICIENCY;
	private static double SPECIFIC_HEAT_OF_WATER;

	private static double CONVERSION_FACTOR;

	private static double ENERGY_CONSUMPTION_PER_PERSON;

	// Benchmark Parameters
		
	private HashMap<String, int[]> mheMap = new HashMap<String, int[]>();

	private double heatConsumption = 0.0;
	private double coolConsumption = 0.0;
	private double lightingConsumption = 0.0;
	private double extLightingConsumption = 0.0;
	private double hotWaterConsumption = 0.0;
	private double mheConsumption = 0.0;
	private double operationsConsumption = 0.0;

	private double warehouseFloorArea = 0.0;
	private double officeFloorArea = 0.0;
	private double volume = 0.0;
	private String warehouseHeated = "No";
	private String warehouseCooled = "No";
	private String officeHeated = "No";
	private String officeCooled = "No"; 
	private String business_unit = "";
	private String facility_contact = ""; 

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CalculateServlet() {
		super();
		ZONETYPE_PARAMS.put("offices", OFFICE_PARAMS);
		ZONETYPE_PARAMS.put("wh_ground_to_roof",
				WAREHOUSE_GROUND_TO_ROOF_PARAMS);
		ZONETYPE_PARAMS.put("wh_mezzanine", WAREHOUSE_MEZZANINE_PARAMS);
		ZONETYPE_PARAMS.put("wh_value_add", WAREHOUSE_VALUE_ADD_PARAMS);
		// TODO Auto-generated constructor stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	private RetrievedObject ro;
	private ResultSet rs;
	private String site_id = "";
	double actualConsumption = 0.0;
	int consumptionYear = 0;
	double extArea = 0;
	double hoursLitPerWeek = 0;
	private HashMap<String, String> siteInfoMap;
	private String location = "";
	private int zoneCount = 0;

	@Override
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processView(request,response);
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processView(request,response);
	}
		
	protected void processView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher("visualOutput.jsp");
		
		 heatConsumption = 0.0;
		 coolConsumption = 0.0;
		 lightingConsumption = 0.0;
		 extLightingConsumption = 0.0;
		 hotWaterConsumption = 0.0;
		 mheConsumption = 0.0;
		 operationsConsumption = 0.0;

		 warehouseFloorArea = 0.0;
		officeFloorArea = 0.0;
		volume = 0.0;
		warehouseHeated = "No";
		warehouseCooled = "No";
		officeHeated = "No";
		officeCooled = "No"; 
		
		site_id = "";
		actualConsumption = 0.0;
		consumptionYear = 0;
		extArea = 0;
		hoursLitPerWeek = 0;
		location = "";
		zoneCount = 0;
		
		
		siteInfoMap = new HashMap<String, String>();

		HttpSession session = request.getSession();
		
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
		
		String utype = (String) session.getAttribute("usertype");
	
		
		String questionnaire_id = request.getParameter("quest_id");
		
		System.out.println("Quest ID:"+questionnaire_id);
		
		if (questionnaire_id==null) {
			questionnaire_id = (String) session.getAttribute("quest_id");
		}
		
		System.out.println("Session Quest ID:"+questionnaire_id);
		
		String link = request.getParameter("link");
		boolean fromLink = false;
		if (link != null) { 
			
			String where_link = "questionnaire_link = \'" + link + "\'";
			RetrievedObject ro_link = SQLManager.retrieveRecords("questionnaire_link", where_link);
			ResultSet rs_link = ro_link.getResultSet();
			
			boolean empty = true;
			try {
				while( rs_link.next() ) {
				    // ResultSet processing here
				    empty = false;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if (rs_link!=null){
					try{
						rs_link.close();
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
			ro_link.close();

			
			
			if(empty) {
			    //forward to home page
				response.sendRedirect("/EnergyCert");
				return;
			} else {
				fromLink = true;
			}
		}
		

		
		if(fromLink){
			System.out.println("Have Link");
			request.setAttribute("fromLink", "YES");
		} else {
			
			
			
			System.out.println("NO Link");
			request.setAttribute("fromLink", "NO");
			
			if (utype==null || utype.contains("Admin")) {
				response.sendRedirect("/EnergyCert");
				return;
			}

		}
		
		try {
			HashMap<String,Double> formulaHM = FormulaManager.getFormulaHM();
			WINDOW_RATIO =  formulaHM.get("WindowRatio");
			L_W_RATIO  =  formulaHM.get("L-W-ratio");

			OFFICE_PARAMS[0] = formulaHM.get("Office0");
			OFFICE_PARAMS[1] = formulaHM.get("Office1");
			OFFICE_PARAMS[2] = formulaHM.get("Office2");
			WAREHOUSE_GROUND_TO_ROOF_PARAMS[0] = formulaHM.get("WarehouseGroundToRoof0");
			WAREHOUSE_GROUND_TO_ROOF_PARAMS[1] = formulaHM.get("WarehouseGroundToRoof1");
			WAREHOUSE_GROUND_TO_ROOF_PARAMS[2] = formulaHM.get("WarehouseGroundToRoof2");
			WAREHOUSE_MEZZANINE_PARAMS[0] = formulaHM.get("WarehouseMezzanine0");
			WAREHOUSE_MEZZANINE_PARAMS[1] = formulaHM.get("WarehouseMezzanine1");
			WAREHOUSE_MEZZANINE_PARAMS[2] = formulaHM.get("WarehouseMezzanine2");
			WAREHOUSE_VALUE_ADD_PARAMS[0] = formulaHM.get("WarehouseValueAdd0");
			WAREHOUSE_VALUE_ADD_PARAMS[1] = formulaHM.get("WarehouseValueAdd1");
			WAREHOUSE_VALUE_ADD_PARAMS[2] = formulaHM.get("WarehouseValueAdd2");

			HashMap<String, int[]> ZONETYPE_PARAMS = new HashMap<String, int[]>();

			ROOF_U = formulaHM.get("RoofU");
			WALL_U = formulaHM.get("WallU");
			FLOOR_U = formulaHM.get("FloorU");
			WINDOWS_U = formulaHM.get("WindowsU");
			OFFICE_AIR_CHANGES_PER_HOUR = formulaHM.get("OfficeAirChanges");
			WAREHOUSE_AIR_CHANGES_PER_HOUR = formulaHM.get("WarehouseAirChanges");
			OFFICE_RADIATOR_EFFICIENCY = formulaHM.get("OfficeRadiatorEfficiency");
			WAREHOUSE_BURNER_EFFICIENCY = formulaHM.get("WarehouseBurnerEfficiency");

			EXT_LIGHT = formulaHM.get("ExtLight");

			WATER_REQ_OFFICE = formulaHM.get("OfficeWaterReq");
			WATER_REQ_WAREHOUSE_GROUND_TO_ROOF = formulaHM.get("WarehouseGroundToRoofWaterReq");
			WATER_REQ_WAREHOUSE_MEZZANINE = formulaHM.get("WarehouseMezzanineWaterReq");
			WATER_REQ_WAREHOUSE_VALUE_ADD = formulaHM.get("WarehouseValueAddWaterReq");
			TEMP_RISE = formulaHM.get("TempRise");
			BOILER_SYS_EFFICIENCY = formulaHM.get("BoilerSysEfficiency");
			SPECIFIC_HEAT_OF_WATER = formulaHM.get("SpecificHeatOfWater");

			CONVERSION_FACTOR = formulaHM.get("ConversionFactor");

			ENERGY_CONSUMPTION_PER_PERSON = formulaHM.get("EnergyConsumption");

			fetchQuestionnareData(questionnaire_id);
			fetchSiteData();
			String where = "questionnaire_id = \'" + questionnaire_id + "\'";
			RetrievedObject site_def_ro = SQLManager.retrieveRecords("site_definition", where);
			ResultSet site_def_rs = site_def_ro.getResultSet();
			String activity = "";
			while (site_def_rs.next()) {
				activity = site_def_rs.getString("site_def_activity");
			}
			String[] activity_array = activity.split("\\^");
			for (int i = 0; i < activity_array.length; i++) { 
            	String act = activity_array[i];
            	String[] zone_act_array = act.split("\\*");
            	
            	for (int j = 0; j < zone_act_array.length; j++) {
					String zone_act = zone_act_array[j];
					calculateTotalConsumption(zone_act, questionnaire_id);
            	}
            	
			}
			site_def_ro.close();
			//calculateTotalConsumption("offices", questionnaire_id);
			//calculateTotalConsumption("wh_ground_to_roof", questionnaire_id);
			//calculateTotalConsumption("wh_mezzanine", questionnaire_id);
			//calculateTotalConsumption("wh_value_add", questionnaire_id);
			
			// get consumption
			String year1_electrical_use = getElectricalUsage(consumptionYear);
			String year2_electrical_use = getElectricalUsage(consumptionYear-1);
			String year3_electrical_use = getElectricalUsage(consumptionYear-2);
			
			String year1_nat_gas_use = getNatGasUsage(consumptionYear);
			String year2_nat_gas_use = getNatGasUsage(consumptionYear-1);
			String year3_nat_gas_use = getNatGasUsage(consumptionYear-2);

			siteInfoMap.put("year1_electrical_use", year1_electrical_use);
			siteInfoMap.put("year2_electrical_use", year2_electrical_use);
			siteInfoMap.put("year3_electrical_use", year3_electrical_use);

			siteInfoMap.put("year1_nat_gas_use", year1_nat_gas_use);
			siteInfoMap.put("year2_nat_gas_use", year2_nat_gas_use);
			siteInfoMap.put("year3_nat_gas_use", year3_nat_gas_use);
			
			siteInfoMap.put("officeHeated", ""+officeHeated);
			siteInfoMap.put("officeCooled", ""+officeCooled);
			siteInfoMap.put("warehouseHeated", ""+warehouseHeated);
			siteInfoMap.put("warehouseCooled", ""+warehouseCooled);
			siteInfoMap.put("quest_id", ""+questionnaire_id);
			
			System.out.println("BU"+business_unit);
			
			siteInfoMap.put("business_unit", business_unit);
			siteInfoMap.put("facility_contact", facility_contact);
			
			
			
			String country = siteInfoMap.get("site_info_address_country");
			
			String emission_factor_electrical_use = getEmissionFactor(country,"Electricity, non renewable");
			String emission_factor_nat_gas_use = getEmissionFactor(country,"Natural Gas (Methane)");
			
			System.out.println("EF Electrical"+emission_factor_electrical_use);
			System.out.println("NG Electrical"+emission_factor_electrical_use);
			
			siteInfoMap.put("emission_factor_electrical_use",emission_factor_electrical_use);
			siteInfoMap.put("emission_factor_nat_gas_use", emission_factor_nat_gas_use);
			
			request.setAttribute("actualConsumption", actualConsumption + "");
			request.setAttribute("heatConsumption",
					heatConsumption / zoneCount + "");
			request.setAttribute("coolConsumption",
					coolConsumption / zoneCount + "");
			request.setAttribute("lightingConsumption", lightingConsumption
					/ zoneCount + "");
			request.setAttribute("extLightingConsumption",
					extLightingConsumption / zoneCount + "");
			request.setAttribute("hotWaterConsumption", hotWaterConsumption
					/ zoneCount + "");
			request.setAttribute("mheConsumption",
					mheConsumption / zoneCount + "");
			request.setAttribute("operationsConsumption", operationsConsumption
					/ zoneCount + "");

			request.setAttribute("consumptionYear", consumptionYear + "");

			request.setAttribute("warehouseFloorArea", warehouseFloorArea + "");
			request.setAttribute("officeFloorArea", officeFloorArea + "");
			request.setAttribute("volume", volume + "");
			
			request.setAttribute("siteInfoMap", siteInfoMap);

		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					ro.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		rd.forward(request, response);
	}
	
	private String getEmissionFactor(String country, String type) throws SQLException{
		
		ro = SQLManager.retrieveRecords("emission", "country LIKE \'%"
				+ country + "%\' AND type=\'"+type+"\'");
		rs = ro.getResultSet();
		
		if (!rs.next()) {
			if(rs != null) ro.close();
			return "0";
			
		} 

		String factor =  rs.getDouble("gCO2")+"";
		
		ro.close();
		
		return factor;
		
	}
	
	
	private String getElectricalUsage(int consumptionYear) throws SQLException{
		
		ro = SQLManager.retrieveRecords("questionnaire", "site_id=\'"
				+ site_id + "\' AND year=\'"+consumptionYear+"\'");
		rs = ro.getResultSet();
		
		if (!rs.next()) {
			if(rs != null) ro.close();
			return "0";
			
		} 

		String usage =  rs.getString("usage_electricity_use");
		
		ro.close();
		
		return usage;
		
	}
	
	private String getNatGasUsage(int year) throws SQLException{
		
		ro = SQLManager.retrieveRecords("questionnaire", "site_id=\'"
				+ site_id + "\' AND year=\'"+year+"\'");
		rs = ro.getResultSet();
		
		if (!rs.next()) {
			if(rs != null) ro.close();
			return "0";
			
		} 

		String usage =  rs.getString("usage_nat_gas_use");
		
		System.out.println("Year Nat Gas:"+year +":"+usage);
		
		ro.close();
		
		return usage;
		
	}
	
	
	private void fetchQuestionnareData(String questionnaire_id)
			throws SQLException {

		
		ro = SQLManager.retrieveRecords("questionnaire", "Questionnaire_ID=\'"
				+ questionnaire_id + "\'");
		rs = ro.getResultSet();

		if (!rs.next()) {
			System.out.println("Qustionnare_id NOT FOUND");
		} else {

			site_id = rs.getString("site_id");
			actualConsumption = Double.parseDouble(rs
					.getString("usage_electricity_use"));
			consumptionYear = Integer.parseInt(rs.getString("year"));
			System.out.println("TEST consumptionyear is " + rs.getString("year"));
			extArea = Double.parseDouble(rs
					.getString("site_info_ext_area_illuminated"));
			hoursLitPerWeek = Double.parseDouble(rs
					.getString("site_info_hours_area_lit"));
			business_unit = rs
					.getString("site_info_business_unit");
			facility_contact = rs
					.getString("site_info_contact_name");
			
		}
		
		ro.close();

	}

	private void fetchSiteData() throws SQLException {

		ro = SQLManager.retrieveRecords("site", "site_id=\'" + site_id + "\'");
		rs = ro.getResultSet();

		if (!rs.next()) {
			System.out.println("site_id NOT FOUND: " + site_id);
		} else {

			String site_info_name = rs.getString("site_info_name");
			
			String site_info_address_street = rs
					.getString("site_info_address_street");
			String site_info_address_city = rs
					.getString("site_info_address_city");
			String site_info_address_postal = rs
					.getString("site_info_address_postal");
			String site_info_address_country = rs
					.getString("site_info_address_country");
			location = rs.getString("site_info_address_city");

			siteInfoMap.put("site_info_name", site_info_name);
			siteInfoMap.put("site_info_address_street",
					site_info_address_street);
			siteInfoMap.put("site_info_address_city", site_info_address_city);
			siteInfoMap.put("site_info_address_postal",
					site_info_address_postal);
			siteInfoMap.put("site_info_address_country",
					site_info_address_country);

		}

		ro.close();
	}


	private void calculateTotalConsumption(String zoneT, String questionnaire_id)
			throws NumberFormatException, SQLException {

		
		
		String tableName = "";
		
		System.out.println("Calculating Total Consumption for Zone: "+zoneT+":"+questionnaire_id);

		switch (zoneT) {

		case "offices":
			tableName = "office_form";
			break;
		case "wh_ground_to_roof":
			tableName = "ground_to_roof_form";
			break;
		case "wh_mezzanine":
			tableName = "mezzanine_form";
			break;
		case "wh_value_add":
			tableName = "warehouse_value_add_form";
			break;
		}

		
		ro = SQLManager.retrieveRecords(tableName, "questionnaire_id=\'"
				+ questionnaire_id + "\'");
		rs = ro.getResultSet();
		
		if (!rs.next()) {
			System.out.println("questionare_id is NOT FOUND: "
					+ questionnaire_id);
		} else {
			
			zoneCount++;
			
			// get zone type
			double area = Double.parseDouble(rs.getString("zone_floorarea"));
			double maxTemp = Double.parseDouble(rs.getString("zone_max_temp"));
			double minTemp = Double.parseDouble(rs.getString("zone_min_temp"));

			if (zoneT.equals("offices")) {
System.out.println("Hello "+area);
				officeFloorArea += area;
				System.out.println("Hello "+officeFloorArea);	
				
			} else {
				warehouseFloorArea += area;
			}

			double height = 3;
			
			String tmpNumOfFloor = "";
			double numOfFloor = 1;
			
			try{
				tmpNumOfFloor = rs.getString("zone_numoffloors");
				numOfFloor = Double.parseDouble(tmpNumOfFloor);
			} catch (Exception e){
				
			}
			
			
			if (zoneT.equals("office") || zoneT.equals("wh_value_add")) {
				height = height * numOfFloor;
			}
			
			volume += area * height;

			double[] operationHours = getOperationHours(rs);

			double hoursPerDay = operationHours[1]; // get hours per day
			double daysPerWeek = operationHours[0]; // get days per week
			
			String avgEmployee = "0";
			
			try {
				avgEmployee = rs
						.getString("zone_aveemployees");
			} catch(Exception e){
				System.out.println("Not applicable");
			}
			
			int numOfPeople = Integer.parseInt(avgEmployee); //only exists in office
			int year = Calendar.getInstance().get(Calendar.YEAR);
			;

			// GET MHE type 1,2,3

			// DATA for heating & cooling
			double length = Math.sqrt(area / 1.5) * L_W_RATIO;
			double width = area / length;

			double h_roof = length * width * ROOF_U;
			double h_wall = 2 * (length * height + width * height) * WALL_U
					* (1 - WINDOW_RATIO);
			double h_floor = length * width * FLOOR_U;
			double h_window = 2 * (length * height + width * height) * WALL_U
					* WINDOW_RATIO;
			double inflitration = 0.33 * WAREHOUSE_AIR_CHANGES_PER_HOUR
					* length * width * height;
			double total = h_roof + h_wall + h_floor + h_window + inflitration;

			String loc = siteInfoMap.get("site_info_address_city");
			String country = siteInfoMap.get("site_info_address_country");
			
			for (int month = 1; month <= 12; month++) {

				String monthStr = getMonth(month);
				
				// 
				double externalTemp = getWeatherData(loc, monthStr,country); 
			

				// Create a calendar object and set year and month
				Calendar mycal = new GregorianCalendar(year, month, 0);

				// Get the number of days in that month
				int Days_In_Month = mycal
						.getActualMaximum(Calendar.DAY_OF_MONTH);

				if (externalTemp > maxTemp) {
					// cooling required
					double diff = externalTemp - maxTemp;
					double electricConsumption = total * diff * Days_In_Month
							* hoursPerDay / 1000;
					coolConsumption += electricConsumption;
					
					if(zoneT.equals("offices")){
						officeCooled = "Yes";
					} else {
						warehouseCooled = "Yes";
					}

				} else if (externalTemp < minTemp) {
					// heating require
					double diff = minTemp - externalTemp;
					double electricConsumption = total * diff * Days_In_Month
							* hoursPerDay / 1000;
					heatConsumption += electricConsumption;

					
					if(zoneT.equals("offices")){
						officeHeated = "Yes";
					} else {
						warehouseHeated = "Yes";
					}

					
				}

			}
			
			

			lightingConsumption += getLightingConsumption(zoneT, area,
					hoursPerDay, daysPerWeek);

			extLightingConsumption += getExtLightingConsumption(area,
					hoursLitPerWeek);

			hotWaterConsumption += getHotWaterConsumption(zoneT, area,
					hoursPerDay, daysPerWeek);

			mheConsumption += getMHE();

			operationsConsumption += getOperationsConsumption(hoursPerDay,
					daysPerWeek, numOfPeople);

		}
		
		
		ro.close();

	}
	
	
	private double getWeatherData(String loc, String month, String country) throws SQLException {
		

		month = month.substring(0,3);
		
		System.out.println("Calling weather"+loc+month);
		
		double temp = 9999;
		temp = WeatherManager.getTemp(loc, month);
		if (temp == 9999) {
			temp = WeatherManager.getCountryTemp(country, month);
			if (temp == 9999) {
				temp = 0;
			}
		}
		
		System.out.println("Temp for "+month+":"+temp);
		
		return temp;
		
	}
	

	private double[] getOperationHours(ResultSet zone_rs)
			throws NumberFormatException, SQLException {

		double[] res = new double[2];
		double[] arr = new double[7];

		arr[0] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_mon"));
		arr[1] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_tues"));
		arr[2] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_wed"));
		arr[3] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_thurs"));
		arr[4] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_fri"));
		arr[5] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_sat"));
		arr[6] = Double.parseDouble(zone_rs
				.getString("zone_operationalhrs_sun"));

		int count = 0;
		double sum = 0;
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] > 0) {
				count++;
				sum += arr[i];
			}
		}

		res[0] = count;
		res[1] = sum / count;

		return res;
	}

	private double getLightingConsumption(String zoneType, double area,
			double hoursPerDay, double daysPerWeek) {

		double firstParameter = getZoneParameter(zoneType, 1);

		double thirdParameter = getZoneParameter(zoneType, 3);

		double sum = firstParameter * area * hoursPerDay * daysPerWeek * 52
				/ 1000 * thirdParameter;

		return sum;

	}

	private double getZoneParameter(String zoneType, int paramNum) {

		double[] zoneParams = ZONETYPE_PARAMS.get(zoneType);

		return zoneParams[paramNum - 1];
	}

	private double getExtLightingConsumption(double area, double hoursLitPerWeek) {

		return EXT_LIGHT * area * hoursLitPerWeek * 52 / 1000;

	}

	private double getHotWaterConsumption(String zoneType, double area,
			double hoursPerDay, double daysPerWeek) {

		double annualAmountOfWater = getAnnualAmountOfWater(zoneType, area,
				hoursPerDay, daysPerWeek);

		return annualAmountOfWater * TEMP_RISE * BOILER_SYS_EFFICIENCY
				* SPECIFIC_HEAT_OF_WATER;

	}

	private double getAnnualAmountOfWater(String zoneType, double area,
			double hoursPerDay, double daysPerWeek) {

		double waterReq = getWaterReq(zoneType);

		return area * waterReq * hoursPerDay * daysPerWeek;
	}

	private double getWaterReq(String zoneType) {

		switch (zoneType) {
		case "Office":
			return WATER_REQ_OFFICE;
		case "Warehouse Ground to Roof":
			return WATER_REQ_WAREHOUSE_GROUND_TO_ROOF;

		case "Warehouse Mezzanine":
			return WATER_REQ_WAREHOUSE_MEZZANINE;

		case "Warehouse Value Add":
			return WATER_REQ_WAREHOUSE_VALUE_ADD;
		}
		return 0.0;
	}

	private double getMHE() {
		/*
		 * double MHEType1Sum = mheMap.get("Type 1")[0] *
		 * mheMap.get("Type 1")[1] * mheMap.get("Type 1")[2]; double MHEType2Sum
		 * = mheMap.get("Type 2")[0] * mheMap.get("Type 2")[1] *
		 * mheMap.get("Type 2")[2]; double MHEType3Sum = mheMap.get("Type 3")[0]
		 * * mheMap.get("Type 3")[1] * mheMap.get("Type 3")[2];
		 */
		// return (MHEType1Sum + MHEType2Sum + MHEType3Sum) * CONVERSION_FACTOR
		// * 52 / 1000;
		return 0.0;
	}

	private double getOperationsConsumption(double hoursPerDay,
			double daysPerWeek, int numOfPeople) {

		return hoursPerDay * daysPerWeek * numOfPeople * 52
				* ENERGY_CONSUMPTION_PER_PERSON;

	}
	
	
	private String getMonth(int month) {
	    return new DateFormatSymbols().getMonths()[month-1];
	}

}

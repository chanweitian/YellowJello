package visual;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.util.ArrayList;
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
 * Servlet implementation class PaybackServlet
 */
public class PaybackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaybackServlet() {
		super();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	private RetrievedObject ro;
	private ResultSet rs;
	private HashMap<String, ArrayList<String>> paybackMap;
	
	
	private double benchmark;
	private double actualConsumption;
	private double currentRating;
	private double costPerKwh;
	private double operationHoursPerYear;
	
	
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
		
		RequestDispatcher rd = request.getRequestDispatcher("payback.jsp");
	
		paybackMap = new HashMap<String, ArrayList<String>>();

		String[] zoneString = request.getParameter("zone_id").split("//");
		String zone_id = zoneString[0];
		String zoneT = zoneString[1];
		
		String questionare_id = request.getParameter("site_id");
		
		zone_id = questionare_id +"_"+ zone_id; 
		
		actualConsumption = Double.parseDouble(request.getParameter("actual_consumption_electricity"));
		costPerKwh = Double.parseDouble(request.getParameter("electricity_cost")) / actualConsumption;
		
		try {
		
			fetchQuestionaireData(questionare_id);
			fetchZoneData(zoneT, zone_id);
			calculateLightingAssessmentData(request);
		
		} catch (Exception e){
			e.printStackTrace();
		}
		rd.forward(request, response);
		
	}
	
	
	private void calculateLightingAssessmentData(HttpServletRequest request){
		
		
		
		// get current
		
		String name = "Current";
		double numOfFixture = Double.parseDouble(request.getParameter("current_num_fixtures"));
		double lampPerFixture = Double.parseDouble(request.getParameter("current_lamp_fixture"));
		double powerRating = Double.parseDouble(request.getParameter("current_power_rating"));
		double efficacy = Double.parseDouble(request.getParameter("current_efficacy"));
		double ballastFactor = Double.parseDouble(request.getParameter("current_ballast_factor"));
		double opsHoursRed = Double.parseDouble(request.getParameter("current_op_hours"));
		
		double currentAnnualKwh = numOfFixture * lampPerFixture * powerRating * operationHoursPerYear / 1000 * opsHoursRed;
		double currentLightOuput = numOfFixture * lampPerFixture * powerRating * efficacy * ballastFactor;
		
		ArrayList<String> list = new ArrayList<String>();
		list.add("1");
		list.add("1");
		list.add("1");
		
		paybackMap.put(name,list);

		// get others
		
		String[] zoneList = request.getParameterValues("zoneList");
		
		for(String zone: zoneList){
			list = new ArrayList<String>();
			
			numOfFixture = Double.parseDouble(request.getParameter("t5_num_fixtures"));
			lampPerFixture = Double.parseDouble(request.getParameter("t5_lamp_fixture"));
			powerRating = Double.parseDouble(request.getParameter("t5_power_rating"));
			efficacy = Double.parseDouble(request.getParameter("t5_efficacy"));
			ballastFactor = Double.parseDouble(request.getParameter("t5_ballast_factor"));
			opsHoursRed = Double.parseDouble(request.getParameter("t5_op_hours"));
			
			double annualKwh = numOfFixture * lampPerFixture * powerRating * operationHoursPerYear / 1000 * opsHoursRed;
			double annualCost = annualKwh * costPerKwh;
			
			double lightOutput = numOfFixture * lampPerFixture * powerRating * efficacy * ballastFactor;

			double costPerLamp = Double.parseDouble(request.getParameter("t5_cost_lamp"));
			double installationCostPerFixture = Double.parseDouble(request.getParameter("t5_installation_cost"));
			double investmentCost = 0;
			double annualSavings = 0;
			
			double payback = annualSavings / investmentCost;
			
			double newRating = (actualConsumption - (currentAnnualKwh - annualKwh)) / benchmark * 100;
			
			double ratingPercentage = (currentRating - newRating)/ currentRating * 100; 		
					
			double lightOuputPercentage = (lightOutput - currentLightOuput)/ currentLightOuput * 100;
					
			list.add(payback+"");
			list.add(ratingPercentage+"");
			list.add(lightOuputPercentage+"");
			
			paybackMap.put(name,list);
		}
		
		
		
		
		
		
		/*
		
		
		ro = SQLManager.retrieveRecords("lighting", "Zone_ID=\'"
				+ zone_id + "\'");
		rs = ro.getResultSet();
		
		while(rs.next()){
		
			String name = rs.getString("name");
			double numOfFixture = Double.parseDouble(rs.getString("numOfFixture"));
			double lampPerFixture = Double.parseDouble(rs.getString("lampPerFixture"));
			double powerRating = Double.parseDouble(rs.getString("powerRating"));
			double efficacy = Double.parseDouble(rs.getString("efficacy"));
			double ballastFactor = Double.parseDouble(rs.getString("ballastFactor"));
			double opsHoursRed = Double.parseDouble(rs.getString("opsHoursRed"));
			
			double annualKwh = numOfFixture * lampPerFixture * powerRating * operationHoursPerYear / 1000 * opsHoursRed;
			double annualCost = annualKwh * costPerKwh;
			
			double lightOutput = numOfFixture * lampPerFixture * powerRating * efficacy * ballastFactor;
			
			if(rs.getString("costPerLamp") != null){
				ArrayList<String> list = new ArrayList<String>();
				
				double costPerLamp = Double.parseDouble(rs.getString("costPerLamp"));
				double installationCostPerFixture = Double.parseDouble(rs.getString("installationCostPerFixture"));
				double investmentCost = Double.parseDouble(rs.getString("investmentCost"));
				double annualSavings = Double.parseDouble(rs.getString("annualSavings"));
				
				double payback = annualSavings / investmentCost;
				
				int newRating = (actualConsumption - (currentAnnualKwh - annualKwh)) / benchmark * 100
				
				double ratingPercentage = (currentRating - newRating)/ currentRating * 100; 		
						
				double lightOuputPercentage = (lightOutput - currentLightOuput)/ currentLightOuput * 100;
						
				list.add(payback+"");
				list.add(ratingPercentage+"");
				list.add(lightOutput+"");
				
				paybackMap.put(name,list);
				
			} else {
				
				currentAnnualKwh = annualKwh;
				currentLightOuput = lightOutput;
				
				ArrayList<String> list = new ArrayList<String>();
				list.add("1");
				list.add("1");
				list.add("1");
				
				paybackMap.put(name,list);
			}
	
		}
		
		
		ro.close();
		*/
		
		
	}
	
	
	
	private void fetchQuestionaireData(String questionare_id) throws NumberFormatException, SQLException{

		ro = SQLManager.retrieveRecords("questionnaire", "Questionnaire_ID=\'"
				+ questionare_id + "\'");
		rs = ro.getResultSet();
		
		if (!rs.next()) {
			System.out.println("Qustionnare_id NOT FOUND");
		} else {

			currentRating = Integer.parseInt(rs.getString("rating"));
			
		}
		
		ro.close();
		
	}
	
	private void fetchZoneData(String zoneT, String zone_id){
		
		String tableName = "";
		
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
			default:
				System.out.println("here");
				break;
		}
		
		
		
		ro = SQLManager.retrieveRecords(tableName, "zone_id=\'"
				+ zone_id + "\'");
		rs = ro.getResultSet();
		
		benchmark = Double.parseDouble(rs.getString("benchmark"));
		double operationHoursPerWeek = getOperationHours(rs);
		operationHoursPerYear = operationHoursPerWeek * 52;
		
	}
	

	private double getOperationHours(ResultSet zone_rs)
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

		double sum = 0;
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] > 0) {
				sum += arr[i];
			}
		}

		return sum;
	}

	
	

}

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
		processView(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processView(request, response);
	}

	protected void processView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("payback.jsp");

		paybackMap = new HashMap<String, ArrayList<String>>();

		System.out.println("================"+request.getParameter("zone_id"));
		
		String[] zoneString = request.getParameter("zone_id").split("//");
		String zone_id = zoneString[0].trim();
		String zoneT = zoneString[1].trim();

		String questionare_id = request.getParameter("site_id");

		zone_id = questionare_id + "-" + zone_id;

		actualConsumption = Double.parseDouble(request
				.getParameter("actual_consumption_electricity"));
		costPerKwh = Double.parseDouble(request
				.getParameter("electricity_cost"));
		// actualConsumption;

		System.out.println("actualConsumption:" + actualConsumption);
		System.out.println("costPerKwh:" + costPerKwh);

		try {

			fetchQuestionaireData(questionare_id);
			fetchZoneData(zoneT, zone_id);
			calculateLightingAssessmentData(request);

			request.setAttribute("paybackMap", paybackMap);

		} catch (Exception e) {
			e.printStackTrace();
		}
		rd.forward(request, response);

	}

	private void calculateLightingAssessmentData(HttpServletRequest request) {
		// get current

		String name = "Current";
		double numOfFixture = Double.parseDouble(request
				.getParameter("current_num_fixtures"));
		double lampPerFixture = Double.parseDouble(request
				.getParameter("current_lamp_fixture"));
		double powerRating = Double.parseDouble(request
				.getParameter("current_power_rating"));
		double efficacy = Double.parseDouble(request
				.getParameter("current_efficacy"));
		double ballastFactor = Double.parseDouble(request
				.getParameter("current_ballast_factor"));
		double opsHoursRed = Double.parseDouble(request
				.getParameter("current_op_hours")) / 100;

		double currentAnnualKwh = numOfFixture * lampPerFixture * powerRating
				* operationHoursPerYear / 1000 * opsHoursRed;
		double currentAnnualCost = currentAnnualKwh * costPerKwh;
		double currentLightOuput = numOfFixture * lampPerFixture * powerRating
				* efficacy * ballastFactor;

		System.out.println("currentAnnualKwh:" + currentAnnualKwh);
		System.out.println("currentAnnualCost:" + currentAnnualCost);
		System.out.println("currentLightOuput:" + currentLightOuput);

		ArrayList<String> list = new ArrayList<String>();
		list.add("0");
		list.add("1");
		list.add("1");

		paybackMap.put(name, list);

		// get others

		String[] zoneList = request.getParameterValues("types[]");

		for (String zone : zoneList) {

			name = zone;

			list = new ArrayList<String>();

			numOfFixture = Double.parseDouble(request.getParameter(zone
					+ "_num_fixtures"));
			lampPerFixture = Double.parseDouble(request.getParameter(zone
					+ "_lamp_fixture"));
			powerRating = Double.parseDouble(request.getParameter(zone
					+ "_power_rating"));
			efficacy = Double.parseDouble(request.getParameter(zone
					+ "_efficacy"));
			ballastFactor = Double.parseDouble(request.getParameter(zone
					+ "_ballast_factor"));
			opsHoursRed = Double.parseDouble(request.getParameter(zone
					+ "_op_hours")) / 100;

			System.out
					.println("operationHoursPerYear:" + operationHoursPerYear);

			double annualKwh = numOfFixture * lampPerFixture * powerRating
					* operationHoursPerYear / 1000 * opsHoursRed;
			double annualCost = annualKwh * costPerKwh;

			double lightOutput = numOfFixture * lampPerFixture * powerRating
					* efficacy * ballastFactor;

			double costPerLamp = Double.parseDouble(request.getParameter(zone
					+ "_cost_lamp"));
			double installationCostPerFixture = Double.parseDouble(request
					.getParameter(zone + "_installation_cost"));
			double investmentCost = numOfFixture * lampPerFixture * costPerLamp
					+ numOfFixture * installationCostPerFixture;
			double annualSavings = currentAnnualCost - annualCost;

			double payback = investmentCost / annualSavings;

			double newRating = (actualConsumption - (currentAnnualKwh - annualKwh))
					/ benchmark * 100;
			
			double ratingPercentage = (currentRating - newRating)
					/ currentRating;

			double lightOuputPercentage = (lightOutput - currentLightOuput)
					/ currentLightOuput;

			list.add(payback + "");
			list.add(ratingPercentage + "");
			list.add(lightOuputPercentage + "");

			System.out.println("==============" + zone);

			System.out.println("numOfFixture:" + numOfFixture);
			System.out.println("lampPerFixture:" + lampPerFixture);
			System.out.println("powerRating:" + powerRating);
			System.out.println("efficacy:" + efficacy);
			System.out.println("ballastFactor:" + ballastFactor);
			System.out.println("opsHoursRed:" + opsHoursRed);

			System.out.println("annualKwh:" + annualKwh);
			System.out.println("annualCost:" + annualCost);
			System.out.println("lightOutput:" + lightOutput);

			System.out.println("costPerLamp:" + costPerLamp);
			System.out.println("installationCostPerFixture:"
					+ installationCostPerFixture);
			System.out.println("investmentCost:" + investmentCost);
			System.out.println("annualSavings:" + annualSavings);

			System.out.println("currentRating:" + currentRating);
			System.out.println("newRating:" + newRating);
			System.out.println("payback:" + payback);
			System.out.println("ratingPercentage:" + ratingPercentage);
			System.out.println("lightOuputPercentage:" + lightOuputPercentage);

			paybackMap.put(name, list);
		}

		/*
		 * 
		 * 
		 * ro = SQLManager.retrieveRecords("lighting", "Zone_ID=\'" + zone_id +
		 * "\'"); rs = ro.getResultSet();
		 * 
		 * while(rs.next()){
		 * 
		 * String name = rs.getString("name"); double numOfFixture =
		 * Double.parseDouble(rs.getString("numOfFixture")); double
		 * lampPerFixture = Double.parseDouble(rs.getString("lampPerFixture"));
		 * double powerRating = Double.parseDouble(rs.getString("powerRating"));
		 * double efficacy = Double.parseDouble(rs.getString("efficacy"));
		 * double ballastFactor =
		 * Double.parseDouble(rs.getString("ballastFactor")); double opsHoursRed
		 * = Double.parseDouble(rs.getString("opsHoursRed"));
		 * 
		 * double annualKwh = numOfFixture * lampPerFixture * powerRating *
		 * operationHoursPerYear / 1000 * opsHoursRed; double annualCost =
		 * annualKwh * costPerKwh;
		 * 
		 * double lightOutput = numOfFixture * lampPerFixture * powerRating *
		 * efficacy * ballastFactor;
		 * 
		 * if(rs.getString("costPerLamp") != null){ ArrayList<String> list = new
		 * ArrayList<String>();
		 * 
		 * double costPerLamp = Double.parseDouble(rs.getString("costPerLamp"));
		 * double installationCostPerFixture =
		 * Double.parseDouble(rs.getString("installationCostPerFixture"));
		 * double investmentCost =
		 * Double.parseDouble(rs.getString("investmentCost")); double
		 * annualSavings = Double.parseDouble(rs.getString("annualSavings"));
		 * 
		 * double payback = annualSavings / investmentCost;
		 * 
		 * int newRating = (actualConsumption - (currentAnnualKwh - annualKwh))
		 * / benchmark * 100
		 * 
		 * double ratingPercentage = (currentRating - newRating)/ currentRating
		 * * 100;
		 * 
		 * double lightOuputPercentage = (lightOutput - currentLightOuput)/
		 * currentLightOuput * 100;
		 * 
		 * list.add(payback+""); list.add(ratingPercentage+"");
		 * list.add(lightOutput+"");
		 * 
		 * paybackMap.put(name,list);
		 * 
		 * } else {
		 * 
		 * currentAnnualKwh = annualKwh; currentLightOuput = lightOutput;
		 * 
		 * ArrayList<String> list = new ArrayList<String>(); list.add("1");
		 * list.add("1"); list.add("1");
		 * 
		 * paybackMap.put(name,list); }
		 * 
		 * }
		 * 
		 * 
		 * ro.close();
		 */

	}

	private void fetchQuestionaireData(String questionare_id)
			throws NumberFormatException, SQLException {

		ro = SQLManager.retrieveRecords("questionnaire", "Questionnaire_ID=\'"
				+ questionare_id + "\'");
		rs = ro.getResultSet();

		if (!rs.next()) {
			System.out.println("Qustionnare_id NOT FOUND");
		} else {

			currentRating = rs.getInt("energy_rating");

		}

		ro.close();

	}

	private void fetchZoneData(String zoneT, String zone_id)
			throws NumberFormatException, SQLException {

		String tableName = "";

		System.out.println(zoneT);

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
			System.out.println("Zone Type:" + zoneT);
			break;
		}

		System.out.println("zone id:" + zone_id);

		ro = SQLManager.retrieveRecords(tableName, "zone_id=\'" + zone_id
				+ "\'");
		rs = ro.getResultSet();

		if (rs.next()) {
			benchmark = Double.parseDouble(rs.getString("benchmark"));
			benchmark = 400000;
			System.out.println("benchmark:" + benchmark);
			double operationHoursPerWeek = getOperationHours(rs);
			System.out
					.println("operationHoursPerWeek:" + operationHoursPerWeek);
			operationHoursPerYear = operationHoursPerWeek * 52;
		}

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

package visual;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class GenerateChart
 */
@WebServlet("/GenerateChart")
public class GenerateChart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateChart() {
		super();
		// TODO Auto-generated constructor stub
	}

	private ResultSet rs;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String companyName = (String) session.getAttribute("company");
			String year = (String) request.getParameter("year");
			String filter = (String) request.getParameter("filter");
			String value = (String) request.getParameter("value");
			RetrievedObject ro = SQLManager.retrieveRecords(
					"site s, questionnaire q",
					"s.site_id = q.site_id and s.company=\'" + companyName
							+ "\'");
			ResultSet rs = ro.getResultSet();

			JSONObject json = new JSONObject();
			JSONArray sites = new JSONArray();
			JSONObject site;
			response.setContentType("application/JSON");
			PrintWriter out = response.getWriter();

			while (rs.next()) {
				String country = rs.getString("site_info_address_country");
				String qnYear = rs.getString("year");
				String region = rs.getString("Region");
				String company = rs.getString("Company");
				if (filter.equals("Region")) {
					if (region.equals(value) && qnYear.equals(year)
							&& companyName.equals(company)) {
						String siteName = rs.getString("site_info_name");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs
								.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs
								.getString("emission_electrical_use");
						String gasEmmission = rs
								.getString("emission_nat_gas_use");
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						sites.add(site);
					}
				} else if (filter.equals("Country")) {
					if (country.equals(value) && qnYear.equals(year)
							&& companyName.equals(company)) {
						String siteName = rs.getString("site_info_name");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs
								.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs
								.getString("emission_electrical_use");
						String gasEmmission = rs
								.getString("emission_nat_gas_use");
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						sites.add(site);
					}
				} else {
					if (qnYear.equals(year) && companyName.equals(company)) {
						String siteName = rs.getString("site_info_name");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs
								.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs
								.getString("emission_electrical_use");
						String gasEmmission = rs
								.getString("emission_nat_gas_use");
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						sites.add(site);
					}
				}
			}
			json.put("sites", sites);

			ro.close();

			String output = json.toString();
			System.out.println(output);
			out.println(output);
			out.close();

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

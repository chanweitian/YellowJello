package map;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

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
 * Servlet implementation class GenerateMap
 */
@WebServlet("/GenerateMap")
public class GenerateMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateMap() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String companyName = (String) request.getParameter("company");
			String year = (String) request.getParameter("year");
			String filter = (String) request.getParameter("filter");
			String value = (String) request.getParameter("value");
			
			//System.out.println("Generate Map " + companyName);
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
			//System.out.println(filter);
			while (rs.next()) {
				String country = rs.getString("site_info_address_country");
				String qnYear = rs.getString("year");
				String region = rs.getString("Region");
				String company = rs.getString("Company");
				String rating = rs.getString("energy_rating");
				System.out.println("Generate Map: uffyu " + country + " " + region + " city: " + rs.getString("site_info_address_city") + " " + rs.getString("site_info_address_country"));
				
				if (filter != null && filter.equals("Region")) {
					if (region.equals(value) && qnYear.equals(year)
							&& companyName.equals(company)  && rating != null) {
						String siteName = rs.getString("site_info_name");
						String sitePostal = rs.getString("site_info_address_postal");
						String siteAddress = rs.getString("site_info_address_country");
						String siteRegion = rs.getString("Region");
						String totalSize = rs.getString("Total_Size");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs.getString("emission_electrical_use");
						String gasEmmission = rs.getString("emission_nat_gas_use");
						String state = rs.getString("site_info_address_city");
						
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("postal", sitePostal);
						site.put("address", siteAddress);
						site.put("region", siteRegion);
						site.put("size", totalSize);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						site.put("state", state);
						sites.add(site);
					}
				} else if (filter != null && filter.equals("Country")) {
					if (country.equals(value) && qnYear.equals(year)
							&& companyName.equals(company) && rating != null) {
						String siteName = rs.getString("site_info_name");
						String sitePostal = rs.getString("site_info_address_postal");
						String siteAddress = rs.getString("site_info_address_country");
						String siteRegion = rs.getString("Region");
						String totalSize = rs.getString("Total_Size");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs.getString("emission_electrical_use");
						String gasEmmission = rs.getString("emission_nat_gas_use");
						String state = rs.getString("site_info_address_city");
						
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("postal", sitePostal);
						site.put("address", siteAddress);
						site.put("region", siteRegion);
						site.put("size", totalSize);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						site.put("state", state);
						sites.add(site);
					}
				} else if (filter != null && filter.equals("Rating") && rating != null) {
					String[] ratings =  value.split("-");
					int lowerBound = Integer.parseInt(ratings[0]);
					int upperBound = Integer.parseInt(ratings[1]);
					int ratingInt = Integer.parseInt(rating);
					
					if (ratingInt>=lowerBound && ratingInt<upperBound && qnYear.equals(year)
							&& companyName.equals(company)) {
						String siteName = rs.getString("site_info_name");
						String sitePostal = rs.getString("site_info_address_postal");
						String siteAddress = rs.getString("site_info_address_country");
						String siteRegion = rs.getString("Region");
						String totalSize = rs.getString("Total_Size");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs.getString("emission_electrical_use");
						String gasEmmission = rs.getString("emission_nat_gas_use");
						String state = rs.getString("site_info_address_city");
						
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("postal", sitePostal);
						site.put("address", siteAddress);
						site.put("region", siteRegion);
						site.put("size", totalSize);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						site.put("state", state);
						sites.add(site);
					}
				} else {
					if (qnYear.equals(year) && companyName.equals(company) && rating != null) {
						String siteName = rs.getString("site_info_name");
						String sitePostal = rs.getString("site_info_address_postal");
						String siteAddress = rs.getString("site_info_address_country");
						String siteRegion = rs.getString("Region");
						String totalSize = rs.getString("Total_Size");
						String energyRating = rs.getString("energy_rating");
						String electricityUse = rs.getString("usage_electricity_use");
						String natGasUse = rs.getString("usage_nat_gas_use");
						String electricityEmmission = rs.getString("emission_electrical_use");
						String gasEmmission = rs.getString("emission_nat_gas_use");
						String state = rs.getString("site_info_address_city");
						
						site = new JSONObject();
						site.put("siteName", siteName);
						site.put("postal", sitePostal);
						site.put("address", siteAddress);
						site.put("region", siteRegion);
						site.put("size", totalSize);
						site.put("energyRating", energyRating);
						site.put("elec", electricityUse);
						site.put("gas", natGasUse);
						site.put("elecEmi", electricityEmmission);
						site.put("gasEmi", gasEmmission);
						site.put("state", state);
						sites.add(site);
					}
				}
			}
			
			json.put("sites", sites);

			ro.close();

			String output = json.toString();
			out.println(output);
			out.close();

		} catch (Exception e) {

			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

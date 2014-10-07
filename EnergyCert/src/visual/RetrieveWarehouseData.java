package visual;

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
 * Servlet implementation class RetrieveWarehouseData
 */
@WebServlet("/RetrieveWarehouseData")
public class RetrieveWarehouseData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetrieveWarehouseData() {
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
			String companyName = (String) session.getAttribute("company");
			String warehouse = (String) request.getParameter("warehouse");
			RetrievedObject ro = SQLManager.retrieveRecords(
					"site s, questionnaire q",
					"s.site_id = q.site_id and s.company=\'" + companyName
							+ "\'");
			ResultSet rs = ro.getResultSet();

			JSONObject json      = new JSONObject();
			JSONArray  sites = new JSONArray();
			JSONObject site;
			response.setContentType("application/JSON");
			PrintWriter out = response.getWriter();

			while (rs.next()) {
				String rsWarehouse = rs.getString("site_info_name");
				if (rsWarehouse.equals(warehouse)) {
						String siteName = rs.getString("site_info_name");
						String year = rs.getString("year");
						String energyRating = rs.getString("energy_rating");
						site = new JSONObject();
					    site.put("siteName", siteName);
					    site.put("year", year);
					    site.put("energyRating", energyRating);
					    //LOGIC to get GRADE
					    site.put("grade", "A");
					    sites.add(site);
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

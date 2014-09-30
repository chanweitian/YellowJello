package visual;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Iterator;

import org.json.simple.JSONObject;

import db.RetrievedObject;
import db.SQLManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PortfolioDataProcessor
 */
@WebServlet("/RetrieveCountryList")
public class RetrieveCountryList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RetrieveCountryList() {
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
			RetrievedObject ro = SQLManager.retrieveRecords(
					"site s, questionnaire q",
					"s.site_id = q.site_id and s.company=\'" + companyName
							+ "\'");
			ResultSet rs = ro.getResultSet();

			HashSet<String> unique = new HashSet<String>();

			while (rs.next()) {
				String country = rs.getString("site_info_address_country");
				String qnYear = rs.getString("year");
				if (qnYear.equals(year)) {
					unique.add(country);
				}
			}
			ro.close();

			JSONObject json = new JSONObject();
			response.setContentType("application/JSON");
			PrintWriter out = response.getWriter();

			Iterator<String> iter = unique.iterator();
			while (iter.hasNext()) {
				String temp = iter.next();
				json.put("country", temp);
			}

			String output = json.toString();
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

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
 * Servlet implementation class RetrieveRegionList
 */
@WebServlet("/RetrieveRegionList")
public class RetrieveRegionList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RetrieveRegionList() {
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
				String region = rs.getString("Region");
				String qnYear = rs.getString("year");
				if (qnYear.equals(year)) {
					unique.add(region);
				}
			}
			ro.close();

			JSONArray json = new JSONArray();
			response.setContentType("application/JSON");
			PrintWriter out = response.getWriter();

			Iterator<String> iter = unique.iterator();
			while (iter.hasNext()) {
				String temp = iter.next();
				System.out.println(temp);
				json.add(temp);

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
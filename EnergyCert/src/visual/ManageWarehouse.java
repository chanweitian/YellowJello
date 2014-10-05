package visual;

import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class ManageWarehouse
 */
@WebServlet("/ManageWarehouse")
public class ManageWarehouse extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	/*
	 * The following needs to be retrieved Company Name User ID
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher rd = request
				.getRequestDispatcher("portfolioOutput.jsp");
		// join table on site id
		HttpSession session = request.getSession();
		String companyName = (String) session.getAttribute("company");

		try {
			RetrievedObject ro = SQLManager.retrieveRecords(
					"site s, questionnaire q",
					"s.site_id = q.site_id and s.company=\'" + companyName
							+ "\'");
			ResultSet rs = ro.getResultSet();

			ArrayList<String> years = new ArrayList<String>();
			HashSet<String> unique = new HashSet();

			while (rs.next()) {
				String year = rs.getString("year");
				unique.add(year);
			}
			ro.close();

			Iterator<String> iter = unique.iterator();
			while (iter.hasNext()) {
				(years).add(iter.next());
			}

			request.setAttribute("years", years);
			request.setAttribute("company", companyName);

		} catch (Exception e) {

			e.printStackTrace();
		}

		/*
		 * We need to transfer the following to jsp list of years available list
		 * of maps with key (year), array of results (sites)
		 */

		rd.forward(request, response);
	}

}

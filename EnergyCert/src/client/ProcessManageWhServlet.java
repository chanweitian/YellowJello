package client;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.SQLManager;

/**
 * Servlet implementation class ProcessManageWhServlet
 */
@WebServlet("/ProcessManageWhServlet")
public class ProcessManageWhServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessManageWhServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request, response);
	}

	protected void processView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String siteid = request.getParameter("siteid");
		String site = request.getParameter("site");
		String country = request.getParameter("country");
		String[] arr = country.split(";");
		country = arr[1];
		String region = request.getParameter("region");
		String street = request.getParameter("street");
		String city = request.getParameter("city");
		String postal = request.getParameter("postal");
		String totalSize = request.getParameter("totalSize");
		String manageWhMsg = null;

		if (city.equals("Others")) {
			city = request.getParameter("otherCity");
		}

		if (site.trim().length() == 0) {
			manageWhMsg = "Please input site";
		} else if (country.trim().length() == 0) {
			manageWhMsg = "Please input country";
		} else if (region.trim().length() == 0) {
			manageWhMsg = "Please input region";
		} else if (street.trim().length() == 0) {
			manageWhMsg = "Please input street";
		} else if (city.trim().length() == 0) {
			manageWhMsg = "Please input city";
		} else if (postal.trim().length() == 0) {
			manageWhMsg = "Please input postal";
		} else if (totalSize.trim().length() == 0) {
			manageWhMsg = "Please input total size";
		} else {
			try {
				int sizeInt = Integer.parseInt(totalSize);
				String toSet = "site_info_name=\'" + site
						+ "\',site_info_address_country=\'" + country
						+ "\',Region=\'" + region
						+ "\',site_info_address_street=\'" + street
						+ "\',site_info_address_city=\'" + city
						+ "\',site_info_address_postal=\'" + postal + "\',\'"
						+ totalSize + "\'";
				SQLManager.updateRecords("site", toSet, "Site_ID=\'" + siteid
						+ "\'");
				manageWhMsg = "Site details have been successfully saved.";
			} catch (NumberFormatException e) {
				manageWhMsg = "Total size has to be an integer";
			}
		}

		HttpSession session = request.getSession();
		session.setAttribute("manageWhMsg", manageWhMsg);
		session.setAttribute("manageWhSite", site);
		session.setAttribute("manageWhCountry", country);
		session.setAttribute("manageWhRegion", region);
		session.setAttribute("manageWhStreet", street);
		session.setAttribute("manageWhSize", totalSize);
		session.setAttribute("manageWhCity", request.getParameter("city"));
		session.setAttribute("otherCity", request.getParameter("otherCity"));
		session.setAttribute("manageWhPostal", postal);
		response.sendRedirect("managewh.jsp?siteid=" + siteid);

	}

}

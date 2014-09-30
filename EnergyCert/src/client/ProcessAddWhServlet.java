package client;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utility.WeatherManager;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class ProcessAddWhServlet
 */
@WebServlet("/ProcessAddWhServlet")
public class ProcessAddWhServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessAddWhServlet() {
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
		String site = request.getParameter("site");
		String country = request.getParameter("country");
		String[] arr = country.split(";");
		country = arr[1];
		String region = request.getParameter("region");
		String street = request.getParameter("street");
		String city = request.getParameter("city");
		String postal = request.getParameter("postal");
		String totalSize = request.getParameter("totalSize");

		String addWhMsg = null;

		if (city.equals("Others")) {
			city = request.getParameter("otherCity");
		}

		HttpSession session = request.getSession();
		String company = (String) session.getAttribute("company");
		String tempCompany = company.replaceAll("\\s+", "");
		if (tempCompany.length() > 5) {
			tempCompany = tempCompany.substring(0, 6);
		}

		boolean success = false;

		if (site.trim().length() == 0) {
			addWhMsg = "Please input site";
		} else if (country.trim().length() == 0) {
			addWhMsg = "Please input country";
		} else if (region.trim().length() == 0) {
			addWhMsg = "Please input region";
		} else if (street.trim().length() == 0) {
			addWhMsg = "Please input street";
		} else if (city.trim().length() == 0) {
			addWhMsg = "Please input city";
		} else if (postal.trim().length() == 0) {
			addWhMsg = "Please input postal";
		} else if (totalSize.trim().length() == 0) {
			addWhMsg = "Please input total size";

		} else {
			try {
				int sizeInt = Integer.parseInt(totalSize);
				boolean isUnique = false;
				String warehouseID = null;
				int temp = 0;
				while (!isUnique) {
					warehouseID = tempCompany + site.replaceAll("\\s+", "");
					if (warehouseID.length() > 28) {
						warehouseID = warehouseID.substring(0, 28);
					}
					warehouseID = warehouseID + temp;
					RetrievedObject ro = SQLManager.retrieveRecords("site",
							"Site_ID=\'" + warehouseID + "\'");
					ResultSet rs = ro.getResultSet();
					boolean unique = true;
					try {
						while (rs.next()) {
							unique = false;
							temp++;
						}
						if (unique) {
							isUnique = true;
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					ro.close();
				}

				String values = "\'" + warehouseID + "\',\'" + company
						+ "\',\'" + site + "\',\'" + country + "\',\'" + region
						+ "\',\'" + street + "\',\'" + city + "\',\'" + postal
						+ "\',\'" + totalSize + "\'";
				SQLManager.insertRecord("site", values);
				addWhMsg = "Site added. SiteID: " + warehouseID;
				success = true;
			} catch (NumberFormatException e) {
				addWhMsg = "Total size has to be an integer";
			}

		}

		session.setAttribute("addWhMsg", addWhMsg);
		if (!success) {
			session.setAttribute("addWhSite", site);
			session.setAttribute("addWhCountry", country);
			session.setAttribute("addWhRegion", region);
			session.setAttribute("addWhStreet", street);
			session.setAttribute("addWhSize", totalSize);
			session.setAttribute("addWhCity", request.getParameter("city"));
			session.setAttribute("otherCity", request.getParameter("otherCity"));
			session.setAttribute("addWhPostal", postal);
			response.sendRedirect("addwh.jsp");
		} else {
			response.sendRedirect("viewwh.jsp");
		}
	}

}

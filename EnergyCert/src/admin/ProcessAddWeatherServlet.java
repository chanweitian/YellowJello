package admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utility.WeatherManager;

/**
 * Servlet implementation class ProcessAddWeatherServlet
 */
@WebServlet("/ProcessAddWeatherServlet")
public class ProcessAddWeatherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessAddWeatherServlet() {
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
		String country = request.getParameter("country");
		String[] arr = country.split(";");
		country = arr[1];
		String city = request.getParameter("city");
		HashMap<String, String> tempHM = new HashMap<String, String>();
		tempHM.put("Jan", request.getParameter("Jan"));
		tempHM.put("Feb", request.getParameter("Feb"));
		tempHM.put("Mar", request.getParameter("Mar"));
		tempHM.put("Apr", request.getParameter("Apr"));
		tempHM.put("May", request.getParameter("May"));
		tempHM.put("Jun", request.getParameter("Jun"));
		tempHM.put("Jul", request.getParameter("Jul"));
		tempHM.put("Aug", request.getParameter("Aug"));
		tempHM.put("Sep", request.getParameter("Sep"));
		tempHM.put("Oct", request.getParameter("Oct"));
		tempHM.put("Nov", request.getParameter("Nov"));
		tempHM.put("Dec", request.getParameter("Dec"));
		String addWeatherMsg = null;

		HashMap<String, Double> hm = new HashMap<String, Double>();

		if (city.equals("Others")) {
			city = request.getParameter("otherCity");
			if (WeatherManager.getTemp(city, "Jan") != 9999) {
				addWeatherMsg = "Duplicate city";
			}
		}

		if (addWeatherMsg == null) {
			Iterator iter = tempHM.entrySet().iterator();

			while (iter.hasNext()) {
				Map.Entry<String, String> pairs = (Map.Entry<String, String>) iter
						.next();
				String key = pairs.getKey();
				String input = pairs.getValue();

				if (input == null) {
					addWeatherMsg = "Please input a number for " + key;
					break;
				} else {
					try {
						Double temp = Double.parseDouble(input);
						hm.put(key, temp);
					} catch (NumberFormatException e) {
						addWeatherMsg = key + " has to be a number";
						break;
					}
				}
			}
		}

		boolean success = false;
		if (addWeatherMsg == null) {
			WeatherManager.addWeather(country, city, hm);
			addWeatherMsg = "Weather added successfully";
			success = true;
		}

		HttpSession session = request.getSession();
		session.setAttribute("addWeatherMsg", addWeatherMsg);
		if (!success) {
			session.setAttribute("addWeatherCountry", country);
			session.setAttribute("addWeatherCity", request.getParameter("city"));
			session.setAttribute("otherCity", request.getParameter("otherCity"));
			session.setAttribute("awJan", request.getParameter("Jan"));
			session.setAttribute("awFeb", request.getParameter("Feb"));
			session.setAttribute("awMar", request.getParameter("Mar"));
			session.setAttribute("awApr", request.getParameter("Apr"));
			session.setAttribute("awMay", request.getParameter("May"));
			session.setAttribute("awJun", request.getParameter("Jun"));
			session.setAttribute("awJul", request.getParameter("Jul"));
			session.setAttribute("awAug", request.getParameter("Aug"));
			session.setAttribute("awSep", request.getParameter("Sep"));
			session.setAttribute("awOct", request.getParameter("Oct"));
			session.setAttribute("awNov", request.getParameter("Nov"));
			session.setAttribute("awDec", request.getParameter("Dec"));
			response.sendRedirect("addweather.jsp");
		} else {
			response.sendRedirect("editweather.jsp");
		}
	}

}

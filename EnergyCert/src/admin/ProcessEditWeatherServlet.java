package admin;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet implementation class ProcessEditServlet
 */
@WebServlet("/ProcessEditWeatherServlet")
public class ProcessEditWeatherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessEditWeatherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processView(request,response);
	}
	
	protected void processView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<String> weatherMsg = new ArrayList<String>();
		Map<String,String[]> weatherMap = request.getParameterMap();
		Map<String,String[]> weatherHM = new HashMap<String,String[]>();
		Iterator iter = weatherMap.entrySet().iterator();
		HashMap<String,Double> hm = new HashMap<String,Double>();
	    while (iter.hasNext()) {
	        Map.Entry<String,String[]> pairs = (Map.Entry<String,String[]>)iter.next();
	        String key = pairs.getKey();
	        String input = pairs.getValue()[0];
	        
	        weatherHM.put(key, pairs.getValue());
	        try {
	        	Double temp = Double.parseDouble(input);
	        	hm.put(key, temp);
	        } catch (NumberFormatException e) {
	        	String[] arr = key.split(";");
	        	weatherMsg.add(arr[0] + " (" + arr[1] + ") has to be a number");
	        }
	    }

	    if (weatherMsg.size()==0){
	    	WeatherManager.setWeatherHM(hm);
	    	weatherMsg.add("Changes saved successfully!");
	    	
	    } 
	    HttpSession session = request.getSession();
	    session.setAttribute("weatherMsg", weatherMsg);
    	session.setAttribute("weatherFlag", "true");
    	session.setAttribute("weatherHM", weatherHM);
    	response.sendRedirect("editweather.jsp");
	}

}

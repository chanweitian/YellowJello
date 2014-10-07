package visual;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;

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
 * Servlet implementation class HistoricalTrend
 */
@WebServlet("/HistoricalTrend")
public class HistoricalTrend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HistoricalTrend() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = request.getRequestDispatcher("historicalTrend.jsp");
		//join table on site id
		HttpSession session = request.getSession();
		String companyName = (String) session.getAttribute("company");
		
		try {
			RetrievedObject ro = SQLManager.retrieveRecords("site s, questionnaire q", "s.site_id = q.site_id and s.company=\'" + companyName + "\'");
			ResultSet rs = ro.getResultSet();
			
				ArrayList<String> warehouseNames = new ArrayList<String>();
				HashSet<String> warehouses = new HashSet<String>();	
				
				while(rs.next()){	
					String year = rs.getString("year");
					warehouses.add(year);
				}
				ro.close();
				
				Iterator<String> iter = warehouses.iterator();
				while (iter.hasNext()) {
					(warehouseNames).add(iter.next());
				}
					  
				request.setAttribute("warehouses", warehouseNames);				
				request.setAttribute("company", companyName);

				
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
		/* We need to transfer the following to jsp
		 * list of years available
		 * list of maps with key (year), array of results (sites)
		 */
		
		rd.forward(request, response); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

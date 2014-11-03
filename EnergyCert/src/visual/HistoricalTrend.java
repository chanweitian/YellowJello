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
		
		try {
		
			String desc = (String) session.getAttribute("userdesc");
			String comp = (String) session.getAttribute("company");
			String type = (String) session.getAttribute("usertype");
			if (type.equals("Site")) {
				type = "site_info_name";
			} else if (type.equals("Country")) {
				type = "site_info_address_country";
			}
			
			
			String where = "company=\'"+ comp + "\' and " + type + "=\'" + desc + "\'";
			RetrievedObject ro = SQLManager.retrieveRecords("site", where); 
			ResultSet rs = ro.getResultSet();
			
				ArrayList<String> warehouseNames = new ArrayList<String>();
				HashSet<String> tempWarehouses = new HashSet<String>();	
				while(rs.next()){	
					String site = rs.getString("site_info_name");
					tempWarehouses.add(site);
				}
				ro.close();
				
				Iterator<String> iter = tempWarehouses.iterator();
				while (iter.hasNext()) {
					String site_info_name = iter.next();
					RetrievedObject ro1 = SQLManager.retrieveRecords("site s, questionnaire q", "s.site_id = q.site_id and s.site_info_name=\'" + site_info_name + "\'");
					ResultSet rs1 = ro1.getResultSet();
					if (rs1.next()) {
						warehouseNames.add(site_info_name);
					}
					ro1.close();
				}
				 
				request.setAttribute("warehouses", warehouseNames);				
				request.setAttribute("company", comp);

				
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

package visual;

import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	/*
	 * The following needs to be retrieved
	 * Company Name
	 * User ID
	 */
	
	private ResultSet rs;
	private ResultSet rsy;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		RequestDispatcher rd = request.getRequestDispatcher("portfolioOutput.jsp");
		//join table on site id
		HttpSession session = request.getSession();
		String companyName = (String) session.getAttribute("company");
		
		try {
			rs = SQLManager.retrieveRecords("site s, questionnaire q", "s.site_id = q.site_id and company=\'"+companyName+"\'");
						
			
			if(!rs.next()){
				rs.close();

			}else{
				
				//HashMap<String, ArrayList<Site>> annualSiteOverview = new HashMap<String, ArrayList<Site>>();
				ArrayList<String> years = new ArrayList<String>();
				//ArrayList<Site> mapValueSite = new ArrayList<Site>();
				//Now we get the distinct years. 2002, 2003 etc
				
				rsy = SQLManager.retrieveDistinct("year", "questionnaire");
					//while there are distinct years in the list, we use it to create map with year as key
					while(rsy.next()){						
						years.add(rsy.getString("year"));
					}
					/*for(int a = 0; a<years.size(); a++){

						while(rs.next()){
							if(rs.getString("year").equals(years.get(a))){
								String siteName = rs.getString("siteName");
								String efficiencyRating = rs.getString("efficiencyRating");
								String co2_nat_gas_use = rs.getString("co2_nat_gas_use");
								String co2_electricity_use = rs.getString("co2_electricity_use");
								String nat_gas_use = rs.getString("usage_nat_gas_use");
								String electricity_use = rs.getString("usage_electricity_use");
								String region = rs.getString("region");
								String country = rs.getString("country");
								Site temp = new Site(siteName, efficiencyRating, co2_nat_gas_use, co2_electricity_use, nat_gas_use, electricity_use, region, country);
								mapValueSite.add(temp);
								System.out.println(rs.getString("year"));
								System.out.println(siteName + "   " + country + "   " + region);
							}
							annualSiteOverview.put(years.get(a), mapValueSite);
						}
					}		
					*/

					//16 lines worth
					 // multimap method
					 Multimap<String, Object> myMultimap = ArrayListMultimap.create();
					
					  		while(rs.next()){
					  			String siteName = rs.getString("siteName");
								String year = rs.getString("year");
								String efficiencyRating = rs.getString("efficiencyRating");
								String co2_nat_gas_use = rs.getString("co2_nat_gas_use");
								String co2_electricity_use = rs.getString("co2_electricity_use");
								String nat_gas_use = rs.getString("usage_nat_gas_use");
								String electricity_use = rs.getString("usage_electricity_use");
								String region = rs.getString("region");
								String country = rs.getString("country");
								Site temp = new Site(siteName, efficiencyRating, co2_nat_gas_use, co2_electricity_use, nat_gas_use, electricity_use, region, country);
								myMultimap.put(year, temp);
					  		}

						request.setAttribute("annualSiteOverview", myMultimap);
						request.setAttribute("years", years);
					  
					 
					
				
				
				
			}
		} catch (Exception e) {
			
			e.printStackTrace();
			

		}
		
		
		
		/* We need to transfer the following to jsp
		 * list of years available
		 * list of maps with key (year), array of results (sites)
		 */
		
		rd.forward(request, response); 
	}
	
}

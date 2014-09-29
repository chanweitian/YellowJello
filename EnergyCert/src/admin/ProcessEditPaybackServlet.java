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

import utility.PaybackFormulaManager;

/**
 * Servlet implementation class ProcessEditFormulaServlet
 */
@WebServlet("/ProcessEditFormulaServlet")
public class ProcessEditPaybackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessEditPaybackServlet() {
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
		ArrayList<String> paybackMsg = new ArrayList<String>();
		Map<String,String[]> paybackMap = request.getParameterMap();
		Map<String,String[]> paybackHM = new HashMap<String,String[]>();
		Iterator iter = paybackMap.entrySet().iterator();
		HashMap<String,Integer> hm = new HashMap<String,Integer>();
		String paybackSuccess = null;
	    while (iter.hasNext()) {
	        Map.Entry<String,String[]> pairs = (Map.Entry<String,String[]>)iter.next();
	        String field = pairs.getKey();
	        String input = pairs.getValue()[0];
	        paybackHM.put(field, pairs.getValue());
	        try {
	        	Integer inputInt = Integer.parseInt(input);
	        	if (inputInt<0) {
	        		paybackMsg.add(field + " has to be positive");
	        	} else {
	        		hm.put(field, inputInt);
	        	}
	        } catch (NumberFormatException e) {
	        	paybackMsg.add(field + " has to be a number");
	        }
	    }

	    if (paybackMsg.size()==0){
	    	PaybackFormulaManager.setFormulaHM(hm);
	    	paybackSuccess = "Changes saved successfully!";
	    	
	    } 
	    
	    HttpSession session = request.getSession();
	    session.setAttribute("paybackMsg", paybackMsg);
    	session.setAttribute("paybackFlag", "true");
    	session.setAttribute("paybackHM", paybackHM);
    	session.setAttribute("paybackSuccess", paybackSuccess);
    	response.sendRedirect("editpayback.jsp");
	}

}

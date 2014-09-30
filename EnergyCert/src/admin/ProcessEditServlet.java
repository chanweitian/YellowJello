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

import utility.FormulaManager;

import db.SQLManager;

/**
 * Servlet implementation class ProcessEditServlet
 */
@WebServlet("/ProcessEditServlet")
public class ProcessEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessEditServlet() {
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
		ArrayList<String> editMsg = new ArrayList<String>();
		Map<String, String[]> editMap = request.getParameterMap();
		Map<String, String[]> editHM = new HashMap<String, String[]>();
		Iterator iter = editMap.entrySet().iterator();
		HashMap<String, Double> hm = new HashMap<String, Double>();
		String editSuccess = null;
		while (iter.hasNext()) {
			Map.Entry<String, String[]> pairs = (Map.Entry<String, String[]>) iter
					.next();
			String field = pairs.getKey();
			String input = pairs.getValue()[0];
			editHM.put(field, pairs.getValue());
			try {
				Double inputDouble = Double.parseDouble(input);
				if (inputDouble < 0) {
					editMsg.add(field + " has to be positive");
				} else {
					hm.put(field, inputDouble);
				}
			} catch (NumberFormatException e) {
				editMsg.add(field + " has to be a number");
			}
		}

		if (editMsg.size() == 0) {
			FormulaManager.setFormulaHM(hm);
			editSuccess = "Changes saved successfully!";

		}
		HttpSession session = request.getSession();
		session.setAttribute("editMsg", editMsg);
		session.setAttribute("editFlag", "true");
		session.setAttribute("editHM", editHM);
		session.setAttribute("editSuccess", editSuccess);
		response.sendRedirect("editformula.jsp");
	}

}

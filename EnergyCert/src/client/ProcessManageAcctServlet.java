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
 * Servlet implementation class ProcessManageAcctServlet
 */
@WebServlet("/ProcessManageAcctServlet")
public class ProcessManageAcctServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessManageAcctServlet() {
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
		String userid = request.getParameter("userid");
		String type = request.getParameter("type");
		String description = request.getParameter("description");
		String email = request.getParameter("email");
		String manageAcctMsg = null;

		if (description.trim().length() == 0) {
			manageAcctMsg = "Please input description";
		} else if (email.trim().length() == 0) {
			manageAcctMsg = "Please input email";
		} else {

			String toSet = "Type=\'" + type + "\',Description=\'" + description
					+ "\',Email=\'" + email + "\'";
			SQLManager.updateRecords("account", toSet, "Userid=\'" + userid
					+ "\'");
			manageAcctMsg = "Account details have been successfully saved.";
		}

		HttpSession session = request.getSession();
		session.setAttribute("manageAcctMsg", manageAcctMsg);
		session.setAttribute("manageAcctType", type);
		session.setAttribute("manageAcctDescription", description);
		session.setAttribute("manageAcctEmail", email);
		session.setAttribute("manageAcctUserid", userid);
		response.sendRedirect("manageacct.jsp?userid=" + userid);
	}

}

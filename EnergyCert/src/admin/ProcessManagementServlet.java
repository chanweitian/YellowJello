package admin;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.SQLManager;

/**
 * Servlet implementation class ProcessManagementServlet
 */
@WebServlet("/ProcessManagementServlet")
public class ProcessManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessManagementServlet() {
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
		String userid = request.getParameter("userid");
		String company = request.getParameter("inputCompany");
		String email = request.getParameter("inputEmail");
		String managementMsg = null;
		
		if (company.trim().length()==0) {
			managementMsg = "Please input company";
		} else if (email.trim().length()==0) {
			managementMsg = "Please input email";
		} else {
			
			String toSet = "Company=\'" + company + "\',Email=\'" + email + "\'";
			SQLManager.updateRecords("account", toSet, "Userid=\'"+userid+"\'");
			
			managementMsg = "Account details have been successfully saved.";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("managementMsg", managementMsg);
		session.setAttribute("managementCompany", company);
		session.setAttribute("managementEmail", email);
		session.setAttribute("mgmtUserid", userid);
		response.sendRedirect("manageco.jsp?userid="+userid);
	}

}

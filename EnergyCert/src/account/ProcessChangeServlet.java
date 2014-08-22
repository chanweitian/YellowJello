package account;

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
 * Servlet implementation class ProcessChangeServlet
 */
@WebServlet("/ProcessChangeServlet")
public class ProcessChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessChangeServlet() {
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
		String currentPassword = request.getParameter("current_password");
		String newPassword = request.getParameter("new_password");
		String confirmPassword = request.getParameter("confirm_password");
		
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String changeMsg = null;
		
		if (currentPassword.trim().length()==0) {
			changeMsg = "Please input current password";
		} else if (newPassword.trim().length()==0) {
			changeMsg = "Please input new password";
		} else if (confirmPassword.trim().length()==0) {
			changeMsg = "Please input confirm password";
		} else {

			ResultSet rs = SQLManager.retrieveRecords("account", "Userid=\'"+userid+"\'");
			try {
				while (rs.next()) {
					if (!currentPassword.equals(rs.getString("Password"))) {
						changeMsg = "Invalid password";
					} else if (!newPassword.equals(confirmPassword)) {
						changeMsg = "New password does not match with confirm password";
					} else {
						SQLManager.updateRecords("account", "Password=\'"+newPassword+"\'", "Userid=\'"+userid+"\'");
						changeMsg = "Password changed successfully";
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		session.setAttribute("changeMsg", changeMsg);
		response.sendRedirect("changepwd.jsp");
	}

}

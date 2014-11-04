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

import db.RetrievedObject;
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
		String link = request.getParameter("link");
		String userid = null;
		HttpSession session = request.getSession();
		if (link==null) {
			userid = (String) session.getAttribute("userid");
		} else {
			userid = request.getParameter("uid");
		}
		String newPassword = request.getParameter("new_password");
		String confirmPassword = request.getParameter("confirm_password");
		String changeMsg = null;

		if (link==null) {
			if (request.getParameter("current_password").trim().length() == 0) {
				changeMsg = "Please input current password";
			}
		} 
		if (changeMsg==null) {
			if (newPassword.trim().length() == 0) {
				changeMsg = "Please input new password";
			} else if (confirmPassword.trim().length() == 0) {
				changeMsg = "Please input confirm password";
			} else {
	
				RetrievedObject ro = SQLManager.retrieveRecords("account",
						"Userid=\'" + userid + "\'");
				ResultSet rs = ro.getResultSet();
				try {
					while (rs.next()) {
						if (link==null) {
							if (!request.getParameter("current_password").equals(rs.getString("Password"))) {
								changeMsg = "Invalid current password";
							}
						} 
						if (changeMsg==null) {
							if (!newPassword.equals(confirmPassword)) {
								changeMsg = "New password does not match with confirm password";
							} else {
								SQLManager.updateRecords("account", "Password=\'"
										+ newPassword + "\'", "Userid=\'" + userid
										+ "\'");
								changeMsg = "Password changed successfully";
								if (link!=null) {
									SQLManager.deleteRecords("password_link", "Link=\'" + link + "\'");
								}
							}
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ro.close();
			}
		}

		session.setAttribute("changeMsg", changeMsg);
		if (link==null) {
			response.sendRedirect("changepwd.jsp");
		} else {
			response.sendRedirect("changepwd.jsp?link=" + link);
		}
	}

}

package account;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
 * Servlet implementation class ProcessLoginServlet
 */
@WebServlet("/ProcessLoginServlet")
public class ProcessLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessLoginServlet() {
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
		String password = request.getParameter("password");
		String loginError = null;
		String company = null;
		String type = null;
		String description = null;
		
		if (userid.trim().length()==0) {
			loginError = "Please input userid";
		} else if (password.trim().length()==0) {
			loginError = "Please input password";
		} else {
			
			boolean hasUserid = false;
			
			RetrievedObject ro = SQLManager.retrieveRecords("account", "Userid=\'"+userid+"\'");
			ResultSet rs = ro.getResultSet();
			try {
				while (rs.next()) {
					hasUserid = true;
					if (!password.equals(rs.getString("Password"))) {
						loginError = "Invalid userid/password";
					} else {
						company = rs.getString("Company");
						type  = rs.getString("Type");
						description = rs.getString("Description");
					}
				}
				if (!hasUserid) {
					loginError = "Invalid userid/password";
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ro.close();
		}
		
		HttpSession session = request.getSession();
		if (loginError!=null) {
			session.setAttribute("loginError", loginError);
			session.setAttribute("loginUserid", userid);
			session.setAttribute("loginPassword", password);
			response.sendRedirect("/EnergyCert/index.jsp");
		} else {
			session.setAttribute("userid", userid);
			session.setAttribute("company", company);
			session.setAttribute("usertype", type);
			session.setAttribute("userdesc", description);
			response.sendRedirect("/EnergyCert/Home.jsp");
		}
	}
}

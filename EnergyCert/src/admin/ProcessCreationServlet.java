package admin;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class ProcessCreationServlet
 */
@WebServlet("/ProcessCreationServlet")
public class ProcessCreationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessCreationServlet() {
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
		String company = request.getParameter("inputCompany");
		String email = request.getParameter("inputEmail");
		String creationMsg = null;
		
		if (company.trim().length()==0) {
			creationMsg = "Please input company";
		} else if (email.trim().length()==0) {
			creationMsg = "Please input email";
		} else {
			//TO-DO: IMPLEMENT CHECK FOR UNIQUE EMAIL
			RetrievedObject ro = SQLManager.retrieveRecords("account", "email=\'"+email+"\'");
			ResultSet rs = ro.getResultSet();
			boolean uniqueEmail = true;
			try {
				while (rs.next()) {
					uniqueEmail = false;
					break;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ro.close();
			if (!uniqueEmail) {
				creationMsg = "Duplicate email. Please input unique email.";
			} else {
				boolean isUnique = false;
				String userid = null;
				while (!isUnique) {
					userid = "admin" + Long.toHexString(Double.doubleToLongBits(Math.random()));
					userid = userid.substring(0, 13);
					ro = SQLManager.retrieveRecords("account", "userid=\'"+userid+"\'");
					rs = ro.getResultSet();
					boolean unique = true;
					try {
						while (rs.next()) {
							unique = false;
						}
						if (unique) {
							isUnique = true;
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				ro.close();
				String password = "" + Long.toHexString(Double.doubleToLongBits(Math.random()));
				password = password.substring(0,13);
				String values = "\'" + userid + "\',\'" + password + "\',\'" + email + "\',\'Company Admin\',\'" + company + "\',\'" + company + "\'";
				SQLManager.insertRecord("account", values);
				creationMsg = "Account has been created. Userid: " + userid;
				
				final String username = "gtl.fypeia@gmail.com";
				final String pwd = "pa55w0rd#";
		 
				Properties props = new Properties();
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.port", "587");
		 
				Session session = Session.getInstance(props,
				  new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, pwd);
					}
				  });
		 
				try {
		 
					Message message = new MimeMessage(session);
					message.setFrom(new InternetAddress("karchiankoh@gmail.com"));
					message.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(email));
					message.setSubject("Your account has been created");
					message.setText("Dear User,"
						+ "\n\n Your userid is " + userid
						+ "\n Your password is " + password);
		 
					Transport.send(message);
		 
					System.out.println("Done");
		 
				} catch (MessagingException e) {
					throw new RuntimeException(e);
				}
			}
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("creationMsg", creationMsg);
		session.setAttribute("creationCompany", company);
		session.setAttribute("creationEmail", email);
		response.sendRedirect("createco.jsp");
	}

}

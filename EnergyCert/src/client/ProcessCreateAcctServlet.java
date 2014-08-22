package client;

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

import db.SQLManager;

/**
 * Servlet implementation class ProcessCreateAcctServlet
 */
@WebServlet("/ProcessCreateAcctServlet")
public class ProcessCreateAcctServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessCreateAcctServlet() {
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
		String type = request.getParameter("type");
		String description = request.getParameter("description");
		String email = request.getParameter("email");
		String createAcctMsg = null;
		
		HttpSession session2 = request.getSession();
		String company = (String) session2.getAttribute("company");
		String tempCompany = company.replaceAll("\\s+","");
		if (tempCompany.length()>5) {
			tempCompany = tempCompany.substring(0,6);
		}
		
		if (type.trim().length()==0) {
			createAcctMsg = "Please input type";
		} else if (description.trim().length()==0) {
			createAcctMsg = "Please input description";
		} else if (email.trim().length()==0) {
			createAcctMsg = "Please input email";
		} else {
			
			boolean isUnique = false;
			String userid = null;
			while (!isUnique) {
				userid = tempCompany + Long.toHexString(Double.doubleToLongBits(Math.random()));
				userid = userid.substring(0, 13);
				ResultSet rs = SQLManager.retrieveRecords("account", "userid=\'"+userid+"\'");
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
			String password = "" + Long.toHexString(Double.doubleToLongBits(Math.random()));
			password = password.substring(0,13);
			String values = "\'" + userid + "\',\'" + password + "\',\'" + email + "\',\'" + type + "\',\'" + company + "\',\'" + description + "\'";
			SQLManager.insertRecord("account", values);
			createAcctMsg = "Account has been created. Userid: " + userid;
			
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
				createAcctMsg = "Email doesn't exist";
			}
		}
		
		session2.setAttribute("createAcctMsg", createAcctMsg);
		session2.setAttribute("createAcctType", type);
		session2.setAttribute("createAcctDescription", description);
		session2.setAttribute("createAcctEmail", email);
		response.sendRedirect("createacct.jsp");
	}

}

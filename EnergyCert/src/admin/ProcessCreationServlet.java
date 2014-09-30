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
		String userid = request.getParameter("inputUserid");
		String company = request.getParameter("inputCompany");
		String email = request.getParameter("inputEmail");
		String creationMsg = null;
		boolean success = false;

		if (userid.trim().length() == 0) {
			creationMsg = "Please input userid";
		} else if (company.trim().length() == 0) {
			creationMsg = "Please input company";
		} else if (email.trim().length() == 0) {
			creationMsg = "Please input email";
		} else {
			RetrievedObject ro = SQLManager.retrieveRecords("account",
					"email=\'" + email + "\'");
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
				ro = SQLManager.retrieveRecords("account", "userid=\'" + userid
						+ "\'");
				rs = ro.getResultSet();
				boolean unique = true;
				try {
					while (rs.next()) {
						unique = false;
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				ro.close();
				if (!unique) {
					creationMsg = "Userid is already taken. Please input another userid.";
				} else {
					String password = ""
							+ Long.toHexString(Double.doubleToLongBits(Math
									.random()));
					password = password.substring(0, 13);
					String values = "\'" + userid + "\',\'" + password
							+ "\',\'" + email + "\',\'Company Admin\',\'"
							+ company + "\',\'" + company + "\'";
					SQLManager.insertRecord("account", values);
					creationMsg = "Account has been created. Userid: " + userid;
					success = true;

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
									return new PasswordAuthentication(username,
											pwd);
								}
							});

					try {

						Message message = new MimeMessage(session);
						message.setFrom(new InternetAddress(
								"gtl.fypeia@gmail.com"));
						message.setRecipients(Message.RecipientType.TO,
								InternetAddress.parse(email));
						message.setSubject("Login Credentials for EnergyCert");
						message.setText("Dear User,"
								+ "\n\n Your account has been created."
								+ "\n \n The following are your login credentials:"
								+ "\n Userid: "
								+ userid
								+ "\n Password: "
								+ password
								+ "\n \n This is the link for the application: "
								+ "http://apps.greentransformationlab.com/EnergyCert/");

						Transport.send(message);

						System.out.println("Done");

					} catch (MessagingException e) {
						throw new RuntimeException(e);
					}
				}
			}
		}

		HttpSession session = request.getSession();
		session.setAttribute("creationMsg", creationMsg);
		if (!success) {
			session.setAttribute("creationUserid", userid);
			session.setAttribute("creationCompany", company);
			session.setAttribute("creationEmail", email);
			response.sendRedirect("createco.jsp");
		} else {
			response.sendRedirect("viewco.jsp");
		}
	}

}

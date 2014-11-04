package client;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.UUID;

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
		String createAcctMsg = null;
		boolean success = false;

		HttpSession session2 = request.getSession();
		String company = (String) session2.getAttribute("company");
		String tempCompany = company.replaceAll("\\s+", "");
		if (tempCompany.length() > 5) {
			tempCompany = tempCompany.substring(0, 6);
		}

		if (type.trim().length() == 0) {
			createAcctMsg = "Please input type";
		} else if (description.trim().length() == 0) {
			createAcctMsg = "Please input description";
		} else if (email.trim().length() == 0) {
			createAcctMsg = "Please input email";
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
				createAcctMsg = "Duplicate email. Please input unique email.";
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
					createAcctMsg = "Userid is already taken. Please input another userid.";
				} else {
					String password = ""
							+ Long.toHexString(Double.doubleToLongBits(Math
									.random()));
					password = password.substring(0, 13);
					String values = "\'" + userid + "\',\'" 
							+ "\',\'" + email + "\',\'" + type + "\',\'"
							+ company + "\',\'" + description + "\'";
					SQLManager.insertRecord("account", values);
					
					String uuid = UUID.randomUUID().toString();
					values = "\'" + userid + "\',\'" + uuid + "\'";
					SQLManager.insertRecord("password_link", values);
					createAcctMsg = "Account has been created. Userid: " + userid;
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
								+ "\n \n Your userid is: "
								+ userid
								+ "\n \n Visit this link to set your password: "
								+ "http://apps.greentransformationlab.com/EnergyCert/account/changepwd.jsp?link=" + uuid
								+ "\n \n This is the link to the application: "
								+ "http://apps.greentransformationlab.com/EnergyCert/");

						Transport.send(message);

						System.out.println("Done");

					} catch (MessagingException e) {
						createAcctMsg = "Email doesn't exist";
					}
				}
			}
		}

		session2.setAttribute("createAcctMsg", createAcctMsg);
		if (!success) {
			session2.setAttribute("createAcctUserid", userid);
			session2.setAttribute("createAcctType", type);
			session2.setAttribute("createAcctDescription", description);
			session2.setAttribute("createAcctEmail", email);
			response.sendRedirect("createacct.jsp");
		} else {
			response.sendRedirect("viewacct.jsp");
		}
	}

}

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

import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class ProcessRetrievalServlet
 */
@WebServlet("/ProcessRetrievalServlet")
public class ProcessRetrievalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessRetrievalServlet() {
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
		String email = request.getParameter("email");
		String retrievalMsg = null;

		if (email.trim().length() == 0) {
			retrievalMsg = "Please input your email";
		} else {

			boolean hasUserid = false;
			RetrievedObject ro = SQLManager.retrieveRecords("account",
					"Email=\'" + email + "\'");
			ResultSet rs = ro.getResultSet();
			try {
				if (rs.next()) {
					hasUserid = true;
					String userid = rs.getString("Userid");
					String uuid = UUID.randomUUID().toString();
					String values = "\'" + userid + "\',\'" + uuid + "\'";
					SQLManager.insertRecord("password_link", values);

					final String username = "gtl.fypeia@gmail.com";
					final String password = "pa55w0rd#";

					Properties props = new Properties();
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.port", "587");

					Session session = Session.getInstance(props,
							new javax.mail.Authenticator() {
								protected PasswordAuthentication getPasswordAuthentication() {
									return new PasswordAuthentication(username,
											password);
								}
							});

					try {

						Message message = new MimeMessage(session);
						message.setFrom(new InternetAddress(
								"gtl.fypeia@gmail.com"));
						message.setRecipients(Message.RecipientType.TO,
								InternetAddress.parse(email));
						message.setSubject("Password Reset");
						message.setText("Dear User,"
								+ "\n \nVisit this link to reset your password: "
								+ "http://apps.greentransformationlab.com/EnergyCert/account/changepwd.jsp?link=" + uuid);

						Transport.send(message);

						System.out.println("Done");

					} catch (MessagingException e) {
						throw new RuntimeException(e);
					}
					retrievalMsg = "A password reset email has been sent to you";
				}
				if (!hasUserid) {
					retrievalMsg = "Invalid email";
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ro.close();
		}

		HttpSession session = request.getSession();
		session.setAttribute("retrievalMsg", retrievalMsg);
		session.setAttribute("retrievalEmail", email);
		response.sendRedirect("/EnergyCert/account/forgotpwd.jsp");
	}

}

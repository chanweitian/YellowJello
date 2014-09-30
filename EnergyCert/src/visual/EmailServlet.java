package visual;

import java.io.IOException;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.SQLManager;

public class EmailServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doPost(req, resp);

		String email = req.getParameter("Email");
		String quest_id = req.getParameter("q_id");

		final String username = "gtl.fypeia@gmail.com";
		final String password = "pa55w0rd#";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		final String link = "http://apps.greentransformationlab.com/EnergyCert/visual/calculate?quest_id="
				+ quest_id;

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				});

		try {
			String uuid = UUID.randomUUID().toString();

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("gtl.fypeia@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(email));
			message.setSubject("Sharing GTL Questionaire ID: " + quest_id);
			message.setText("Hi,"
					+ "\n\n Click here to view the Visual Output:  http://apps.greentransformationlab.com/EnergyCert/visual/calculate?quest_id="
					+ quest_id + "&link=" + uuid + "\n\n Thank you.");

			Transport.send(message);

			String site_def_values = "\'" + quest_id + "\',\'" + uuid
					+ "\',\'\',\'\'";

			System.out.println(site_def_values);

			SQLManager.insertRecord("questionnaire_link", site_def_values);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

		resp.sendRedirect("calculate?quest_id=" + quest_id);

	}

}

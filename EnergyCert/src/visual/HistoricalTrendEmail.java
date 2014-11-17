package visual;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.UUID;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import db.SQLManager;

/**
 * Servlet implementation class PortfolioEmail
 */
@WebServlet("/HistoricalTrendEmail")
public class HistoricalTrendEmail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doPost(req, resp);
		String site1 = req.getParameter("site");
		String site = site1.replaceAll(" ", "_");
		String email = req.getParameter("email");
		
		final String username = "gtl.fypeia@gmail.com";
		final String password = "pa55w0rd#";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		 
		final String link = "http://apps.greentransformationlab.com/EnergyCert/visual/historicalTrendEmail.jsp?site=" + site;
		
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
		try {
			
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("gtl.fypeia@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(email));
			message.setSubject("Sharing Historical Trend for Site : "+site);
			message.setText("Hi,"
				+ "\n\n Click here to view the warehouse portfolio:  http://apps.greentransformationlab.com/EnergyCert/visual/historicalTrendEmail.jsp?site="+site
				+ "\n\n Thank you.");
 
			Transport.send(message);
			
			JSONObject json = new JSONObject();
			resp.setContentType("application/JSON");
			PrintWriter out = resp.getWriter();
			String output = json.toString();
			out.println(output);
			out.close();
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		
	}
	
}


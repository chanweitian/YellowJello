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
		
		String site = req.getParameter("site");
		String email = req.getParameter("email");
		String chartSRC = req.getParameter("chartSRC");
		
		final String username = "gtl.fypeia@gmail.com";
		final String password = "pa55w0rd#";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		final String link = "http://apps.greentransformationlab.com/EnergyCert/visual/PortfolioViaEmail.jsp?" + site;
		
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
		try {
	         // Create a default MimeMessage object.
	         Message message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress("gtl.fypeia@gmail.com"));

	         // Set To: header field of the header.
				message.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(email));

	         // Set Subject: header field
			message.setSubject("Sharing Hitorical Trend for  Site: "+site);

	         // This mail has 2 part, the BODY and the embedded image
	         MimeMultipart multipart = new MimeMultipart("related");

	         // first part (the html)
	         BodyPart messageBodyPart = new MimeBodyPart();
	         String htmlText = "<H1>Hello</H1><img src=\"cid:image\">";
	         messageBodyPart.setContent(htmlText, "text/html");
	         // add it
	         multipart.addBodyPart(messageBodyPart);

	         // second part (the image)
	         messageBodyPart = new MimeBodyPart();
	         DataSource fds = new FileDataSource(
	            "/home/manisha/javamail-mini-logo.png");

	         messageBodyPart.setDataHandler(new DataHandler(fds));
	         messageBodyPart.setHeader("Content-ID", "<image>");

	         // add image to the multipart
	         multipart.addBodyPart(messageBodyPart);

	         // put everything together
	         message.setContent(multipart);
	         // Send message
	         Transport.send(message);

	         System.out.println("Sent message successfully....");
			
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


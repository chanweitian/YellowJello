package visual;

import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.simple.JSONObject;

import db.SQLManager;

/**
 * Servlet implementation class PortfolioEmail
 */
@WebServlet("/PortfolioEmail")
public class PortfolioEmail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doPost(req, resp);
		
		String year = req.getParameter("year");
		String filter = req.getParameter("filter");
		String filterValue1 = req.getParameter("filterValue");
		String axis = req.getParameter("axis");
		String email = req.getParameter("email");
		String filterValue = filterValue1.replaceAll(" ", "_");
		String company1 = req.getParameter("company");
		String company = company1.replaceAll(" ", "_");
		
		final String username = "gtl.fypeia@gmail.com";
		final String password = "pa55w0rd#";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		final String link = "http://apps.greentransformationlab.com/EnergyCert/visual/PortfolioViaEmail.jsp?year="+year+"&filter="+filter+"&filterValue"+filterValue+"&axis="+axis+ "&company=" + company;
		
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
			message.setSubject("Sharing Warehouse Portfolio: "+year);
			message.setText("Hi,"
				+ "\n\n Click here to view the warehouse portfolio:  http://apps.greentransformationlab.com/EnergyCert/visual/PortfolioViaEmail.jsp?year="+year+"&filter="+filter+"&filterValue="+filterValue+"&axis="+axis+"&company="+company
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


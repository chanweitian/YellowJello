package form;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import db.SQLManager;

/**
 * Servlet implementation class ProcessRetrievalServlet
 */
@WebServlet("/ProcessSendEmailServlet")
public class ProcessSendEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessSendEmailServlet() {
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
		
		PrintWriter out = response.getWriter();
		
		final String username = "gtl.fypeia@gmail.com";
		final String password = "pa55w0rd#";
		
		String receiver_name = request.getParameter("receiver_name");
		String receiver_email = request.getParameter("receiver_email");
		String receiver_msg = request.getParameter("message");
		String[] sections_array = request.getParameterValues("sections_assigned");
		String sections_string = "";
		if (sections_array != null) {
			for (String section : sections_array) {
				sections_string = sections_string + section + "*";
			}
		}
		if (sections_string.length() != 0) {
			sections_string = sections_string.substring(0,sections_string.length()-1);
		}
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
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
				InternetAddress.parse(receiver_email));
			message.setSubject("Questionnaire - Assignment of Questions");
			message.setText("Dear " + receiver_name + ","
					+ "\n\n You have been assigned to fill up some questions in this Energy Certificate Questionnaire."
					+ "\n\n Message from Sender: "
					+ "\n" + receiver_msg
					+ "\n\n This is the Link: " 
					+ "\n http://apps.greentransformationlab.com/EnergyCert/form/Questionnaire.jsp?link=" + uuid
					+ "\n\n Note: This link expires in 3 days."
					+ "\n\n Thank you.");
			Transport.send(message);
			
			HttpSession session1 = request.getSession();
			String quest_id = (String) session1.getAttribute("quest_id");
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
			String date = sdf.format(new Date()); 
			
			String site_def_values = "\'" + quest_id + "\',\'" + uuid + "\',\'" + date + "\',\'" + sections_string + "\'";
			
			SQLManager.insertRecord("questionnaire_link",site_def_values);
			
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		
		
		//response.sendRedirect("SuccessEmail.jsp");
		out.println("The email has been sent!");
	}
		
	
		
}

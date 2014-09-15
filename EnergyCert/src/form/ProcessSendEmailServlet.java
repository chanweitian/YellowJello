package form;

import java.io.IOException;
import java.io.PrintWriter;
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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
		
		String error_message = "";
		EmailValidator emailVal = new EmailValidator();
		
		if (receiver_name.equals("")) {
			error_message = "Receiver's Name is required";
		} else if (receiver_email.equals("")) {
			error_message = "Receiver's Email is required";
		} else if (!emailVal.validate(receiver_email)) {
			error_message = "Receiver's Email is invalid";
		} else if (receiver_msg.equals("")) {
			error_message = "Message to Receiver is required";
		} else if (sections_array == null || sections_array.length == 0) {
			error_message = "Select at least one section";
		}
		
		if (error_message.length() == 0) {
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
				out.println("The email has been sent!");
 
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}
		} else {
			out.println(error_message);
		}
	}	
		
}
	
class EmailValidator {
	 
	private Pattern pattern;
	private Matcher matcher;
 
	private static final String EMAIL_PATTERN = 
		"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
		+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
 
	public EmailValidator() {
		pattern = Pattern.compile(EMAIL_PATTERN);
	}
 
	/**
	 * Validate hex with regular expression
	 * 
	 * @param hex
	 *            hex for validation
	 * @return true valid hex, false invalid hex
	 */
	public boolean validate(final String hex) {
 
		matcher = pattern.matcher(hex);
		return matcher.matches();
 
	}
}
package client;

import java.io.IOException;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFCell;

import db.RetrievedObject;
import db.SQLManager;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
import java.util.Properties;

/**
 * Servlet implementation class ProcessImportServlet
 */
@MultipartConfig
@WebServlet("/ProcessImportServlet")
public class ProcessImportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessImportServlet() {
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
		//
        // Create an ArrayList to store the data read from excel sheet.
        //
		String importMsg = "";
		HttpSession session = request.getSession();
		final Part filePart = request.getPart("inputFile");
	    final String fileName = getFileName(filePart);
	    
	    //
        // Create an ArrayList to store the data read from excel sheet.
        //
        List sheetData = new ArrayList();

        InputStream fis = null;
        boolean success = false;
        
        try {
            //
            // Create a FileInputStream that will be use to read the excel file.
            //
            fis = filePart.getInputStream();

            //
            // Create an excel workbook from the file system.
            //
            try {
            	XSSFWorkbook workbook = new XSSFWorkbook(fis);
	            //
	            // Get the first sheet on the workbook.
	            //
	            XSSFSheet sheet = workbook.getSheetAt(0);
	
	            //
	            // When we have a sheet object in hand we can iterator on each
	            // sheet's rows and on each row's cells. We store the data read
	            // on an ArrayList so that we can printed the content of the excel
	            // to the console.
	            //
	            Iterator rows = sheet.rowIterator();
	            while (rows.hasNext()) {
	                XSSFRow row = (XSSFRow) rows.next();
	                Iterator cells = row.cellIterator();
	
	                List data = new ArrayList();
	                while (cells.hasNext()) {
	                    XSSFCell cell = (XSSFCell) cells.next();
	                    data.add(cell);
	                }
	
	                sheetData.add(data);
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	            if (fis != null) {
	                fis.close();
	            }
	        }
	
	        importMsg = showExelData(sheetData,request);
	        success = true;
	        
        } catch(InvalidOperationException ioe) {
        	importMsg = "Please input a valid file";
        }
        session.setAttribute("importMsg", importMsg);
        if(!success) {
        	response.sendRedirect("importusers.jsp");
        } else {
        	response.sendRedirect("viewacct.jsp");
        }
    }

    private static String showExelData(List sheetData, HttpServletRequest request) {
    	HttpSession session2 = request.getSession();
    	String company = (String) session2.getAttribute("company");
    	String tempCompany = company.replaceAll("\\s+","");
		if (tempCompany.length()>5) {
			tempCompany = tempCompany.substring(0,6);
		}
    	String importMsg = "";
    	
        //
        // Iterates the data and print it out to the console.
        //
        for (int i = 0; i < sheetData.size(); i++) {
            List list = (List) sheetData.get(i);
            
            if (i>0) {
            	String type = null;
            	String description = null;
            	String email = null;
            	String userid = null;
            	
	            for (int j = 0; j < list.size(); j++) {
	                XSSFCell cell = (XSSFCell) list.get(j);
	                System.out.print(cell.getRichStringCellValue().getString());
	                switch (j) {
	                case 0:
	                	userid = cell.getRichStringCellValue().getString();
	                	break;
	                case 1:
	                	type = cell.getRichStringCellValue().getString();
	                	break;
	                case 2:
	                	description = cell.getRichStringCellValue().getString();
	                	break;
	                case 3:
	                	email = cell.getRichStringCellValue().getString();
	                	break;
	                }
	                if (j < list.size() - 1) {
	                    System.out.print(", ");
	                }
	            }
	            
	            String password = "" + Long.toHexString(Double.doubleToLongBits(Math.random()));
				password = password.substring(0,13);
	            String values = "\'" + userid + "\',\'" + password + "\',\'" + email + "\',\'" + type + "\',\'" + company + "\',\'" + description + "\'";
    			SQLManager.insertRecord("account", values);
    			importMsg += "Account created. Userid: " + userid + "<br />";
    			
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
    				message.setFrom(new InternetAddress("gtl.fypeia@gmail.com"));
					message.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(email));
					message.setSubject("Login Credentials for EnergyCert");
					message.setText("Dear User,"
						+ "\n\n Your account has been created."
						+ "\n \n The following are your login credentials:"
						+ "\n Userid: " + userid
						+ "\n Password: " + password
						+ "\n \n This is the link for the application: "
						+ "http://apps.greentransformationlab.com/EnergyCert/");
    	 
    				Transport.send(message);
    				System.out.println();
    				System.out.println("Done");
    	 
    			} catch (MessagingException e) {
    			}
            }
            
        }
        return importMsg;
    }

	private String getFileName(final Part part) {
	    final String partHeader = part.getHeader("content-disposition");
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}

}

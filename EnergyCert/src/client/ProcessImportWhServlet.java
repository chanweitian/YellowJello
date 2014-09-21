package client;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.openxml4j.exceptions.InvalidOperationException;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import db.RetrievedObject;
import db.SQLManager;

/**
 * Servlet implementation class ProcessImportWhServlet
 */
@MultipartConfig
@WebServlet("/ProcessImportWhServlet")
public class ProcessImportWhServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessImportWhServlet() {
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
		String importWhMsg = "";
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
	
	        importWhMsg = showExelData(sheetData,request);
	        success = true;
	        
        } catch(InvalidOperationException ioe) {
        	importWhMsg = "Please input a valid file";
        }
        session.setAttribute("importWhMsg", importWhMsg);
        if (!success) {
        	response.sendRedirect("importwh.jsp");
        } else {
        	response.sendRedirect("viewwh.jsp");
        }
    }

    private static String showExelData(List sheetData, HttpServletRequest request) {
    	HttpSession session = request.getSession();
		String company = (String) session.getAttribute("company");
		String tempCompany = company.replaceAll("\\s+","");
		if (tempCompany.length()>5) {
			tempCompany = tempCompany.substring(0,6);
		}
    	String importWhMsg = "";
    	
        //
        // Iterates the data and print it out to the console.
        //
        for (int i = 0; i < sheetData.size(); i++) {
            List list = (List) sheetData.get(i);
            
            if (i>0) {
            	String region = null;
            	String country = null;
            	String site = null;
            	String street = null;
            	String city = null;
            	String postal = null;
            	
	            for (int j = 0; j < list.size(); j++) {
	                XSSFCell cell = (XSSFCell) list.get(j);
	                System.out.print(cell.getRichStringCellValue().getString());
	                switch (j) {
	                case 0:
	                	region = cell.getRichStringCellValue().getString();
	                	break;
	                case 1:
	                	country = cell.getRichStringCellValue().getString();
	                	break;
	                case 2:
	                	site = cell.getRichStringCellValue().getString();
	                	break;
	                case 3:
	                	street = cell.getRichStringCellValue().getString();
	                	break;
	                case 4:
	                	city = cell.getRichStringCellValue().getString();
	                	break;
	                case 5:
	                	postal = cell.getRichStringCellValue().getString();
	                	break;
	                }
	                if (j < list.size() - 1) {
	                    System.out.print(", ");
	                }
	            }
	            
	            boolean isUnique = false;
				String warehouseID = null;
				int temp = 0;
				while (!isUnique) {
					warehouseID = tempCompany + site.replaceAll("\\s+","");
					if (warehouseID.length()>28) {
						warehouseID = warehouseID.substring(0,28);
					}
					warehouseID = warehouseID + temp;
					RetrievedObject ro = SQLManager.retrieveRecords("site", "Site_ID=\'"+warehouseID+"\'");
					ResultSet rs = ro.getResultSet();
					boolean unique = true;
					try {
						while (rs.next()) {
							unique = false;
							temp++;
						}
						if (unique) {
							isUnique = true;
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					ro.close();
				}

				String values = "\'" + warehouseID + "\',\'" + company + "\',\'" + site + "\',\'" + country + "\',\'" + region 
						+ "\',\'" + street + "\',\'" + city + "\',\'" + postal + "\'";
				SQLManager.insertRecord("site", values);
				importWhMsg += "Site added. SiteID: " + warehouseID + "<br />";
				System.out.println();
    			
            }
            
        }
        return importWhMsg;
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
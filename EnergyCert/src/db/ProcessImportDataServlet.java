package db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Servlet implementation class ProcessTestImportServlet
 */
@MultipartConfig
@WebServlet("/ProcessImportDataServlet")
public class ProcessImportDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProcessImportDataServlet() {
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
		//
		// Create an ArrayList to store the data read from excel sheet.
		//
		final Part filePart = request.getPart("inputFile");
		final String fileName = getFileName(filePart);

		//
		// Create an ArrayList to store the data read from excel sheet.
		//
		List weatherData = new ArrayList();
		List emissionData = new ArrayList();

		InputStream fis = null;
		try {
			//
			// Create a FileInputStream that will be use to read the excel file.
			//
			fis = filePart.getInputStream();

			//
			// Create an excel workbook from the file system.
			//
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			//
			// Get the first sheet on the workbook.
			//
			XSSFSheet weatherSheet = workbook.getSheet("Weather");
			// XSSFSheet emissionSheet = workbook.getSheet("Emissions Factors");

			weatherData = dataToList(weatherSheet);
			// emissionData = dataToList(emissionSheet);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
			}
		}

		String testImportMsg = "";
		testImportMsg += importWeather(weatherData, request);
		// testImportMsg += importEmission(emissionData,request);
		HttpSession session = request.getSession();
		session.setAttribute("testImportMsg", testImportMsg);
		response.sendRedirect("importdata.jsp");
	}

	private static List<String> dataToList(XSSFSheet sheet) {
		List sheetData = new ArrayList();
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
		return sheetData;
	}

	private static String importWeather(List sheetData,
			HttpServletRequest request) {
		String tableName = "weather";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("Loc varchar(30)");
		fields.add("Month char(3)");
		fields.add("Temp double");
		fields.add("Country varchar(30)");
		String primaryKey = "Loc,Month";
		SQLManager.createTable(tableName, fields, primaryKey);

		//
		// Iterates the data and print it out to the console.
		//
		String[] monthArr = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
				"Aug", "Sep", "Oct", "Nov", "Dec" };

		for (int i = 0; i < sheetData.size(); i++) {
			List list = (List) sheetData.get(i);
			String location = null;
			String country = null;
			if (i > 0) {
				String month = null;
				double temp = 0;
				for (int j = 0; j < list.size(); j++) {
					XSSFCell cell = (XSSFCell) list.get(j);
					if (j == 0) {
						location = cell.getRichStringCellValue().getString();
					} else if (j == 1) {
						country = cell.getRichStringCellValue().getString();
					} else {
						month = monthArr[j - 2];
						temp = cell.getNumericCellValue();
						String values = "\'" + location + "\',\'" + month
								+ "\'," + temp + ",\'" + country + "\'";
						SQLManager.insertRecord("weather", values);
					}

				}

			}
		}
		return "Weather data imported<br />";
	}

	private static String importEmission(List sheetData,
			HttpServletRequest request) {
		String tableName = "emission";
		ArrayList<String> fields = new ArrayList<String>();
		fields.add("Country varchar(30)");
		fields.add("Type varchar(30)");
		fields.add("Unit varchar(15)");
		fields.add("gCO2 double");
		String primaryKey = "Country,Type";
		SQLManager.createTable(tableName, fields, primaryKey);

		//
		// Iterates the data and print it out to the console.
		//

		for (int i = 0; i < sheetData.size(); i++) {
			List list = (List) sheetData.get(i);
			if (i > 0) {
				String country = null;
				String type = null;
				String unit = null;
				double temp = 0;

				for (int j = 0; j < list.size(); j++) {
					XSSFCell cell = (XSSFCell) list.get(j);
					switch (j) {
					case 0:
						country = cell.getRichStringCellValue().getString();
						break;
					case 1:
						type = cell.getRichStringCellValue().getString();
						break;
					case 2:
						unit = cell.getRichStringCellValue().getString();
						break;
					case 3:
						temp = cell.getNumericCellValue();
						break;
					}

				}
				String values = "\'" + country + "\',\'" + type + "\',\'"
						+ unit + "\'," + temp;
				SQLManager.insertRecord("emission", values);

			}
		}
		return "Emissions data imported<br />";
	}

	private String getFileName(final Part part) {
		final String partHeader = part.getHeader("content-disposition");
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim()
						.replace("\"", "");
			}
		}
		return null;
	}
}

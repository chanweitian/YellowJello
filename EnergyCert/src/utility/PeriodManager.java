package utility;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import db.SQLManager;

public class PeriodManager {
private static HashMap<String,String> periodHM = new HashMap<String,String>();
	
	static {
		periodHM.clear();
		pullPeriods();
	}
	
	private static void pullPeriods() {
		ResultSet rs = SQLManager.retrieveAll("period");
	  	try {
			while (rs.next()) { 
				periodHM.put(rs.getString("Company"),rs.getString("Month"));
				
			}
	  	} catch(SQLException e) {
	  		e.printStackTrace();
	  	}
	}
	
	public static String getMonth(String company) {
		if (periodHM.size()==0) {
			pullPeriods();
		}
		String month = periodHM.get(company);
		if (month==null) {
			month = "Jan";
		}
		return month;
	}
	
	public static int getMonthInt(String company) {
		if (periodHM.size()==0) {
			pullPeriods();
		}
		String month = periodHM.get(company);
		int monthInt = 0;
		if (month!=null) {
			switch(month) {
				case "Feb":
					monthInt=1;
					break;
				case "Mar":
					monthInt=2;
					break;
				case "Apr":
					monthInt=3;
					break;
				case "May":
					monthInt=4;
					break;
				case "Jun":
					monthInt=5;
					break;
				case "Jul":
					monthInt=6;
					break;
				case "Aug":
					monthInt=7;
					break;
				case "Sep":
					monthInt=8;
					break;
				case "Oct":
					monthInt=9;
					break;
				case "Nov":
					monthInt=10;
					break;
				case "Dec":
					monthInt=11;
					break;
			}
		}
		return monthInt;
	}
	
	public static void setMonth(String company, String month) {
		if (periodHM.size()==0) {
			pullPeriods();
		}
		String m = periodHM.get(company);
		if (m==null) {
			SQLManager.insertRecord("period", "\'" + company + "\',\'" + month + "\'");
		} else {
			String toSet = "Month=\'" + month + "\'";
	    	String whereClause = "Company=\'" + company + "\'";
	    	SQLManager.updateRecords("period", toSet, whereClause);
		}
    	periodHM.put(company, month);
	}
}

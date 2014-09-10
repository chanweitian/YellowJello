package utility;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import db.RetrievedObject;
import db.SQLManager;

public class WeatherManager {
private static HashMap<String,Double> weatherHM = new HashMap<String,Double>();
private static HashMap<String,ArrayList<String>> countryHM = new HashMap<String,ArrayList<String>>();
	
	static {
		pullWeather();
	}
	
	private static void pullWeather() {
		weatherHM.clear();
		countryHM.clear();
		RetrievedObject ro = SQLManager.retrieveAll("weather");
		ResultSet rs = ro.getResultSet();
	  	try {
			while (rs.next()) { 
				weatherHM.put(rs.getString("Loc")+";"+rs.getString("Month"),rs.getDouble("Temp"));
				ArrayList<String> list = countryHM.get(rs.getString("Country"));
				if (list != null) {
					if (!list.contains(rs.getString("Loc"))) {
						list.add(rs.getString("Loc"));
						countryHM.put(rs.getString("Country"), list);
					}
				} else {
					list = new ArrayList<String>();
					list.add(rs.getString("Loc"));
					countryHM.put(rs.getString("Country"), list);
				}
			}
	  	} catch(SQLException e) {
	  		e.printStackTrace();
	  	}
	  	ro.close();
	}
	
	public static HashMap<String,ArrayList<String>> getCountryHM() {
		if (countryHM.size()==0) {
			pullWeather();
		}
		return countryHM;
	}
	
	public static HashMap<String,Double> getWeatherHM() {
		if (weatherHM.size()==0) {
			pullWeather();
		}
		return weatherHM;
	}
	
	public static void setWeatherHM(HashMap<String,Double> hm) {
		if (weatherHM.size()==0) {
			pullWeather();
		}
		String tableName = "weather";
		Iterator iter = hm.entrySet().iterator();
    	while (iter.hasNext()) {
	        Map.Entry<String,Double> pairs = (Map.Entry<String,Double>)iter.next();
	        String key = pairs.getKey();
	        String[] arr = key.split(";");
	        String loc = arr[0];
	        String month = arr[1];
	        double temp = pairs.getValue();
	        double storedTemp = weatherHM.get(key);
	        if (storedTemp!=temp) { 
		        String toSet = "Temp=" + temp;
		    	String whereClause = "Loc=\'" + loc + "\' and Month=\'" + month + "\'";
		    	SQLManager.updateRecords(tableName, toSet, whereClause);
	        }
	    }
    	weatherHM = hm;
	}
	
	public static double getTemp(String loc, String month) {
		if (weatherHM.size()==0) {
			pullWeather();
		}
		if (weatherHM.get(loc+";"+month)==null) {
			return 9999;
		} else {
			return weatherHM.get(loc+";"+month);
		}
	}
	
	public static void setVariable(String loc, String month, double temp) {
		if (weatherHM.size()==0) {
			pullWeather();
		}
		String toSet = "Temp=" + temp;
    	String whereClause = "Loc=\'" + loc + "\' and Month=\'" + month + "\'";
    	SQLManager.updateRecords("weather", toSet, whereClause);
    	weatherHM.put(loc+";"+month, temp);
	}
	
	public static double getCountryTemp(String country, String month) {
		if (countryHM.size()==0||weatherHM.size()==0) {
			pullWeather();
		}
		ArrayList<String> cities = countryHM.get(country);
		if (cities==null) {
			return 9999;
		}
		double sum = 0;
		for (String city: cities) {
			sum += weatherHM.get(city+";"+month);
		}
		return (sum/cities.size());
	}
	
	public static void addWeather(String country, String city, HashMap<String,Double> tempHM) {
		if (weatherHM.size()==0) {
			pullWeather();
		}
		String tableName = "weather";
		Iterator iter = tempHM.entrySet().iterator();
		ArrayList<String> valuesList = new ArrayList<String>();
    	while (iter.hasNext()) {
	        Map.Entry<String,Double> pairs = (Map.Entry<String,Double>)iter.next();
	        String month = pairs.getKey();
	        double temp = pairs.getValue();
	        valuesList.add("\'"+city+"\',\'"+month+"\',\'"+temp+"\',\'"+country+"\'");
	        weatherHM.put(city+";"+month, temp);
	    }
    	ArrayList<String> list = null;
    	if (countryHM.containsKey(country)) {
    		list = countryHM.get(country);
    	} else {
    		list = new ArrayList<String>();
    	}
    	list.add(city);
		countryHM.put(country,list);
    	SQLManager.insertRecords(tableName, valuesList);
	}
}

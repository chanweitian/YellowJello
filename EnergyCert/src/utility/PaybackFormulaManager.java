package utility;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import db.RetrievedObject;
import db.SQLManager;

public class PaybackFormulaManager {
private static HashMap<String,Integer> formulaHM = new HashMap<String,Integer>();
	
	static {
		pullFormula();
	}
	
	private static void pullFormula() {
		formulaHM.clear();
		RetrievedObject ro = SQLManager.retrieveAll("payback_formula");
		ResultSet rs = ro.getResultSet();
	  	try {
			while (rs.next()) { 
				formulaHM.put(rs.getString("Variable"),rs.getInt("Value"));
				
			}
	  	} catch(SQLException e) {
	  		e.printStackTrace();
	  	}
	  	ro.close();
	}
	
	public static HashMap<String,Integer> getFormulaHM() {
		if (formulaHM.size()==0) {
			pullFormula();
		}
		return formulaHM;
	}
	
	public static void setFormulaHM(HashMap<String,Integer> hm) {
		if (formulaHM.size()==0) {
			pullFormula();
		}
		String tableName = "payback_formula";
		Iterator iter = hm.entrySet().iterator();
    	while (iter.hasNext()) {
	        Map.Entry<String,Integer> pairs = (Map.Entry<String,Integer>)iter.next();
	        String field = pairs.getKey();
	        int input = pairs.getValue();
	        int storedInput = formulaHM.get(field);
	        if (storedInput!=input) { 
		        String toSet = "Value=" + input;
		    	String whereClause = "Variable=\'" + field + "\'";
		    	SQLManager.updateRecords(tableName, toSet, whereClause);
	        }
	    }
    	formulaHM = hm;
	}
	
	public static int getVariable(String variable) {
		if (formulaHM.size()==0) {
			pullFormula();
		}
		return formulaHM.get(variable);
	}
	
	public static void setVariable(String variable, int value) {
		if (formulaHM.size()==0) {
			pullFormula();
		}
		String toSet = "Value=" + value;
    	String whereClause = "Variable=\'" + variable + "\'";
    	SQLManager.updateRecords("payback_formula", toSet, whereClause);
    	formulaHM.put(variable, value);
	}
}

package utility;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import db.RetrievedObject;
import db.SQLManager;

public class FormulaManager {
	private static HashMap<String, Double> formulaHM = new HashMap<String, Double>();

	static {
		pullFormula();
	}

	private static void pullFormula() {
		formulaHM.clear();
		RetrievedObject ro = SQLManager.retrieveAll("formula");
		ResultSet rs = ro.getResultSet();
		try {
			while (rs.next()) {
				formulaHM.put(rs.getString("Variable"), rs.getDouble("Value"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ro.close();
	}

	public static HashMap<String, Double> getFormulaHM() {
		if (formulaHM.size() == 0) {
			pullFormula();
		}
		return formulaHM;
	}

	public static void setFormulaHM(HashMap<String, Double> hm) {
		if (formulaHM.size() == 0) {
			pullFormula();
		}
		String tableName = "formula";
		Iterator iter = hm.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry<String, Double> pairs = (Map.Entry<String, Double>) iter
					.next();
			String field = pairs.getKey();
			double input = pairs.getValue();
			double storedInput = formulaHM.get(field);
			if (storedInput != input) {
				String toSet = "Value=" + input;
				String whereClause = "Variable=\'" + field + "\'";
				SQLManager.updateRecords(tableName, toSet, whereClause);
			}
		}
		formulaHM = hm;
	}

	public static double getVariable(String variable) {
		if (formulaHM.size() == 0) {
			pullFormula();
		}
		return formulaHM.get(variable);
	}

	public static void setVariable(String variable, double value) {
		if (formulaHM.size() == 0) {
			pullFormula();
		}
		String toSet = "Value=" + value;
		String whereClause = "Variable=\'" + variable + "\'";
		SQLManager.updateRecords("formula", toSet, whereClause);
		formulaHM.put(variable, value);
	}
}

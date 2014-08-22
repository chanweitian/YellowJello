<%@page import="db.SQLManager,java.sql.*,java.util.*" %>
<%
String whereClause = "Company=\'" + session.getAttribute("company") + "\'";
ResultSet rs = SQLManager.retrieveRecords("site", whereClause);
HashMap<String,String> hm = new HashMap<String,String>();
String values = "";
String type = request.getParameter("q");
if (type.equalsIgnoreCase("Site")) {
	type = "site_info_name";
} else if (type.equalsIgnoreCase("Country")) {
	type = "site_info_address_country";
}
try {
	while (rs.next()) {
		hm.put(rs.getString(type),"1");
	}
	Set<String> keySet = hm.keySet();
	int count = 0;
	for (Iterator<String> it = keySet.iterator(); it.hasNext(); ) {
        String s = it.next();
        if (count==0) {
			values += s;
		} else {
			values += ";" + s;
		}
        count++;
    }
} catch (SQLException e1) {
	// TODO Auto-generated catch block
	e1.printStackTrace();
}

%>
<%=values%>
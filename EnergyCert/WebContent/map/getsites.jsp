<%@page import="db.*,java.sql.*" %>
<%
String company = request.getParameter("company");
RetrievedObject ro = SQLManager.retrieveRecords("site s, questionnaire q", "s.Site_ID = q.Site_ID and company = \'" + company + "\'");
ResultSet rs = ro.getResultSet();
String toReturn = "";
try {
	while (rs.next()) {
		toReturn += rs.getString("q.Site_ID") + "," + rs.getString("site_info_name") + "," + rs.getString("site_info_address_country")
				+ "," + rs.getString("Region") + "," + rs.getString("site_info_address_street") + "," 
				+ rs.getString("site_info_address_city") + "," + rs.getString("site_info_address_postal") + "," 
				+ rs.getString("year") + "," + rs.getString("energy_rating") + ";";
	}
} catch (SQLException e) {
	e.printStackTrace();
}
ro.close();
%>
<%=toReturn.substring(0,toReturn.length()-1)%>
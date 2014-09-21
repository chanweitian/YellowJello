<%@page import="db.*,java.sql.*,java.util.*" %>
<%
String questionnaire_id = request.getParameter("questionnaire_id");
RetrievedObject ro = SQLManager.retrieveRecords("site_definition", "questionnaire_id=\'" + questionnaire_id + "\'");
ResultSet rs = ro.getResultSet();
ArrayList<String> site_def_info_list = new ArrayList<String>();
ArrayList<String> activity_list = new ArrayList<String>();
try {
	while (rs.next()) {
		String site_def_info = rs.getString("site_def_info");
		//use delimiter ^ to split by building
		String[] site_def_info_array = site_def_info.split("\\^");
		for (String def : site_def_info_array) {
			//use delimiter * to split each building into zones
			String[] def_array = def.split("\\*");
			for (String d : def_array) {
				//add all zones to site_def_info_list regardless of buildings
				site_def_info_list.add(d);
			}
		}
		String site_def_activity = rs.getString("site_def_activity");
		String[] site_def_activity_array = site_def_activity.split("\\^");
		for (String act : site_def_activity_array) {
			//use delimiter * to split each building into zones
			String[] act_array = act.split("\\*");
			for (String a : act_array) {
				//add all zones to site_def_activity_list regardless of buildings
				activity_list.add(a);
			}
		}
	}
} catch (SQLException e) {
	e.printStackTrace();
}
ro.close();
for (int i=0; i<site_def_info_list.size(); i++) {
	String zone = site_def_info_list.get(i);
	String[] temp = zone.split("-");
	String activity = activity_list.get(i);
	if (i==0) {
		out.println(temp[1]+"//"+activity);
	} else {
		out.println(";" + temp[1]+"//"+activity);
	}
}
%>
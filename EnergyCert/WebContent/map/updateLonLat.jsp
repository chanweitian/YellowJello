<%@page import="db.*" %>
<%
String lon = request.getParameter("lon");
String lat = request.getParameter("lat");
String query = request.getQueryString();
String[] arr = query.split("&siteid=");
String siteid = arr[1];
String toSet = "Lon=\'" + lon + "\',Lat=\'" + lat + "\'";
SQLManager.updateRecords("site", toSet, "Site_ID=\'" + siteid + "\'");
%>
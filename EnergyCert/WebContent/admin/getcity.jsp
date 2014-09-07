<%@page import="java.net.*,java.io.*,utility.WeatherManager" %>
<% String countryCode = request.getParameter("q");
String[] arr0 = countryCode.split(";");
String toReturn = "";
try {
    URL url = new URL("http://www.westclicks.com/webservices/?f=json&c="+arr0[0]);
    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
    String strTemp = "";
    while (null != br.readLine()) {
    	strTemp = br.readLine();
    	strTemp = strTemp.substring(1,strTemp.length()-1);
    	while (strTemp.length()>0) {
    		int index = strTemp.indexOf("\",");
    		String temp;
    		if (index>-1) {
    			temp = strTemp.substring(0,index+1).replaceAll("\"","");
    			strTemp = strTemp.substring(index+2);
    		} else {
    			temp = strTemp.replaceAll("\"","");
    			strTemp = "";
    		}
    		String[] arr = temp.split(":");
    		if (WeatherManager.getTemp(arr[1], "Jan")==9999) {
        		toReturn += arr[1] + ";";
    		}
    	} %>
    <% }
} catch (Exception ex) {
    ex.printStackTrace();
} %>
<%=toReturn.substring(0,toReturn.length()-1)%>
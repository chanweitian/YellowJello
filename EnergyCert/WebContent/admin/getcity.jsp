<%@page import="java.net.*,java.io.*,utility.WeatherManager,java.util.*" %>
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
    		String city = arr[1];
    		Properties p = new Properties();
    		p.load(new StringReader("key="+city));
    		city = p.getProperty("key");
    		if (WeatherManager.getTemp(city, "Jan")==9999) {
        		toReturn += city + ";";
    		}
    	} %>
    <% }
} catch (Exception ex) {
    ex.printStackTrace();
} %>
<%=toReturn.substring(0,toReturn.length()-1)%>
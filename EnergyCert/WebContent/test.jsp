<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.net.*,java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
	function showValues(str)
	{
	var xmlhttp;    
	if (str=="")
	  {
	  document.getElementById("txtHint").innerHTML="";
	  return;
	  }
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var res = xmlhttp.responseText;
		  var values = res.split(";");
		  var select = document.getElementById("city"), option = null, next_desc = null;
		  var len = select.options.length;
		 
		  for (var i = 0; i < len; i++)
          {
              select.remove(0);
          }
          
		  for(x in values) {
		        option = document.createElement("option");
		        next_desc = values[x];
		        option.value = next_desc;
		        option.innerHTML = next_desc;
		        select.appendChild(option);
		    }
	    }
	  }
	xmlhttp.open("GET","test2.jsp?q="+str,true);
	xmlhttp.send();
	}
	</script>
</head>
<body>

<%
try {
    URL url = new URL("http://www.westclicks.com/webservices/?f=json");
    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
    String strTemp = "";
    while (null != br.readLine()) {
    	strTemp = br.readLine();
    	strTemp = strTemp.substring(1,strTemp.length()-1);
    	%>
    	<select id="country" name="country" onchange="showValues(this.value)" required>
    	<% while (strTemp.length()>0) {
    		int index = strTemp.indexOf("\",");
    		String temp;
    		if (index>-1) {
    			temp = strTemp.substring(0,index+1).replaceAll("\"","");
    			strTemp = strTemp.substring(index+2);
    		} else {
    			temp = strTemp.replaceAll("\"","");
    			strTemp = "";
    		}
    		String[] arr = temp.split(":"); %>
        	<option value="<%=arr[0] %>"><%=arr[1] %></option>
    		<% 
    	} %>
    	</select>
    <% }
} catch (Exception ex) {
    ex.printStackTrace();
}

%>

<select class="form-control" id="city" name="city"></select>

</body>
</html>
<%@include file="../protectclientad.jsp" %>
<%@page import="java.net.*,java.io.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Add Site</title>

	<!-- Bootstrap -->
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	
	<%-- JQuery script --%>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	
	<%-- Questionnaire.jsp --%>
	<link href="../css/questionnaire.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <style>
	    body {
		  padding-top: 40px;
		  padding-bottom: 30px;
		}
		
		.theme-dropdown .dropdown-menu {
		  position: static;
		  display: block;
		  margin-bottom: 20px;
		}
		
		.theme-showcase > p > .btn {
		  margin: 5px 0;
		}
		
		.heading {
		  margin-bottom: 10px;
		}
	</style>
	
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
		        option.value = next_desc.trim();
		        option.innerHTML = next_desc.trim();
		        select.appendChild(option);
		    }
		  option = document.createElement("option");
	        option.value = "Others";
	        option.innerHTML = "Others";
	        select.appendChild(option);
	    }
	  }
	xmlhttp.open("GET","getcity.jsp?q="+str,true);
	xmlhttp.send();
	}
	</script>
	
	<script>
	function cityChanged(str)
	{	
	var otherCity = document.getElementById("otherCity");
	if (str=="Others")
	  {
		otherCity.disabled=false;
		otherCity.required=true;
	  }
	else
	  {
		otherCity.value = "";
		otherCity.disabled=true;
		otherCity.required=false;
	  }
	}
	</script>
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<%
	String addWhMsg = (String) session.getAttribute("addWhMsg");
  	String addWhSite = (String) session.getAttribute("addWhSite");
  	String addWhCountry = (String) session.getAttribute("addWhCountry");
  	String addWhRegion = (String) session.getAttribute("addWhRegion");
  	String addWhStreet = (String) session.getAttribute("addWhStreet");
  	String addWhCity = (String) session.getAttribute("addWhCity");
  	String addWhPostal = (String) session.getAttribute("addWhPostal");
  	String otherCity = (String) session.getAttribute("otherCity");
  	String addWhSize = (String) session.getAttribute("addWhSize");
  	session.removeAttribute("addWhSize");
  	session.removeAttribute("addWhMsg");
  	session.removeAttribute("addWhSite");
  	session.removeAttribute("addWhCountry");
  	session.removeAttribute("addWhRegion");
  	session.removeAttribute("addWhStreet");
  	session.removeAttribute("addWhCity");
  	session.removeAttribute("addWhPostal");
  	session.removeAttribute("otherCity");
  	String countryCode = null;
    %>

	<div class="header">Add site</div>
    <div class="container theme-showcase" role="main">
		
      <%-- <h2 class="heading">Add warehouse</h2><p>--%>

      <form class="form-horizontal" role="form" action="processaddwh">
      	<div class="form-group">
		    <label for="region" class="col-sm-1 control-label">Region</label>
		    <div class="col-sm-4">
		      <% if (addWhRegion!=null) { %>
	    		<input type="text" class="form-control" id="region" name="region" value="<%=addWhRegion %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="region" name="region" required>
		      <% } %>
		      <i>E.g. APAC, Europe</i>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="country" class="col-sm-1 control-label">Country</label>
		    <div class="col-sm-4">
		    <% 
		      try {
			    URL url = new URL("http://www.westclicks.com/webservices/?f=json");
			    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
			    String strTemp = "";
			    while (null != br.readLine()) {
			    	strTemp = br.readLine();
			    	strTemp = strTemp.substring(1,strTemp.length()-1);
			    	%>
			    	<select class="form-control" id="country" name="country" onchange="showValues(this.value)" required>
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
			    		String[] arr = temp.split(":");
			    		if (addWhCountry==null) { 
			    			addWhCountry = arr[1];
			    		}
		    			if (addWhCountry.equals(arr[1])) { %>
		    				<option value="<%=arr[0]+";"+arr[1] %>" selected><%=arr[1] %></option>
		    				<% countryCode = arr[0];
		    			} else { %>
		    				<option value="<%=arr[0]+";"+arr[1] %>"><%=arr[1] %></option>
		    			<% }
			    	} %>
			    	</select>
			    <% }
			} catch (Exception ex) {
			    ex.printStackTrace();
			}
		      %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="site" class="col-sm-1 control-label">Site</label>
		    <div class="col-sm-4">
		      <% if (addWhSite!=null) { %>
	    		<input type="text" class="form-control" id="site" name="site" value="<%=addWhSite %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="site" name="site" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="street" class="col-sm-1 control-label">Street</label>
		    <div class="col-sm-4">
		      <% if (addWhStreet!=null) { %>
	    		<input type="text" class="form-control" id="street" name="street" value="<%=addWhStreet %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="street" name="street" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="city" class="col-sm-1 control-label">City/ State</label>
		    <div class="col-sm-4">
		     
		     <% 
		      try {
		    	  String serverName = request.getServerName();
			    	String urlString;
			    	if (serverName.equals("apps")) {
			    		urlString = "http://apps.greentransformationlab.com/EnergyCert/admin/addwh.jsp";
			    	} else {
			    		urlString = request.getRequestURL().toString();
			    	}
		    	urlString = urlString.replace("addwh.jsp","getcity.jsp?q="+countryCode);
			    URL url = new URL(urlString);
			    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
			    String strTemp = ""; %>
			    <select class="form-control" id="city" name="city" onchange="cityChanged(this.value)" required>
			    <% while (null != br.readLine()) {
			    	strTemp = br.readLine();
			    	String[] cityArr = strTemp.split(";");
			    	for (String s: cityArr) {
			    		if (s.equals(addWhCity)) { %>
		    				<option value="<%=s %>" selected><%=s %></option>
		    			<% } else if (s.length()>1) { %>
		    				<option value="<%=s %>"><%=s %></option>
		    			<% }
			    	}
			    } 
			    if("Others".equals(addWhCity)) { %>
		    		<option value="Others" selected>Others</option>
		    	<% } else { %>
		    		<option value="Others">Others</option>
		    	<% } %>
			    </select>
			<% } catch (Exception ex) {
			    ex.printStackTrace();
			}
		      %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="otherCity" class="col-sm-1 control-label">If Others:</label>
		    <div class="col-sm-4">
		    	<% if (otherCity==null) { %>
		    	  <input type="text" class="form-control" id="otherCity" name="otherCity" disabled>
		    	<% } else { %>
		    		<input type="text" class="form-control" id="otherCity" name="otherCity" value="<%=otherCity %>" required>
		    	<% } %>
		    </div>
		</div>
		  <div class="form-group">
		    <label for="postal" class="col-sm-1 control-label">Postal</label>
		    <div class="col-sm-4">
		      <% if (addWhPostal!=null) { %>
	    		<input type="text" class="form-control" id="postal" name="postal" value="<%=addWhPostal %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="postal" name="postal" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="totalSize" class="col-sm-1 control-label">Total Size (Sq M)</label>
		    <div class="col-sm-4">
		      <% if (addWhSize!=null) { %>
	    		<input type="text" class="form-control" id="totalSize" name="totalSize" value="<%=addWhSize %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="totalSize" name="totalSize" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Submit</button></p>
		      <% if (addWhMsg!=null) { %>
	        	<font color="maroon"><label><%=addWhMsg %></font></label>
	        <% } %>
		    </div>
		  </div>
		</form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

  </body>
</html>

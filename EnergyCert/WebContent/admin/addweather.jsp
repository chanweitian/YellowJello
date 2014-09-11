<%@include file="../protectdhlad.jsp" %>
<%@page import="java.net.*,java.io.*,utility.WeatherManager" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Add Weather</title>

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
		        option.value = next_desc;
		        option.innerHTML = next_desc;
		        select.appendChild(option);
		    }
	    }
	  }
	xmlhttp.open("GET","getcity.jsp?q="+str,true);
	xmlhttp.send();
	}
	</script>
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<%
	String addWeatherMsg = (String) session.getAttribute("addWeatherMsg");
  	String addWeatherCountry = (String) session.getAttribute("addWeatherCountry");
  	String addWeatherCity = (String) session.getAttribute("addWeatherCity");
  	String awJan = (String) session.getAttribute("awJan");
  	String awFeb = (String) session.getAttribute("awFeb");
  	String awMar = (String) session.getAttribute("awMar");
  	String awApr = (String) session.getAttribute("awApr");
  	String awMay = (String) session.getAttribute("awMay");
  	String awJun = (String) session.getAttribute("awJun");
  	String awJul = (String) session.getAttribute("awJul");
  	String awAug = (String) session.getAttribute("awAug");
  	String awSep = (String) session.getAttribute("awSep");
  	String awOct = (String) session.getAttribute("awOct");
  	String awNov = (String) session.getAttribute("awNov");
  	String awDec = (String) session.getAttribute("awDec");
  	session.removeAttribute("addWeatherMsg");
  	session.removeAttribute("addWeatherCountry");
  	session.removeAttribute("addWeatherCity");
  	session.removeAttribute("awJan");
  	session.removeAttribute("awFeb");
  	session.removeAttribute("awMar");
  	session.removeAttribute("awApr");
  	session.removeAttribute("awMay");
  	session.removeAttribute("awJun");
  	session.removeAttribute("awJul");
  	session.removeAttribute("awAug");
  	session.removeAttribute("awSep");
  	session.removeAttribute("awOct");
  	session.removeAttribute("awNov");
  	session.removeAttribute("awDec");
  	String countryCode = null;
    %>
	<div class="header">Add weather</div>
    <div class="container theme-showcase" role="main">

    

      <form class="form-horizontal" role="form" method="post" action="processaddweather">
      
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
			    		if (addWeatherCountry==null) { 
			    			addWeatherCountry = arr[1];
			    		}
		    			if (addWeatherCountry.equals(arr[1])) { %>
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
		    <label for="city" class="col-sm-1 control-label">City</label>
		    <div class="col-sm-4">
		    <% 
		      try {
		    	String serverName = request.getServerName();
		    	String urlString;
		    	if (serverName.equals("apps")) {
		    		urlString = "http://apps.greentransformationlab.com/EnergyCert/admin/addweather.jsp";
		    	} else {
		    		urlString = request.getRequestURL().toString();
		    	}
		    	urlString = urlString.replace("addweather.jsp","getcity.jsp?q="+countryCode);
			    URL url = new URL(urlString);
			    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
			    String strTemp = ""; %>
			    <select class="form-control" id="city" name="city" required>
			    <% while (null != br.readLine()) {
			    	strTemp = br.readLine();
			    	String[] cityArr = strTemp.split(";");
			    	for (String s: cityArr) {
			    		
			    		if (WeatherManager.getTemp(s, "Jan")==9999) {
				    		if (s.equals(addWeatherCity)) { %>
			    				<option value="<%=s %>" selected><%=s %></option>
			    			<% } else if (s.length()>1) { %>
			    				<option value="<%=s %>"><%=s %></option>
			    			<% }
			    		}
			    	}
			    } %>
			    </select>
			<% } catch (Exception ex) {
			    ex.printStackTrace();
			}
		      %>
		    </div>
		  </div>
		
		<div class="form-group">
			<label for="temp" class="col-sm-1 control-label">Temperature</label>
		    <div class="col-sm-9">
				<table class="table">
			        <thead>
			          <tr>
			            <th>Jan</th>
			            <th>Feb</th>
			            <th>Mar</th>
			            <th>Apr</th>
			            <th>May</th>
			            <th>Jun</th>
			            <th>Jul</th>
			            <th>Aug</th>
			            <th>Sep</th>
			            <th>Oct</th>
			            <th>Nov</th>
			            <th>Dec</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			          <tr>
			            <td>
			            <% if (awJan==null) { %>
			            	<input type="text" class="form-control" id="Jan" name="Jan" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Jan" name="Jan" value="<%=awJan %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awFeb==null) { %>
			            	<input type="text" class="form-control" id="Feb"" name="Feb" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Feb"" name="Feb" value="<%=awFeb %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awMar==null) { %>
			            	<input type="text" class="form-control" id="Mar" name="Mar" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Mar" name="Mar" value="<%=awMar %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awApr==null) { %>
			            	<input type="text" class="form-control" id="Apr" name="Apr" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Apr" name="Apr" value="<%=awApr %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awMay==null) { %>
			            	<input type="text" class="form-control" id="May" name="May" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="May" name="May" value="<%=awMay %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awJun==null) { %>
			            	<input type="text" class="form-control" id="Jun" name="Jun" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Jun" name="Jun" value="<%=awJun %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awJul==null) { %>
			            	<input type="text" class="form-control" id="Jul" name="Jul" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Jul" name="Jul" value="<%=awJul %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awAug==null) { %>
			            	<input type="text" class="form-control" id="Aug" name="Aug" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Aug" name="Aug" value="<%=awAug %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awSep==null) { %>
			            	<input type="text" class="form-control" id="Sep" name="Sep" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Sep" name="Sep" value="<%=awSep %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awOct==null) { %>
			            	<input type="text" class="form-control" id="Oct" name="Oct" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Oct" name="Oct" value="<%=awOct %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awNov==null) { %>
			            	<input type="text" class="form-control" id="Nov" name="Nov" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Nov" name="Nov" value="<%=awNov %>" required>
			            <% } %>
			            </td>
			            <td>
			            <% if (awDec==null) { %>
			            	<input type="text" class="form-control" id="Dec" name="Dec" required>
			            <% } else { %>
			            	<input type="text" class="form-control" id="Dec" name="Dec" value="<%=awDec %>" required>
			            <% } %>
			            </td>
			          </tr>
			        </tbody>
			      </table>
				</div>
			</div>
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Submit</button></p>
		      <% if (addWeatherMsg!=null) { %>
	        	<font color="maroon"><label><%=addWeatherMsg %></font></label>
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

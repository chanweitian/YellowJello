<%@page import="java.sql.*,db.*,java.util.*" %>
<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create Account</title>

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
		  var select = document.getElementById("description"), option = null, next_desc = null;
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
	xmlhttp.open("GET","getvalues.jsp?q="+str,true);
	xmlhttp.send();
	}
	</script>
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<%
	String createAcctMsg = (String) session.getAttribute("createAcctMsg");
  	String createAcctType = (String) session.getAttribute("createAcctType");
  	String createAcctDescription = (String) session.getAttribute("createAcctDescription");
  	String createAcctEmail = (String) session.getAttribute("createAcctEmail");
  	session.removeAttribute("createAcctMsg");
  	session.removeAttribute("createAcctType");
  	session.removeAttribute("createAcctDescription");
  	session.removeAttribute("createAcctEmail");
    %>

	<div class="header">Create account</div>
    <div class="container theme-showcase" role="main">
      <%--<h2 class="heading">Create account</h2><p>--%>


      <form class="form-horizontal" role="form" action="processcreateacct">
		  <div class="form-group">
		    <label for="type" class="col-sm-1 control-label">Type</label>
		    <div class="col-sm-2">
		    	<select class="form-control" id="type" name="type" onchange="showValues(this.value)" required>
		    	<% if ("Site".equals(createAcctType)) { %>
		    	  	<option value="Site" selected>Site</option>
				<% } else { %>
					<option value="Site">Site</option>
				<% } %>
				<% if ("Country".equals(createAcctType)) { %>
		    	  	<option value="Country" selected>Country</option>
				<% } else { %>
					<option value="Country">Country</option>
				<% } %>
				<% if ("Region".equals(createAcctType)) { %>
		    	  	<option value="Region" selected>Region</option>
				<% } else { %>
					<option value="Region">Region</option>
				<% } %>
				</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="description" class="col-sm-1 control-label">Description</label>
		    <div class="col-sm-4">
		      <select class="form-control" id="description" name="description" required>
			    <%
			    String whereClause = "Company=\'" + session.getAttribute("company") + "\'";
			    RetrievedObject ro = SQLManager.retrieveRecords("site", whereClause);
		    	ResultSet rs = ro.getResultSet();
			    HashMap<String,String> hm = new HashMap<String,String>();
			    String values = "";
			    String type = "";
			    if (createAcctType!=null) {
			    	type = createAcctType;
			    } else {
			    	type = "Site";
			    }
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
			    	for (Iterator<String> it = keySet.iterator(); it.hasNext(); ) {
			            String s = it.next();
			            if (s.equals(createAcctDescription)) { %>
			            	<option value="<%=s %>" selected><%=s %></option>
			            <% } else { %>
			            	<option value="<%=s %>"><%=s %></option>
			            <% }
			        }
			    } catch (SQLException e1) {
			    	// TODO Auto-generated catch block
			    	e1.printStackTrace();
			    }
			    ro.close();
			    %>
		      </select>
		    </div>
		    
		  </div>
		  <div class="form-group">
		    <label for="inputEmail" class="col-sm-1 control-label">Email</label>
		    <div class="col-sm-4">
		      <% if (createAcctEmail!=null) { %>
	    		<input type="email" class="form-control" id="email" name="email" value="<%=createAcctEmail %>" required>
		      <% } else { %>
		      <input type="email" class="form-control" id="email" name="email" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Submit</button></p>
		      <% if (createAcctMsg!=null) { %>
	        	<font color="maroon"><label><%=createAcctMsg %></font></label>
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

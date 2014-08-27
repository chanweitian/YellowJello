<%@page import="db.SQLManager,java.util.ArrayList,java.sql.*;" %>
<%@include file="../protectdhlad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Manage Company Account</title>

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
	
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% String managementMsg = (String) session.getAttribute("managementMsg");
  	String managementCompany = (String) session.getAttribute("managementCompany");
  	String managementEmail = (String) session.getAttribute("managementEmail");
  	session.removeAttribute("managementMsg");
  	session.removeAttribute("managementCompany");
  	session.removeAttribute("managementEmail");
    		
  	String userid = request.getParameter("userid");
    if (userid==null) {
    	userid = (String) session.getAttribute("mgmtUserid");
    	session.removeAttribute("mgmtUserid");
    }
  	ResultSet rs = SQLManager.retrieveRecords("account", "Userid=\'"+userid+"\'");
    String company = null;
    String email = null;
  	try {
		while (rs.next()) {
			company = rs.getString("Company");
		    email = rs.getString("Email");
		}
  	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  	%>

<<<<<<< HEAD
    <div class="header">Manage company account</div>
    <div class="container theme-showcase" role="main">

      <%-- <h2 class="heading">Manage company account</h2><p>--%>
=======
    
    <div class="header">Manage company account</div>
     <div class="container theme-showcase" role="main">
>>>>>>> FETCH_HEAD
      
      <form action="processdeletion" method="post">
      		<input type="hidden" name="userid" value="<%=userid %>">
      		<button class="btn btn-danger btn-sm" type="submit" style="margin-left:350px">Delete account</button></p>
      </form>
      
      <p>
      <form class="form-horizontal" role="form" method="post" action="processmgmt">
      	<input type="hidden" name="userid" value="<%=userid %>">
		  <div class="form-group">
		    <label for="inputCompany" class="col-sm-1 control-label">Company</label>
		    <div class="col-sm-4">
		    <% if (managementCompany!=null) { %>
	    		<input type="text" class="form-control" id="inputCompany" name="inputCompany" value="<%=managementCompany %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="inputCompany" name="inputCompany" value="<%=company %>" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="email" class="col-sm-1 control-label">Email</label>
		    <div class="col-sm-4">
		    <% if (managementEmail!=null) { %>
		    	<input type="email" class="form-control" id="inputEmail" name="inputEmail" value="<%=managementEmail %>" required>
		      <% } else { %>
		      <input type="email" class="form-control" id="inputEmail" name="inputEmail" value="<%=email %>" required>
		      <% } %>
		    </div>
		  </div>
	
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Save changes</button></p>
			      <% if (managementMsg!=null) { %>
	        	<font color="maroon"><label><%=managementMsg %></font></label>
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

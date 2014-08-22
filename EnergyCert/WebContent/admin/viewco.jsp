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

    <title>Company Account Management</title>

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
		  padding-top: 70px;
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
  
  	<% ResultSet rs = SQLManager.retrieveAll("account");
    String deletionFlag = (String) session.getAttribute("deletionFlag");
    session.removeAttribute("deletionFlag");
  	%>

    <div class="container theme-showcase" role="main">

      <h2 class="heading">View company accounts</h2><p>
      <p>
      	<% if (deletionFlag!=null) { %>
      	<div class="alert alert-warning">
        Account has been deleted successfully.
      	</div>
		<% } %>
      	<table class="table table-hover">
	        <thead>
	          <tr>
	            <th>Userid</th>
	            <th>Email</th>
	            <th>Company</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%try {
				while (rs.next()) { 
					if (rs.getString("Type").equals("Company Admin")) {%>
			          <tr>
			            <td><%=rs.getString("Userid") %></td>
			            <td><%=rs.getString("Email") %></td>
			            <td><%=rs.getString("Company") %></td>
			            <td>
			            	<a class="btn btn-default" href="manageco.jsp?userid=<%=rs.getString("Userid") %>">Manage</a>
			            </td>
			          </tr>
			          <% }
				}
	          } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}%>
	        </tbody>
	      </table>
      </p>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>

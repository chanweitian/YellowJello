<%@page import="db.SQLManager,java.util.ArrayList,java.sql.*;" %>
<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>View Warehouses</title>

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
  
  	<% 
  	String whereClause = "Company=\'" + (String) session.getAttribute("company") + "\'"; 
  	ResultSet rs = SQLManager.retrieveRecords("site", whereClause);
  	%>

    <div class="header">View warehouses</div>
     <div class="container theme-showcase" role="main">
      <p>
      	
      	<table class="table table-hover">
	        <thead>
	          <tr>
	            <th>WarehouseID</th>
	            <th>Site</th>
	            <th>Country</th>
	            <th>Region</th>
	            <th>Street</th>
	            <th>City</th>
	            <th>Postal</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%try {
				while (rs.next()) { %>
			          <tr>
			            <td><%=rs.getString("Site_ID") %></td>
			            <td><%=rs.getString("site_info_name") %></td>
			            <td><%=rs.getString("site_info_address_country") %></td>
			            <td><%=rs.getString("Region") %>
			            <td><%=rs.getString("site_info_address_street") %></td>
			            <td><%=rs.getString("site_info_address_city") %></td>
			            <td><%=rs.getString("site_info_address_postal") %>
			          </tr>
				<% }
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>

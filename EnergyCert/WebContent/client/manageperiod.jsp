<%@page import="db.SQLManager,java.util.*,java.sql.*;" %>
<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Manage Period</title>

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
		
		.btn-danger {
			margin-left: 350px;
		}
	</style>
	
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% String managePeriodMsg = (String) session.getAttribute("managePeriodMsg");
  	session.removeAttribute("managePeriodMsg");
    		
  	String company = (String) session.getAttribute("company");
  	String month = null;
  	ResultSet rs = SQLManager.retrieveRecords("period", "Company=\'"+company+"\'");
  	try {
		while (rs.next()) {
			month = rs.getString("month");
		}
  	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  	String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
  	%>
    <div class="header">Select the start month of your company's year</div>
    <div class="container theme-showcase" role="main">

      <%-- <h2 class="heading">Select the start month of your company's year:</h2><p> --%>

      <p>
      <form class="form-horizontal" role="form" action="processmanageperiod">
		  <div class="form-group">
		    <label for="month" class="col-sm-1 control-label">Start Month</label>
		    <div class="col-sm-2">
		    	<select class="form-control" id="month" name="month" onchange="showValues(this.value)" required>
		    	<% for (String s: months) {
		    		if (s.equals(month)) { %>
		    			<option value="<%= s %>" selected><%= s %></option>
		    		<% } else { %>
		    			<option value="<%= s %>"><%= s %></option>
		    		<% } 
		    	} %>
				</select>
		    </div>
		  </div>
	
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Save change</button></p>
			      <% if (managePeriodMsg!=null) { %>
	        	<font color="maroon"><label><%=managePeriodMsg %></font></label>
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

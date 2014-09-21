<%@include file="../protectdhlad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Add Company Account</title>

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
	String creationMsg = (String) session.getAttribute("creationMsg");
  	String creationCompany = (String) session.getAttribute("creationCompany");
  	String creationEmail = (String) session.getAttribute("creationEmail");
  	String creationUserid = (String) session.getAttribute("creationUserid");
  	session.removeAttribute("creationUserid");
  	session.removeAttribute("creationMsg");
  	session.removeAttribute("creationCompany");
  	session.removeAttribute("creationEmail");
    %>
	<div class="header">Add company account</div>
    <div class="container theme-showcase" role="main">

      <%-- <h2 class="heading">Create company account</h2><p>--%>


    

      <form class="form-horizontal" role="form" method="post" action="processcreation">
      	<div class="form-group">
		    <label for="inputUserid" class="col-sm-1 control-label">Userid</label>
		    <div class="col-sm-4">
	    	<% if (creationUserid!=null) { %>
	    		<input type="text" class="form-control" id="inputUserid" name="inputUserid" value="<%=creationUserid %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="inputUserid" name="inputUserid" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputCompany" class="col-sm-1 control-label">Company</label>
		    <div class="col-sm-4">
	    	<% if (creationCompany!=null) { %>
	    		<input type="text" class="form-control" id="inputCompany" name="inputCompany" value="<%=creationCompany %>" required>
		      <% } else { %>
		      <input type="text" class="form-control" id="inputCompany" name="inputCompany" required>
		      <% } %>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputEmail" class="col-sm-1 control-label">Email</label>
		    <div class="col-sm-4">
		    <% if (creationEmail!=null) { %>
		    	<input type="email" class="form-control" id="inputEmail" name="inputEmail" value="<%=creationEmail %>" required>
		      <% } else { %>
		      <input type="email" class="form-control" id="inputEmail" name="inputEmail" required>
		      <% } %>
		    </div>
		  </div>
	
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Submit</button></p>
		      <% if (creationMsg!=null) { %>
	        	<font color="maroon"><label><%=creationMsg %></font></label>
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

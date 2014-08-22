
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Retrieve Password</title>

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
		
		.form-search {
		  max-width: 330px;
		  padding: 15px;
		  margin: 0 auto;
		}
		.form-search .form-search-heading {
		  margin-bottom: 10px;
		}
		
	</style>

  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<%
	String retrievalMsg = (String) session.getAttribute("retrievalMsg");
  	String retrievalEmail = (String) session.getAttribute("retrievalEmail");
  	session.removeAttribute("retrievalMsg");
  	session.removeAttribute("retrievalUserid");
    %>

    <div class="container theme-showcase" role="main">

      <form class="form-search" role="form" method="post" action="processretrieval">
        <h2 class="form-search-heading">Enter your email:</h2><p>
		    <div class="input-group">
		      <% if (retrievalEmail!=null) { %>
		      	<input type="email" class="form-control" name="email" value="<%=retrievalEmail %>" required>
		      <% } else { %>
		      	<input type="email" class="form-control" name="email" required>
		      <% } %>
		      <span class="input-group-btn">
		        <button class="btn btn-default" type="submit">Search</button></p>
		      </span>
		    </div><!-- /input-group -->
		    <% if (retrievalMsg!=null) { %>
	        	<label><font color="maroon"><%=retrievalMsg %></font></label>
	        <% } %>
		</form>

    </div> <!-- /container -->


  </body>
</html>

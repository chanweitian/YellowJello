<%
String changeMsg = (String) session.getAttribute("changeMsg");
session.removeAttribute("changeMsg");
if (changeMsg!=null) { %>
	<script>alert("<%=changeMsg%>")</script>
<% } %>
<!DOCTYPE html>
<html lang="en">
  <head>
  
  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome</title>

	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	
	<%-- JQuery script --%>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
	
	<%-- Questionnaire.jsp --%>
	<link href="css/questionnaire.css" rel="stylesheet">
	<script type="text/javascript" src="js/questionnaire.js"></script>
	
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
		
		.form-signin {
		  max-width: 330px;
		  padding: 15px;
		  margin: 0 auto;
		}
		.form-signin .form-signin-heading,
		.form-signin .checkbox {
		  margin-bottom: 10px;
		}
		.form-signin .checkbox {
		  font-weight: normal;
		}
		.form-signin .form-control {
		  position: relative;
		  height: auto;
		  -webkit-box-sizing: border-box;
		     -moz-box-sizing: border-box;
		          box-sizing: border-box;
		  padding: 10px;
		  font-size: 16px;
		}
		.form-signin .form-control:focus {
		  z-index: 2;
		}
		.form-signin input[type="userid"] {
		  margin-bottom: -1px;
		  border-bottom-right-radius: 0;
		  border-bottom-left-radius: 0;
		}
		.form-signin input[type="password"] {
		  margin-bottom: 10px;
		  border-top-left-radius: 0;
		  border-top-right-radius: 0;
		}
	</style>

  </head>

  <body role="document">
  <%@include file="header.jsp" %>
  
  	<% if (session.getAttribute("userid")!=null) {
  		response.sendRedirect("Home.jsp");
  	} else {
  		String loginError = (String) session.getAttribute("loginError");
  		String loginUserid = (String) session.getAttribute("loginUserid");
  		String loginPassword = (String) session.getAttribute("loginPassword");
  		session.removeAttribute("loginError");
  		session.removeAttribute("loginUserid");
  		session.removeAttribute("loginPassword");
  	%>

    <div class="container theme-showcase" role="main">

      <form class="form-signin" role="form" method="post" action="processlogin">
        <h2 class="form-signin-heading">Please log in</h2><p>
        <% if (loginUserid!=null) { %>
        	<input type="userid" class="form-control" placeholder="Userid" name="userid" value="<%=loginUserid %>" required>
        <% } else { %>
        	<input type="userid" class="form-control" placeholder="Userid" name="userid" required autofocus>
        <% }
        if (loginPassword!=null) { %>
        	<input type="password" class="form-control" placeholder="Password" name="password" value="<%=loginPassword %>" required>
        <% } else { %>
        	<input type="password" class="form-control" placeholder="Password" name="password" required>
        <% } %>
        <label>
          <a href="account/forgotpwd.jsp">Forgot password?</a>
        </label>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button></p>
        <% if (loginError!=null) { %>
        	<label><font color="maroon"><%= loginError %></font></label>
      	<% } %>
      </form>

    </div> <!-- /container -->

	<% } %>

  </body>
</html>

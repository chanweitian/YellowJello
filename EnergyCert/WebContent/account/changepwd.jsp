<%@include file="../protect.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Change Password</title>

	<!-- Bootstrap -->
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	
	<%-- JQuery script --%>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	
	<%-- Questionnaire.jsp --%>
	<link href="../css/questionnaire.css" rel="stylesheet">
	
	<link rel="stylesheet" media="screen" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />

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
		
		.form-horizontal {
		  max-width: 430px;
		  padding: 15px;
		  margin: 0 auto;
		}
		.form-horizontal .form-horizontal-heading {
		  margin-bottom: 10px;
		  font-family:Rockwell;
		}
		
	</style>
  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<%
	String changeMsg = (String) session.getAttribute("changeMsg");
  	session.removeAttribute("changeMsg");
    %>

    <div class="container theme-showcase" role="main">

      <form class="form-horizontal" role="form" method="post" action="processchange">
      <h2 class="form-horizontal-heading">Change Password</h2><p>
      	<div class="row" id="pwd-container">
		  <div class="form-group">
		    <label for="current_password" class="col-sm-5 control-label">Current Password</label>
		    <div class="col-sm-7">
		      <input type="password" class="form-control" id="current_password" name="current_password" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="new_password" class="col-sm-5 control-label">New Password</label>
		    <div class="col-sm-7">
		      <input type="password" class="form-control" id="password" name="new_password" required>
		      <span class="pwstrength_viewport_progress"></span> <span class="pwstrength_viewport_verdict"></span>
		      <div id="messages" class="col-sm-12"></div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="confirm_password" class="col-sm-5 control-label">Confirm Password</label>
		    <div class="col-sm-7">
		      <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
		    </div>
		  </div>
			
		  <div class="form-group">
		    <div class="col-sm-offset-5 col-sm-7">
		      <button type="submit" class="btn btn-default">Save changes</button></p>
		      <% if (changeMsg!=null) { %>
		       	<font color="maroon"><label><%=changeMsg %></font></label>
		       	<% } %> 
		    </div>
		  </div>
		 </div>
		</form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="../js/zxcvbn-async.js"></script>
    <script type="text/javascript" src="../js/pwstrength.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            "use strict";
            var options = {};
            options.ui = {
                container: "#pwd-container",
                viewports: {
                    progress: ".pwstrength_viewport_progress",
                    verdict: ".pwstrength_viewport_verdict"
                }
            };
            options.common = {
                onLoad: function () {
                    $('#messages').text('Start typing password');
                },
                zxcvbn: true
            };
            $('#password').pwstrength(options);
        });
    </script>
  </body>
</html>

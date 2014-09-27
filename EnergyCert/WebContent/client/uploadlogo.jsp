<%@page import="java.io.*" %>
<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Upload Company Logo</title>

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
  
  <% String uploadMsg = (String) session.getAttribute("uploadMsg");
	session.removeAttribute("uploadMsg");
  %>

	<div class="header">Upload company logo</div>
    <div class="container theme-showcase" role="main">
		      
      <p>Please upload a jpg image with a width of 105px and a height of 23px.<br /></p>

      <form class="form-horizontal" role="form" action="processuploadlogo" method="POST" enctype="multipart/form-data" >
		  <div class="form-group">
		    <label for="inputFile" class="col-sm-1 control-label">Image</label>
		    <div class="col-sm-4">
		      <input type="file" id="inputFile" name="inputFile" accept="image/jpg" required>
		    </div>	
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Upload</button></p>
		      <% if (uploadMsg!=null) { %>
	        	<font color="maroon"><label><%=uploadMsg %></font></label>
	        <% } %>
		    </div>
		  </div>
		</form>

	<%
	String co = (String) session.getAttribute("company");
	co = co.replaceAll(" ","");
	%>
	<p><strong>Current logo:</strong><img src="../img/<%=co %>.jpg" height="23" width="105" /></p>
	
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>

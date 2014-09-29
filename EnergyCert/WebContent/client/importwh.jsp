<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Import Sites</title>

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
  
  <% String importWhMsg = (String) session.getAttribute("importWhMsg");
	session.removeAttribute("importWhMsg");
  %>

	<div class="header">Import sites</div>
    <div class="container theme-showcase" role="main">
		
      <%--<h2 class="heading">Import users</h2><p>--%>
      
      <p>Click on the link to download a sample of the format: <a href="sites.xlsx">Download here</a></p>

      <form class="form-horizontal" role="form" action="processimportwh" method="POST" enctype="multipart/form-data" >
		  <div class="form-group">
		    <label for="inputFile" class="col-sm-1 control-label">Input file</label>
		    <div class="col-sm-4">
		      <input type="file" id="inputFile" name="inputFile" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" required>
		    </div>	
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-1 col-sm-4">
		      <button type="submit" class="btn btn-default">Upload</button></p>
		      <% if (importWhMsg!=null) { %>
	        	<font color="maroon"><label><%=importWhMsg %></font></label>
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

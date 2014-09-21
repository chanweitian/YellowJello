<%@page import="db.*,java.util.ArrayList,java.sql.*;" %>
<%@include file="../protectclientad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Manage Sites</title>

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
		
		.modal {
		  margin-top: 50px;
		}
	</style>

  </head>

  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% 
  	String whereClause = "Company=\'" + (String) session.getAttribute("company") + "\'"; 
  	RetrievedObject ro = SQLManager.retrieveRecords("site", whereClause);
  	ResultSet rs = ro.getResultSet();
  	String deleteWhFlag = (String) session.getAttribute("deleteWhFlag");
    session.removeAttribute("deleteWhFlag");
    String addWhMsg = (String) session.getAttribute("addWhMsg");
    session.removeAttribute("addWhMsg");
    String importWhMsg = (String) session.getAttribute("importWhMsg");
    session.removeAttribute("importWhMsg");
  	%>

	<div class="header">Manage sites</div>
    <div class="container theme-showcase" role="main">

      <%-- <h2 class="heading">View warehouses</h2><p> --%>

      	<% if (deleteWhFlag!=null) { %>
      	<div class="alert alert-warning">
        Site has been deleted successfully.
      	</div>
		<% } %>
      	
      	<% if (addWhMsg!=null) { %>
      	<div class="alert alert-warning">
        <%=addWhMsg %>
      	</div>
		<% } %>
		
		<% if (importWhMsg!=null) { %>
      	<div class="alert alert-warning">
        <%=importWhMsg %>
      	</div>
		<% } %>
      	
      	<p>
			<a class="btn btn-primary" href="addwh.jsp" style="margin-left:12px">Add Site</a>
			<a class="btn btn-primary" href="importwh.jsp" style="margin-left:915px">Import Sites</a>
		</p>
		
      	<table class="table table-hover">
	        <thead>
	          <tr>
	            <th>SiteID</th>
	            <th>Region</th>
	            <th>Country</th>
	            <th>Site</th>
	            <th>Street</th>
	            <th>State</th>
	            <th>Postal</th>
	          </tr>
	        </thead>
	        <tbody>
	        <% int count=0;
	        try {
				while (rs.next()) { 
					count++;%>
			          <tr>
			            <td><%=rs.getString("Site_ID") %></td>
			            <td><%=rs.getString("Region") %>
			            <td><%=rs.getString("site_info_address_country") %></td>
			            <td><%=rs.getString("site_info_name") %></td>
			            <td><%=rs.getString("site_info_address_street") %></td>
			            <td><%=rs.getString("site_info_address_city") %></td>
			            <td><%=rs.getString("site_info_address_postal") %>
			            <td>
			            	<a class="btn btn-default" href="managewh.jsp?siteid=<%=rs.getString("Site_ID") %>">Modify</a>
			            </td>
			            <td>
			            	<button class="btn btn-danger" data-toggle="modal" data-target="#deleteModal<%=rs.getString("Site_ID")%>">Delete</button>
      					</td>
			          </tr>
			          <div class="modal fade" id="deleteModal<%=rs.getString("Site_ID")%>" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog" style="left: 0px">
							<div class="modal-content">
								<div class="modal-header">
						 <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
									<h4 class="modal-title">Delete site</h4>
								</div>
				
								<div class="modal-body">
									<form action="processdeletewh" method="post">
										<center>Are you sure you want to delete the site?<br /><br />
							      		<input type="hidden" name="siteid" value="<%=rs.getString("Site_ID") %>">
							      		<button class="btn" type="submit">Yes</button>
							      		<button class="btn" data-dismiss="modal">No</button>
							      		</center>
							      </form>
								</div>
							</div>
						</div>
					</div> 
				<% }
	          } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ro.close();%>
	        </tbody>
	      </table>
			<% if (count==0) { %>
	          	<p><strong><font color="red">No site has been added. Click on Add Site to add one.</font></strong></p>
	          <% }
			  %>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>

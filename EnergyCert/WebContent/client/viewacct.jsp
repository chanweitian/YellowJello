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

    <title>Account Management</title>

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
  	RetrievedObject ro = SQLManager.retrieveRecords("account", whereClause);
  	ResultSet rs = ro.getResultSet();
    String deleteAcctFlag = (String) session.getAttribute("deleteAcctFlag");
    session.removeAttribute("deleteAcctFlag");
    String createAcctMsg = (String) session.getAttribute("createAcctMsg");
    session.removeAttribute("createAcctMsg");
    String importMsg = (String) session.getAttribute("importMsg");
    session.removeAttribute("importMsg");
  	%>
	<div class="header">Manage accounts</div>
    <div class="container theme-showcase" role="main">

      <%-- <h2 class="heading">View accounts</h2><p>--%>

      	<% if (deleteAcctFlag!=null) { %>
      	<div class="alert alert-warning">
        Account has been deleted successfully.
      	</div>
		<% } %>
		
		<% if (createAcctMsg!=null) { %>
      	<div class="alert alert-warning">
        <%=createAcctMsg %>
      	</div>
		<% } %>
		
		<% if (importMsg!=null) { %>
      	<div class="alert alert-warning">
        <%=importMsg %>
      	</div>
		<% } %>
		
		<p>
			<a class="btn btn-primary" href="createacct.jsp" style="margin-left:12px">Add Account</a>
			<a class="btn btn-primary" href="importusers.jsp" style="margin-left:870px">Import Accounts</a>
		</p>
			
      	<table class="table table-hover">
	        <thead>
	          <tr>
	            <th>Userid</th>
	            <th>Email</th>
	            <th>Type</th>
	            <th>Description</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%int count=0;
	        try {
				while (rs.next()) { 
					if (!rs.getString("Type").equals("Company Admin")) {%>
			          <tr>
			            <td><%=rs.getString("Userid") %></td>
			            <td><%=rs.getString("Email") %></td>
			            <td><%=rs.getString("Type") %></td>
			            <td><%=rs.getString("Description") %></td>
			            <td>
			            	<a class="btn btn-default" href="manageacct.jsp?userid=<%=rs.getString("Userid") %>">Modify</a>
			            </td>
			            <td>
			            	<button class="btn btn-danger" data-toggle="modal" data-target="#deleteModal<%=rs.getString("Userid") %>">Delete</button></p>
			            </td>
			          </tr>
			          <div class="modal fade" id="deleteModal<%=rs.getString("Userid") %>" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog" style="left: 0px">
							<div class="modal-content">
								<div class="modal-header">
						 <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
									<h4 class="modal-title">Delete account</h4>
								</div>
				
								<div class="modal-body">
									<form action="processdeleteacct" method="post">
										<center>Are you sure you want to delete the account?<br /><br />
							      		<input type="hidden" name="userid" value="<%=rs.getString("Userid") %>">
							      		<button class="btn" type="submit">Yes</button>
							      		<button class="btn" data-dismiss="modal">No</button>
							      		</center>
							      </form>
								</div>
							</div>
						</div>
					</div> 
			          <% count++;
					}
				}
	          } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ro.close();%>
	        </tbody>
	      </table>
	      <% if (count==0) { %>
          	<p><strong><font color="red">No account has been added. Click on Add Account to add one.</font></strong></p>
          <% }
		  %>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>

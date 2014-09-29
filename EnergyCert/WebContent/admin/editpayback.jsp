<%@page import="db.SQLManager,java.util.*,java.sql.*,utility.PaybackFormulaManager" %>
<%@include file="../protectdhlad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Edit Payback Formula</title>
	
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
		
		.btn-primary {
			margin-left: 1030px;
		}
	</style>
  </head>
  
  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% String paybackFlag = (String) session.getAttribute("paybackFlag");
    session.removeAttribute("paybackFlag");
    Map<String,String[]> paybackHM = new HashMap<String,String[]>(); 
    ArrayList<String> paybackMsg = null;
    String paybackSuccess = null;
    if (paybackFlag==null) {
  		HashMap<String,Integer> hm = PaybackFormulaManager.getFormulaHM();
  		Iterator iter = hm.entrySet().iterator();
    	while (iter.hasNext()) {
	        Map.Entry<String,Integer> pairs = (Map.Entry<String,Integer>)iter.next();
	        String variable = pairs.getKey();
	        Integer value = pairs.getValue();
	        String[] temp = {"" + value};
	        paybackHM.put(variable,temp);
	    }
    } else {
    	//insert code for retrieving values from processediting
    	paybackHM = (Map<String,String[]>) session.getAttribute("paybackHM");
    	paybackMsg = (ArrayList<String>) session.getAttribute("paybackMsg");
    	paybackSuccess = (String) session.getAttribute("paybackSuccess");
        session.removeAttribute("paybackSuccess");
        session.removeAttribute("paybackHM");
        session.removeAttribute("paybackMsg");
    }
    String[] types = {"current", "t5", "t5_sensors", "t8", "t8_sensors", "LED", "induction", "metal_halide", "CFL"};
    String[] typesDisplay = {"Current", "T5", "T5 with sensors", "T8", "T8 with sensors", "LED", "Induction", "Metal Halide", "CFL"};
  	%>

  	<div class="header">Edit Payback Formula</div>
    <div class="container theme-showcase" role="main">
    
    	<% if (paybackSuccess!=null) { %>
      	<div class="alert alert-warning">
        <%=paybackSuccess %>
      	</div>
		<% } %>
    
    <form class="form-horizontal" role="form" method="post" action="processeditpayback">
      
      <div class="form-group">
	  	<button type="submit" class="btn btn-primary">Save Changes</button>
	  	<% if (paybackMsg!=null) { %>
	  		<p>
				<% for (String msg: paybackMsg) { %>
        			<font color="maroon"><label class="temp"><%=msg %></font></label><br />
        		<% } %>
				</p>
        	<% } %>
	  </div>
      
      <table class="table table-hover">
	        <thead>
	          <tr>
	            <th>Lighting Type</th>
	            <th>Num of fixtures</th>
	            <th>Lamp per fixture</th>
	            <th>Power rating (W)</th>
	            <th>Efficacy (lm/W)</th>
	            <th>Ballast Factor</th>
	            <th>Ops hours red. (with sensors)</th>
	            <th>Cost per lamp</th>
	            <th>Installation cost per fixture</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        for (int i=0; i<types.length; i++) { 
	        	String type = types[i];
	        	String[] variables;
	        	if (type.equals("current")) {
	        		variables = new String[6];
	        	} else {
	        		variables = new String[8];
	        	}
	        	variables[0] = type + "_num_fixtures";
	        	variables[1] = type + "_lamp_fixture";
	        	variables[2] = type + "_power_rating";
	        	variables[3] = type + "_efficacy";
	        	variables[4] = type + "_ballast_factor";
	        	variables[5] = type + "_op_hours";
	        	if (!type.equals("current")) {
		        	variables[6] = type + "_cost_lamp";
		        	variables[7] = type + "_installation_cost";
	        	}
	        	%>
	        	<tr>
	        		<td><%=typesDisplay[i] %></td>
	        		<% for (String var: variables) { %> 
	        			<td><input type="text" class="form-control" id="<%=var %>" name="<%=var %>" value="<%=paybackHM.get(var)[0] %>" required></td>
	        		<% } %>
	        	</tr>
	        <% } %>
	        </tbody>
	      </table>
		
		<div class="form-group">
			<button type="submit" class="btn btn-primary">Save Changes</button>
	  	</div>
	  	</form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
  </body>
</html>

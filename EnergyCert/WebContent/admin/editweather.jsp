<%@page import="db.SQLManager,java.util.*,java.sql.*,utility.WeatherManager" %>
<%@include file="../protectdhlad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Manage Weather</title>
	
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
		
		.temp {
		  margin-left: 20px;
		}
		
		.heading {
		  margin-bottom: 10px;
		}
		
		$('#accordion').on('show.bs.collapse', function () {
		    if (active) $('#accordion .in').collapse('hide');
		});
		
		.modal {
		  margin-top: 50px;
		}
	</style>
  </head>
  
  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% String weatherFlag = (String) session.getAttribute("weatherFlag");
    session.removeAttribute("weatherFlag");
    String addWeatherMsg = (String) session.getAttribute("addWeatherMsg");
    session.removeAttribute("addWeatherMsg");
    Map<String,String[]> weatherHM = new HashMap<String,String[]>(); 
    ArrayList<String> weatherMsg = null;
    HashMap<String,ArrayList<String>> countryHM = WeatherManager.getCountryHM();
    if (weatherFlag==null) {
  		HashMap<String,Double> hm = WeatherManager.getWeatherHM();
  		Iterator iter = hm.entrySet().iterator();
    	while (iter.hasNext()) {
	        Map.Entry<String,Double> pairs = (Map.Entry<String,Double>)iter.next();
	        String key = pairs.getKey();
	        Double temp = pairs.getValue();
	        String[] tempArr = {"" + temp};
	        weatherHM.put(key,tempArr);
	    }
    } else {
    	//insert code for retrieving values from processediting
    	weatherHM = (Map<String,String[]>) session.getAttribute("weatherHM");
    	weatherMsg = (ArrayList<String>) session.getAttribute("weatherMsg");
        session.removeAttribute("weatherHM");
        session.removeAttribute("weatherMsg");
    }
  	%>

  
  <div class="header">Manage weather</div>
    <div class="container theme-showcase" role="main">
    	
    	<% if (addWeatherMsg!=null) { %>
      	<div class="alert alert-warning">
        <%=addWeatherMsg %>
      	</div>
		<% } %>
    	
    	<p>The following are the Average Monthly Temperature (°C) of the different Cities/ States.</p>
      
      <form class="form-horizontal" role="form" method="post" action="processeditweather">
      <div class="form-group">
      	<a class="btn btn-primary" href="addweather.jsp" style="margin-left:12px">Add Weather</a>
	  	<button type="submit" class="btn btn-primary" style="margin-left:900px">Save Changes</button>
	  	<% if (weatherMsg!=null) { %>
	  		<p>
				<% for (String msg: weatherMsg) { %>
        			<font color="maroon"><label class="temp"><%=msg %></font></label><br />
        		<% } %>
				</p>
        	<% } %>
     	 </div>
     <div class="panel-group" id="accordion">
      <% int count=0;
      Set<String> countries = countryHM.keySet();
      ArrayList<String> list = new ArrayList<String>();
      list.addAll(countries);
      Collections.sort(list);
      for (String country: list) { %>
    	  <div class="panel panel-default">
		    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="<%="#collapse"+count %>">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          <%=country %>
		        </a>
		      </h4>
		    </div>
		    
		    <% if (count==0) { %>
			    	<div id="<%="collapse"+count %>" class="panel-collapse collapse in">
			    <% } else { %>
			    	<div id="<%="collapse"+count %>" class="panel-collapse collapse">
			    <% } 
			    count++; %>
			      <div class="panel-body">
	      
					  <table class="table table-hover">
			        <thead>
			          <tr>
			            <th>State</th>
			            <th>Jan</th>
			            <th>Feb</th>
			            <th>Mar</th>
			            <th>Apr</th>
			            <th>May</th>
			            <th>Jun</th>
			            <th>Jul</th>
			            <th>Aug</th>
			            <th>Sep</th>
			            <th>Oct</th>
			            <th>Nov</th>
			            <th>Dec</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			        <% ArrayList<String> cities = countryHM.get(country);
			        Collections.sort(cities);
			          for (String city: cities) { %>
			          <tr>
			            <td><%=city %></td>
			            <td><input type="text" class="form-control" id="<%=city+";Jan" %>" name="<%=city+";Jan" %>" value="<%=weatherHM.get(city+";Jan")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Feb" %>" name="<%=city+";Feb" %>" value="<%=weatherHM.get(city+";Feb")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Mar" %>" name="<%=city+";Mar" %>" value="<%=weatherHM.get(city+";Mar")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Apr" %>" name="<%=city+";Apr" %>" value="<%=weatherHM.get(city+";Apr")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";May" %>" name="<%=city+";May" %>" value="<%=weatherHM.get(city+";May")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Jun" %>" name="<%=city+";Jun" %>" value="<%=weatherHM.get(city+";Jun")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Jul" %>" name="<%=city+";Jul" %>" value="<%=weatherHM.get(city+";Jul")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Aug" %>" name="<%=city+";Aug" %>" value="<%=weatherHM.get(city+";Aug")[0] %>" required></td>
			          	<td><input type="text" class="form-control" id="<%=city+";Sep" %>" name="<%=city+";Sep" %>" value="<%=weatherHM.get(city+";Sep")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Oct" %>" name="<%=city+";Oct" %>" value="<%=weatherHM.get(city+";Oct")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Nov" %>" name="<%=city+";Nov" %>" value="<%=weatherHM.get(city+";Nov")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="<%=city+";Dec" %>" name="<%=city+";Dec" %>" value="<%=weatherHM.get(city+";Dec")[0] %>" required></td>
			          </tr>
			          <% } %>
			        </tbody>
			      </table>
	
			      </div>
			    </div>
			  </div>
	  <% } %>
      
			    
		  
		</div>
		
		<div class="form-group">
			<button type="submit" class="btn btn-primary" style="margin-left:1030px">Save Changes</button>
	  	</div>
	  	</form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
  </body>
</html>

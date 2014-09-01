<%@page import="db.SQLManager,java.util.*,java.sql.*,utility.FormulaManager" %>
<%@include file="../protectdhlad.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Edit Formula</title>
	
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
		
		.btn-primary {
			margin-left: 1030px;
		}
	</style>
  </head>
  
  <body role="document">
  <%@include file="../header.jsp" %>
  
  	<% String editFlag = (String) session.getAttribute("editFlag");
    session.removeAttribute("editFlag");
    Map<String,String[]> formulaHM = new HashMap<String,String[]>(); 
    ArrayList<String> editMsg = null;
    if (editFlag==null) {
  		HashMap<String,Double> hm = FormulaManager.getFormulaHM();
  		Iterator iter = hm.entrySet().iterator();
    	while (iter.hasNext()) {
	        Map.Entry<String,Double> pairs = (Map.Entry<String,Double>)iter.next();
	        String variable = pairs.getKey();
	        Double value = pairs.getValue();
	        String[] temp = {"" + value};
	        formulaHM.put(variable,temp);
	    }
    } else {
    	//insert code for retrieving values from processediting
    	formulaHM = (Map<String,String[]>) session.getAttribute("editHM");
    	editMsg = (ArrayList<String>) session.getAttribute("editMsg");
        session.removeAttribute("editHM");
        session.removeAttribute("editMsg");
    }
  	%>

  	<div class="header">Edit Formula</div>
    <div class="container theme-showcase" role="main">

      <%--<h2 class="heading">Edit Formula</h2><p>--%>

  

      
      <form class="form-horizontal" role="form" method="post" action="processedit">
      
      <div class="form-group">
	  	<button type="submit" class="btn btn-primary">Save Changes</button>
	  	<% if (editMsg!=null) { %>
	  		<p>
				<% for (String msg: editMsg) { %>
        			<font color="maroon"><label class="temp"><%=msg %></font></label><br />
        		<% } %>
				</p>
        	<% } %>
	  </div>
     	 
      <div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Ratios
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
		      <div class="panel-body">
      
				  <div class="form-group">
				    <label for="L-W-ratio" class="col-sm-2 control-label">L-W-ratio</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="L-W-ratio" name="L-W-ratio" value="<%=formulaHM.get("L-W-ratio")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WindowRatio" class="col-sm-2 control-label">Window ratio</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WindowRatio" name="WindowRatio" value="<%=formulaHM.get("WindowRatio")[0] %>" required>
				    </div>
				  </div>

		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Type specific parameters
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
				<table class="table table-hover">
			        <thead>
			          <tr>
			            <th></th>
			            <th></th>
			            <th></th>
			            <th></th>
			          </tr>
			        </thead>
			        <tbody>
			        
			          <tr>
			            <td>Office</td>
			            <td><input type="text" class="form-control" id="Office0" name="Office0" value="<%=formulaHM.get("Office0")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="Office1" name="Office1" value="<%=formulaHM.get("Office1")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="Office2" name="Office2" value="<%=formulaHM.get("Office2")[0] %>" required></td>
			          </tr>
			          <tr>
			            <td>Warehouse ground to roof</td>
			            <td><input type="text" class="form-control" id="WarehouseGroundToRoof0" name="WarehouseGroundToRoof0" value="<%=formulaHM.get("WarehouseGroundToRoof0")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseGroundToRoof1" name="WarehouseGroundToRoof1" value="<%=formulaHM.get("WarehouseGroundToRoof1")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseGroundToRoof2" name="WarehouseGroundToRoof2" value="<%=formulaHM.get("WarehouseGroundToRoof2")[0] %>" required></td>
			          </tr>
			          <tr>
			            <td>Warehouse mezzanine</td>
			            <td><input type="text" class="form-control" id="WarehouseMezzanine0" name="WarehouseMezzanine0" value="<%=formulaHM.get("WarehouseMezzanine0")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseMezzanine1" name="WarehouseMezzanine1" value="<%=formulaHM.get("WarehouseMezzanine1")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseMezzanine2" name="WarehouseMezzanine2" value="<%=formulaHM.get("WarehouseMezzanine2")[0] %>" required></td>
			          </tr>
			          <tr>
			            <td>Warehouse value add</td>
			            <td><input type="text" class="form-control" id="WarehouseValueAdd0" name="WarehouseValueAdd0" value="<%=formulaHM.get("WarehouseValueAdd0")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseValueAdd1" name="WarehouseValueAdd1" value="<%=formulaHM.get("WarehouseValueAdd1")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WarehouseValueAdd2" name="WarehouseValueAdd2" value="<%=formulaHM.get("WarehouseValueAdd2")[0] %>" required></td>
			          </tr>
			        </tbody>
			      </table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		          Units and Efficiency
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse">
		      <div class="panel-body">
		      
				<div class="form-group">
				    <label for="RoofU" class="col-sm-2 control-label">Roof u (W/m2K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="RoofU" name="RoofU" value="<%=formulaHM.get("RoofU")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WallU" class="col-sm-2 control-label">Wall u (W/m2K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WallU" name="WallU" value="<%=formulaHM.get("WallU")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="FloorU" class="col-sm-2 control-label">Floor u (W/m2K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="FloorU" name="FloorU" value="<%=formulaHM.get("FloorU")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WindowsU" class="col-sm-2 control-label">Windows u (W/m2K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WindowsU" name="WindowsU" value="<%=formulaHM.get("WindowsU")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="OfficeAirChanges" class="col-sm-2 control-label">Office air changes per hour</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="OfficeAirChanges" name="OfficeAirChanges" value="<%=formulaHM.get("OfficeAirChanges")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WarehouseAirChanges" class="col-sm-2 control-label">Warehouse air changes per hour</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WarehouseAirChanges" name="WarehouseAirChanges" value="<%=formulaHM.get("WarehouseAirChanges")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="OfficeRadiatorEfficiency" class="col-sm-2 control-label">Office radiator efficiency</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="OfficeRadiatorEfficiency" name="OfficeRadiatorEfficiency" value="<%=formulaHM.get("OfficeRadiatorEfficiency")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WarehouseBurnerEfficiency" class="col-sm-2 control-label">Warehouse burner efficiency</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WarehouseBurnerEfficiency" name="WarehouseBurnerEfficiency" value="<%=formulaHM.get("WarehouseBurnerEfficiency")[0] %>" required>
				    </div>
				  </div>
				  
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
		          Power Consumption
		        </a>
		      </h4>
		    </div>
		    <div id="collapseFour" class="panel-collapse collapse">
		      <div class="panel-body">
					
				<table class="table table-hover">
			        <thead>
			          <tr>
			            <th>Power Consumption/ Height</th>
			            <th>3</th>
			            <th>5</th>
			            <th>7</th>
			            <th>9</th>
			            <th>11</th>
			            <th>13</th>
			            <th>15</th>
			            <th>17</th>
			            <th>19</th>
			            <th>21</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			          <tr>
			            <td>Open Area</td>
			            <td><input type="text" class="form-control" id="OpenArea3" name="OpenArea3" value="<%=formulaHM.get("OpenArea3")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea5" name="OpenArea5" value="<%=formulaHM.get("OpenArea5")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea7" name="OpenArea7" value="<%=formulaHM.get("OpenArea7")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea9" name="OpenArea9" value="<%=formulaHM.get("OpenArea9")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea11" name="OpenArea11" value="<%=formulaHM.get("OpenArea11")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea13" name="OpenArea13" value="<%=formulaHM.get("OpenArea13")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea15" name="OpenArea15" value="<%=formulaHM.get("OpenArea15")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea17" name="OpenArea17" value="<%=formulaHM.get("OpenArea17")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea19" name="OpenArea19" value="<%=formulaHM.get("OpenArea19")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="OpenArea21" name="OpenArea21" value="<%=formulaHM.get("OpenArea21")[0] %>" required></td>
			          </tr>
			          <tr>
			            <td>Wide Area</td>
			            <td><input type="text" class="form-control" id="WideAisle3" name="WideAisle3" value="<%=formulaHM.get("WideAisle3")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle5" name="WideAisle5" value="<%=formulaHM.get("WideAisle5")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle7" name="WideAisle7" value="<%=formulaHM.get("WideAisle7")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle9" name="WideAisle9" value="<%=formulaHM.get("WideAisle9")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle11" name="WideAisle11" value="<%=formulaHM.get("WideAisle11")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle13" name="WideAisle13" value="<%=formulaHM.get("WideAisle13")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle15" name="WideAisle15" value="<%=formulaHM.get("WideAisle15")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle17" name="WideAisle17" value="<%=formulaHM.get("WideAisle17")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle19" name="WideAisle19" value="<%=formulaHM.get("WideAisle19")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="WideAisle21" name="WideAisle21" value="<%=formulaHM.get("WideAisle21")[0] %>" required></td>
			          </tr>
			          <tr>
			            <td>Narrow Aisle</td>
			            <td><input type="text" class="form-control" id="NarrowAisle3" name="NarrowAisle3" value="<%=formulaHM.get("NarrowAisle3")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle5" name="NarrowAisle5" value="<%=formulaHM.get("NarrowAisle5")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle7" name="NarrowAisle7" value="<%=formulaHM.get("NarrowAisle7")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle9" name="NarrowAisle9" value="<%=formulaHM.get("NarrowAisle9")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle11" name="NarrowAisle11" value="<%=formulaHM.get("NarrowAisle11")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle13" name="NarrowAisle13" value="<%=formulaHM.get("NarrowAisle13")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle15" name="NarrowAisle15" value="<%=formulaHM.get("NarrowAisle15")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle17" name="NarrowAisle17" value="<%=formulaHM.get("NarrowAisle17")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle19" name="NarrowAisle19" value="<%=formulaHM.get("NarrowAisle19")[0] %>" required></td>
			            <td><input type="text" class="form-control" id="NarrowAisle21" name="NarrowAisle21" value="<%=formulaHM.get("NarrowAisle21")[0] %>" required></td>
			          </tr>
					          
			        </tbody>
			      </table>
				  
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
		          External lighting
		        </a>
		      </h4>
		    </div>
		    <div id="collapseFive" class="panel-collapse collapse">
		      <div class="panel-body">
		      
				<div class="form-group">
				    <label for="ExtLight" class="col-sm-2 control-label">Ext light (W/m2K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="ExtLight" name="ExtLight" value="<%=formulaHM.get("ExtLight")[0] %>" required>
				    </div>
				  </div>
				  
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseSix">
		          Water Req
		        </a>
		      </h4>
		    </div>
		    <div id="collapseSix" class="panel-collapse collapse">
		      <div class="panel-body">
		      
				<div class="form-group">
				    <label for="OfficeWaterReq" class="col-sm-2 control-label">Office water req (L/m2/hr)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="OfficeWaterReq" name="OfficeWaterReq" value="<%=formulaHM.get("OfficeWaterReq")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WarehouseGroundToRoofWaterReq" class="col-sm-2 control-label">Warehouse ground to roof (L/m2/hr)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WarehouseGroundToRoofWaterReq" name="WarehouseGroundToRoofWaterReq" value="<%=formulaHM.get("WarehouseGroundToRoofWaterReq")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WarehouseMezzanineWaterReq" class="col-sm-2 control-label">Warehouse mezzanine (L/m2/hr)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WarehouseMezzanineWaterReq" name="WarehouseMezzanineWaterReq" value="<%=formulaHM.get("WarehouseMezzanineWaterReq")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="WarehouseValueAddWaterReq" class="col-sm-2 control-label">Warehouse value add (L/m2/hr)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="WarehouseValueAddWaterReq" name="WarehouseValueAddWaterReq" value="<%=formulaHM.get("WarehouseValueAddWaterReq")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="TempRise" class="col-sm-2 control-label">Temp rise (C)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="TempRise" name="TempRise" value="<%=formulaHM.get("TempRise")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="BoilerSysEfficiency" class="col-sm-2 control-label">Boiler sys efficiency</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="BoilerSysEfficiency" name="BoilerSysEfficiency" value="<%=formulaHM.get("BoilerSysEfficiency")[0] %>" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="SpecificHeatOfWater" class="col-sm-2 control-label">Specific heat of water (MJ/L/K)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="SpecificHeatOfWater" name="SpecificHeatOfWater" value="<%=formulaHM.get("SpecificHeatOfWater")[0] %>" required>
				    </div>
				  </div>
				  
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">
		          Conversion Factor
		        </a>
		      </h4>
		    </div>
		    <div id="collapseSeven" class="panel-collapse collapse">
		      <div class="panel-body">
		      
				<div class="form-group">
				    <label for="ConversionFactor" class="col-sm-2 control-label">Conversion factor (MHE)</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="ConversionFactor" name="ConversionFactor" value="<%=formulaHM.get("ConversionFactor")[0] %>" required>
				    </div>
				  </div>
				  
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#collapseEight">
		          Energy Consumption
		        </a>
		      </h4>
		    </div>
		    <div id="collapseEight" class="panel-collapse collapse">
		      <div class="panel-body">
		      
				<div class="form-group">
				    <label for="EnergyConsumption" class="col-sm-2 control-label">Energy consumption per person</label>
				    <div class="col-sm-3">
				      <input type="text" class="form-control" id="EnergyConsumption" name="EnergyConsumption" value="<%=formulaHM.get("EnergyConsumption")[0] %>" required>
				    </div>
				  </div>
				  
		      </div>
		    </div>
		  </div>
		  
		</div>
		
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

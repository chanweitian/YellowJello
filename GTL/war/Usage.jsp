<fieldset>
	<legend>Usage <%=previousYear%></legend>
	
	<div id="wrapper"> 
      <div id="content">  
          <div class="demo">
            <br>
            <h4 class="expand">Electricity</h4>
            <div class="collapse">
                
                <table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_electricity_use">How many kWh of electricity did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_electricity_use" style="width: 200px;"></input>&nbsp;&nbsp;kWh</td>
                	<td>
                		<label for="usage_electricity_use_source">Data source</label>
						<select name="usage_electricity_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_electricty_cost">How much did this electricity cost?</label>
				<input type="text" name="usage_electricty_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro</td>
                
                <table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_renew_electricity_use">How many kWh of renewable electricity did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_renew_electricity_use" style="width: 200px;"></input>&nbsp;&nbsp;kWh</td>
                	<td>
                		<label for="usage_renew_electricity_use_source">Data source</label>
						<select name="usage_renew_electricity_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_renew_electricty_cost">How much did this renewable electricity cost?</label>
				<input type="text" name="usage_renew_electricty_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro</td>
                
				
				
				<br><br>	
            </div>
            <h4 class="expand">Other Fuels</h4>
            <div class="collapse">
                
                <table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_nat_gas_use">How many kWh of Natural Gas did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_nat_gas_use" style="width: 200px;"></input>&nbsp;&nbsp;kWh</td>
                	<td>
                		<label for="usage_nat_gas_use_source">Data source</label>
						<select name="usage_nat_gas_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_nat_gas_cost">How much did this Natural Gas cost?</label>
				<input type="text" name="usage_nat_gas_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
				
				<table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_fuel_oil_use">How many litres of Fuel Oil did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_fuel_oil_use" style="width: 200px;"></input>&nbsp;&nbsp;litres</td>
                	<td>
                		<label for="usage_fuel_oil_use_source">Data source</label>
						<select name="usage_fuel_oil_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_fuel_oil_cost">How much did this Fuel Oil cost?</label>
				<input type="text" name="usage_fuel_oil_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
				
				<table>
					<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_diesel_use">How many litres of diesel did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_diesel_use" style="width: 200px;"></input>&nbsp;&nbsp;litres</td>
                	<td>
                		<label for="usage_diesel_use_source">Data source</label>
						<select name="usage_diesel_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_diesel_cost">How much did this diesel cost?</label>
				<input type="text" name="usage_diesel_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
				
				<table>
					<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_lpg_use">How many litres of LPG (Heating use only) did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_lpg_use" style="width: 200px;"></input>&nbsp;&nbsp;litres</td>
                	<td>
                		<label for="usage_lpg_use_source">Data source</label>
						<select name="usage_lpg_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_lpg_cost">How much did this LPG cost?</label>
				<input type="text" name="usage_lpg_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
				
				<table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_district_heating_use">How many kWh of District Heating did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_district_heating_use" style="width: 200px;"></input>&nbsp;&nbsp;kWh</td>
                	<td>
                		<label for="usage_district_heating_use_source">Data source</label>
						<select name="usage_district_heating_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_district_heating_cost">How much did this heating cost?</label>
				<input type="text" name="usage_district_heating_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
                
                <table>
                	<tr style="vertical-align:top;">
                	<td style="width:82%;">
                		<label for="usage_district_cooling_use">How many kWh of District Cooling did your site use in <%=previousYear%>?</label>
						<input type="text" name="usage_district_cooling_use" style="width: 200px;"></input>&nbsp;&nbsp;kWh</td>
                	<td>
                		<label for="usage_district_cooling_use_source">Data source</label>
						<select name="usage_district_cooling_use_source">
							<option value="invoiced">Invoiced</option>
							<option value="metered">Metered Data</option>
							<option value="estimated">Estimated</option>
						</select>
                	</td>
                	</tr>
                </table>
                <label for="usage_district_cooling_cost">How much did this cooling cost?</label>
				<input type="text" name="usage_district_cooling_cost" style="width: 200px;"></input>&nbsp;&nbsp;Euro
                
                <br><br>
            </div>
        </div>
    </div>
	
</fieldset>

 
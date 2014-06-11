<fieldset>
	<legend>Site Definition</legend>
	
	<input type="button" id="add_building" value="Add another building" class="button" />
	<input type="button" id="delete_building" value="Delete last building" class="button" disabled/>
	<br><br>
		<div class="building-div" id="building1">
			<div class="building-div-border" id="repeat">
				<table>
					<tr>
						<td style="width:350px;">
							<label for="numOfBuildings">Building Name</label>
							<input type="text"   name="1a" style="width: 300px;"/>
						</td>
						<td style="vertical-align:bottom;">
							<input type="button" id="add_zone" value="Add another zone" class="button" />
						</td>
					</tr>
				</table>
				<table  class="building-table">					
					<tr>
						<th>Zone Name</th>
						<th>Zone Activity</th>
						<th>Zone Heating or Cooling</th>
						<th>Min Temp. Set-point (&deg;C)</th>
						<th>Max Temp. Set-point (&deg;C)</th>
						<th>Months of Zone Operation in <%=previousYear%></th> 
					</tr>
					<tr>
						<td style="width:165px"><input type="text"   name="1a" style="width: 140px;"/></td>
						<td style="width:200px">
							<select>
								<option value="offices">Offices</option>
								<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
								<option value="wh_mezzanine">Warehouse - Mezzanine</option>
								<option value="wh_value_add">Warehouse - Value add</option>
							</select>
						</td>
						<td><input type="text"   name="3a" style="width: 120px;"/></td>
						<td><input type="text"   name="4a" style="width: 120px;"/></td>
						<td><input type="text"   name="5a" style="width: 120px;"/></td>
						<td style="width:12%">
							<select>
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</td>
					</tr>                  
					<tr>
						<td style="width:165px"><input type="text"   name="1b" style="width: 140px;"/></td>
						<td style="width:200px">
							<select>
								<option value="offices">Offices</option>
								<option value="wh_ground_to_roof">Warehouse - Ground to roof</option>
								<option value="wh_mezzanine">Warehouse - Mezzanine</option>
								<option value="wh_value_add">Warehouse - Value add</option>
							</select>
						</td>
						<td><input type="text"   name="3b" style="width: 120px;"/></td>
						<td><input type="text"   name="4b" style="width: 120px;"/></td>
						<td><input type="text"   name="5b" style="width: 120px;"/></td>
						<td style="width:12%">
							<select>
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</td>
					</tr>
				</table>
			</div>
			<br>
			
		</div>
		<br><br>
</fieldset>


 
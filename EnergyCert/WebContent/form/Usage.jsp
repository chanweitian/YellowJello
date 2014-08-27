<%
String where_usage = "questionnaire_id = \'" + quest_id + "\'";
ResultSet rs_usage = SQLManager.retrieveRecords("questionnaire", where_usage);

String usage_electricity_use = "";
String usage_electricity_use_source = "";
String usage_electricty_cost = "";
String usage_renew_electricity_use = "";
String usage_renew_electricity_use_source = "";
String usage_renew_electricty_cost = "";
String usage_nat_gas_use = "";
String usage_nat_gas_use_source = "";
String usage_nat_gas_cost = "";
String usage_fuel_oil_use = "";
String usage_fuel_oil_use_source = "";
String usage_fuel_oil_cost = "";
String usage_diesel_use = "";
String usage_diesel_use_source = "";
String usage_diesel_cost = "";
String usage_lpg_use = "";
String usage_lpg_use_source = "";
String usage_lpg_cost = "";
String usage_district_heating_use = "";
String usage_district_heating_use_source = "";
String usage_district_heating_cost = "";
String usage_district_cooling_use = "";
String usage_district_cooling_use_source = "";
String usage_district_cooling_cost = "";

while (rs_usage.next()) {
	usage_electricity_use = rs_usage.getString("usage_electricity_use");
	usage_electricity_use_source = rs_usage.getString("usage_electricity_use_source");
	usage_electricty_cost = rs_usage.getString("usage_electricty_cost");
	usage_renew_electricity_use = rs_usage.getString("usage_renew_electricity_use");
	usage_renew_electricity_use_source = rs_usage.getString("usage_renew_electricity_use_source");
	usage_renew_electricty_cost = rs_usage.getString("usage_renew_electricty_cost");
	usage_nat_gas_use = rs_usage.getString("usage_nat_gas_use");
	usage_nat_gas_use_source = rs_usage.getString("usage_nat_gas_use_source");
	usage_nat_gas_cost = rs_usage.getString("usage_nat_gas_cost");
	usage_fuel_oil_use = rs_usage.getString("usage_fuel_oil_use");
	usage_fuel_oil_use_source = rs_usage.getString("usage_fuel_oil_use_source");
	usage_fuel_oil_cost = rs_usage.getString("usage_fuel_oil_cost");
	usage_diesel_use = rs_usage.getString("usage_diesel_use");
	usage_diesel_use_source = rs_usage.getString("usage_diesel_use_source");
	usage_diesel_cost = rs_usage.getString("usage_diesel_cost");
	usage_lpg_use = rs_usage.getString("usage_lpg_use");
	usage_lpg_use_source = rs_usage.getString("usage_lpg_use_source");
	usage_lpg_cost = rs_usage.getString("usage_lpg_cost");
	usage_district_heating_use = rs_usage.getString("usage_district_heating_use");
	usage_district_heating_use_source = rs_usage.getString("usage_district_heating_use_source");
	usage_district_heating_cost = rs_usage.getString("usage_district_heating_cost");
	usage_district_cooling_use = rs_usage.getString("usage_district_cooling_use");
	usage_district_cooling_use_source = rs_usage.getString("usage_district_cooling_use_source");
	usage_district_cooling_cost = rs_usage.getString("usage_district_cooling_cost");
}
%>
<div class="section">
	<div class="container">
		<div class="row">
			<!-- form: -->
			<section>
				<div>
					<div class="page-header">
						<img src="../icons/icon_usage.png" height="5%" width="5%">&nbsp;&nbsp;Usage <%=previousYear%>
					</div>
					<div id="wrapper">
						<div id="content">
						<h5><font color="red">* Required</font></h5>
<<<<<<< HEAD
=======
						
>>>>>>> FETCH_HEAD
							<input type="hidden" class="form-control" name="site_usage" value="exists"></input>
							<div class="demo">
								<br>
								<h4 class="expand">Electricity</h4>
								<div class="collapse">

									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_electricity_use">How many kWh of electricity did your site use in <%=previousYear%>? <font color="red">*</font></label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_required" name="usage_electricity_use" style="width: 200px;" value="<%=usage_electricity_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
													<label class="col-lg-6 control-label" for="usage_electricity_use_source">Data source</label>
													<div class="col-lg-5">
													<select class="form-control" name="usage_electricity_use_source" style="width: 150px;">
														<% if (usage_electricity_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_electricity_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_electricity_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_electricty_cost">How much did this electricity cost? <font color="red">* </font></label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_required" name="usage_electricty_cost" style="width: 200px;" value="<%=usage_electricty_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_renew_electricity_use">How many kWh of renewable electricity did your site use in <%=previousYear%>?
												</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_renew_electricity_use" style="width: 200px;" value="<%=usage_renew_electricity_use%>"></input>
												</div>
												</div>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_renew_electricity_use_source">Data source</label>
												<div class="col-lg-5">
												<select class="form-control" name="usage_renew_electricity_use_source" style="width: 150px;">
														<% if (usage_renew_electricity_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_renew_electricity_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_renew_electricity_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
												</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_renew_electricty_cost">How much did this renewable electricity cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_renew_electricty_cost" style="width: 200px;" value="<%=usage_renew_electricty_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>

									<br>
									<br>
								</div>
								<h4 class="expand">Other Fuels</h4>
								<div class="collapse">

									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_nat_gas_use">How many kWh of Natural Gas did your site use in <%=previousYear%>? <font color="red">* </font></label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_required" name="usage_nat_gas_use" style="width: 200px;" value="<%=usage_nat_gas_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
													<label class="col-lg-6 control-label" for="usage_nat_gas_use_source">Data source</label>
													<div class="col-lg-5">
													<select class="form-control"
														name="usage_nat_gas_use_source" style="width: 150px;">
														<% if (usage_nat_gas_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_nat_gas_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_nat_gas_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
													</div>
												</div>

											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_nat_gas_cost">How much did this Natural Gas cost? <font color="red">* </font></label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_required" name="usage_nat_gas_cost" style="width: 200px;" value="<%=usage_nat_gas_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_fuel_oil_use">How many litres of Fuel Oil did your site use in <%=previousYear%>?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_fuel_oil_use" style="width: 200px;" value="<%=usage_fuel_oil_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_fuel_oil_use_source">Data source</label>
												<div class="col-lg-5">
												<select class="form-control"
													name="usage_fuel_oil_use_source" style="width: 150px;">
														<% if (usage_fuel_oil_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_fuel_oil_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_fuel_oil_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
												</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_fuel_oil_cost">How much did this Fuel Oil cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_fuel_oil_cost" style="width: 200px;" value="<%=usage_fuel_oil_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_diesel_use">How many litres of diesel did your site use in <%=previousYear%>?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_diesel_use" style="width: 200px;" value="<%=usage_diesel_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_diesel_use_source">Data source</label>
												<div class="col-lg-5">
													<select class="form-control" name="usage_diesel_use_source" style="width: 150px;">
														<% if (usage_diesel_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_diesel_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_diesel_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_diesel_cost">How much did this diesel cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_diesel_cost" style="width: 200px;" value="<%=usage_diesel_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_lpg_use">How many litres of LPG (Heating use only) did your site use in <%=previousYear%>?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_lpg_use" style="width: 200px;" value="<%=usage_lpg_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_lpg_use_source">Data source</label>
												<div class="col-lg-5">
													<select class="form-control" name="usage_lpg_use_source"
														style="width: 150px;">
														<% if (usage_lpg_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_lpg_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_lpg_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_lpg_cost">How much did this LPG cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_lpg_cost" style="width: 200px;" value="<%=usage_lpg_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_heating_use">How many kWh of District Heating did your site use in <%=previousYear%>?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_district_heating_use" style="width: 200px;" value="<%=usage_district_heating_use%>"></input>
												</div>
												</div>
											</td>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_heating_use_source">Data source</label>
												<div class="col-lg-5">
													<select class="form-control" name="usage_district_heating_use_source" style="width: 150px;">
														<% if (usage_district_heating_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_district_heating_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_district_heating_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_heating_cost">How much did this heating cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_district_heating_cost" style="width: 200px;" value="<%=usage_district_heating_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>
									<hr>
									<table>
										<tr style="vertical-align: top;">
											<td style="width: 50%;">
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_cooling_use">How many kWh of District Cooling did your site use in <%=previousYear%>?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_district_cooling_use" style="width: 200px;" value="<%=usage_district_cooling_use%>"></input>
												</div>
												</div>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_cooling_use_source">Data source</label>
												<div class="col-lg-5">
													<select class="form-control" name="usage_district_cooling_use_source" style="width: 150px;">
														<% if (usage_district_cooling_use_source.equals("Invoiced")) { %>
															<option value="Invoiced" selected>Invoiced</option>
														<% } else { %>
															<option value="Invoiced">Invoiced</option>
														<% } %>
														<% if (usage_district_cooling_use_source.equals("Metered Data")) { %>
															<option value="Metered Data" selected>Metered Data</option>
														<% } else { %>	
															<option value="Metered Data">Metered Data</option>
														<% } %>
														<% if (usage_district_cooling_use_source.equals("Estimated")) { %>
															<option value="Estimated" selected>Estimated</option>
														<% } else { %>
															<option value="Estimated">Estimated</option>
														<% } %>
													</select>
												</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
												<label class="col-lg-6 control-label" for="usage_district_cooling_cost">How much did this cooling cost?</label>
												<div class="col-lg-6">
													<input type="text" class="form-control" id="electricity_usage_optional" name="usage_district_cooling_cost" style="width: 200px;" value="<%=usage_district_cooling_cost%>"></input>&nbsp;&nbsp;Euro
												</div>
												</div>
											</td>
											<td></td>
										</tr>
									</table>

									<br><br>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<div class="btn-group" style="margin-left:77%">
		<button class="btn" id="prevtab" type="button" onclick="prev_tab();">Previous</button>
    	<button class="btn" id="nexttab" type="button" onclick="next_tab();">Next</button>
    	
	</div>
</div>

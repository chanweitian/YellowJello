<%
String zone_id_wva = (String) session.getAttribute("zone_id");
String where_wva = "zone_id = \'" + zone_id_wva + "\'";
RetrievedObject ro_wva = SQLManager.retrieveRecords("warehouse_value_add_form", where_wva);
ResultSet rs_wva = ro_wva.getResultSet();
while (rs_wva.next()) {
%>
<div class="page-header">
	<br><img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=rs_wva.getString("building_name")%>_<%=rs_wva.getString("zone_name")%>:&nbsp;Warehouse - Value add
</div>
<div class="past_quest_table">
	<div class="col8">How many hours per day is this zone typically operational for?</div>
</div>
<div class="past_quest_table">
	<div class="col6">Monday</div>
	<div class="col6">Tuesday</div>
	<div class="col6">Wednesday</div>
	<div class="col6">Thursday</div>
	<div class="col6">Friday</div>
	<div class="col6">Saturday</div>
	<div class="col6">Sunday</div>
</div>
<div class="past_quest_table">
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_mon")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_tues")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_wed")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_thurs")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_fri")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_sat")%></div>
	<div class="col7"><%=rs_wva.getString("zone_operationalhrs_sun")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col1">What is the total floor area of this zone?</div>
	<div class="col2"><%=rs_wva.getString("zone_floorarea")%>&nbsp;&nbsp;m<sup>2</sup></div>
	<div class="col3"></div>
	<div class="col4">How many floors does this zone occupy?</div>
	<div class="col5"><%=rs_wva.getString("zone_numoffloors")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col8">How many work stations are in this zone and what are their power consumption? (Modify default work station power consumption if actual values are known)</div>
</div>
<div class="past_quest_table_1">
	<div class="col13"></div>
	<div class="col14">Number</div>
	<div class="col14">Power (watts) per work station</div>
</div>
<div class="past_quest_table_1">
	<div class="col13">Manual</div>
	<div class="col15"><%=rs_wva.getString("zone_numofmanualws")%></div>
	<div class="col15"><%=rs_wva.getString("zone_manualpower")%></div>
</div>
<div class="past_quest_table_1">
	<div class="col13">Light</div>
	<div class="col15"><%=rs_wva.getString("zone_numoflightws")%></div>
	<div class="col15"><%=rs_wva.getString("zone_lightpower")%></div>
</div>
<div class="past_quest_table_1">
	<div class="col13">Heavy</div>
	<div class="col15"><%=rs_wva.getString("zone_numofheavyws")%></div>
	<div class="col15"><%=rs_wva.getString("zone_heavypower")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col1">What is the main type of warehouse lighting installed?</div>
	<div class="col2"><%=rs_wva.getString("zone_lighting")%>&nbsp;&nbsp;m<sup>2</sup></div>
	<div class="col3"></div>
	<div class="col4">If fluoresent what are the main type of tubes are installed?</div>
	<div class="col5"><%=rs_wva.getString("zone_fluorescent_tube")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">If T8 tubes are used, what type of ballast is installed?</div>
	<div class="col2"><%=rs_wva.getString("zone_t8_ballasttype")%>&nbsp;&nbsp;m<sup>2</sup></div>
	<div class="col3"></div>
	<div class="col4">What type of control is used on this zone's main warehouse lighting system?</div>
	<div class="col5"><%=rs_wva.getString("zone_lightcontroltype")%></div>
</div>
<%
}
ro_wva.close();
%>
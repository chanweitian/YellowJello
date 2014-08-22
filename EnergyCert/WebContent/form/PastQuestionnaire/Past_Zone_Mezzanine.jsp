<%
String zone_id_mez = (String) session.getAttribute("zone_id");
String where_mez = "zone_id = \'" + zone_id_mez + "\'";
ResultSet rs_mez = SQLManager.retrieveRecords("mezzanine_form", where_mez);
while (rs_mez.next()) {
%>
<div class="page-header">
	<br><img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=rs_mez.getString("building_name")%>_<%=rs_mez.getString("zone_name")%>:&nbsp;Warehouse - Mezzanine
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
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_mon")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_tues")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_wed")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_thurs")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_fri")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_sat")%></div>
	<div class="col7"><%=rs_mez.getString("zone_operationalhrs_sun")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col1">What is the total floor area of this zone?</div>
	<div class="col2"><%=rs_mez.getString("zone_floorarea")%>&nbsp;&nbsp;m<sup>2</sup></div>
	<div class="col3"></div>
	<div class="col4">How many floors does this zone occupy?</div>
	<div class="col5"><%=rs_mez.getString("zone_numoffloors")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col8">What proportion of this zone is: (%)</div>
</div>
<div class="past_quest_table">
	<div class="col9">Narrow Aisle Racking</div>
	<div class="col9">Wide Aisle Racking</div>
	<div class="col9">Open Area (No Racking)</div>
</div>
<div class="past_quest_table">
	<div class="col10"><%=rs_mez.getString("zone_zoneprop_narrow")%></div>
	<div class="col10"><%=rs_mez.getString("zone_zoneprop_wide")%></div>
	<div class="col10"><%=rs_mez.getString("zone_zoneprop_open")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">What is the main type of warehouse lighting installed?</div>
	<div class="col2"><%=rs_mez.getString("zone_lighting")%></div>
	<div class="col3"></div>
	<div class="col4">If fluoresent what are the main type of tubes are installed?</div>
	<div class="col5"><%=rs_mez.getString("zone_fluorescent_tube")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">If T8 tubes are used, what type of ballast is installed?</div>
	<div class="col2"><%=rs_mez.getString("zone_t8_ballasttype")%></div>
	<div class="col3"></div>
	<div class="col4">What type of control is used on this zone's main warehouse lighting system?</div>
	<div class="col5"><%=rs_mez.getString("zone_lightcontroltype")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">Are goods lifts (elevators) used in the mezzaine zone?</div>
	<div class="col2"><%=rs_mez.getString("zone_hasgoodslift")%></div>
</div>
<%
}
%>
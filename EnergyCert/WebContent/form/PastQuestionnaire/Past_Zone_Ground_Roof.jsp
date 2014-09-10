<%
String zone_id_gtr = (String) session.getAttribute("zone_id");
String where_gtr = "zone_id = \'" + zone_id_gtr + "\'";
RetrievedObject ro_gtr = SQLManager.retrieveRecords("ground_to_roof_form", where_gtr);
ResultSet rs_gtr = ro_gtr.getResultSet();
while (rs_gtr.next()) {
%>
<div class="past_quest_table">
	<div class="col18">
		<div class="page-header">
			<br><img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=rs_gtr.getString("building_name")%>_<%=rs_gtr.getString("zone_name")%>:&nbsp;Warehouse - Ground to roof
		</div>
	</div>
	<div class="col18">
		<div class="past_quest_table">
			<div class="col16">Building Name</div>
			<div class="col17"><%=rs_gtr.getString("building_name")%></div>
		</div>
		<div class="past_quest_table">
			<div class="col16">Zone Name</div>
			<div class="col17"><%=rs_gtr.getString("zone_name")%></div>
		</div>
	</div>
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
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_mon")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_tues")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_wed")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_thurs")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_fri")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_sat")%></div>
	<div class="col7"><%=rs_gtr.getString("zone_operationalhrs_sun")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col1">What is the total floor area of this zone?</div>
	<div class="col2"><%=rs_gtr.getString("zone_floorarea")%>&nbsp;&nbsp;m<sup>2</sup></div>
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
	<div class="col10"><%=rs_gtr.getString("zone_zoneprop_narrow")%></div>
	<div class="col10"><%=rs_gtr.getString("zone_zoneprop_wide")%></div>
	<div class="col10"><%=rs_gtr.getString("zone_zoneprop_open")%></div>
</div>
<div class="past_quest_table">	
	<div class="col1">What is the height from the ground to the top of the external wall?</div>
	<div class="col2"><%=rs_gtr.getString("zone_height")%>&nbsp;&nbsp;m</div>
	<div class="col3"></div>
	<div class="col4">Does this zone have a sorting machine or conveyor system?</div>
	<div class="col5"><%=rs_gtr.getString("zone_sorting_conveyor")%></div>
</div>
<div class="past_quest_table">	
	<div class="col1">If yes, how many meters of motor driven conveyors are installed?</div>
	<div class="col2"><%=rs_gtr.getString("zone_ismotordrivenconveyor")%></div>
	<div class="col3"></div>
	<div class="col4">How many hours per week do these conveyors run?</div>
	<div class="col5"><%=rs_gtr.getString("zone_conveyor_hours")%>&nbsp;&nbsp;hours</div>
</div>
<div class="past_quest_table">	
	<div class="col1">Are conveyors turned off when no goods are in the system?</div>
	<div class="col2"><%=rs_gtr.getString("zone_conveyor_isturnedoff")%></div>
	<div class="col3"></div>
	<div class="col4">Does this zone have warehouse roof skylights?</div>
	<div class="col5"><%=rs_gtr.getString("zone_hasskylights")%></div>
</div>
<div class="past_quest_table">	
	<div class="col1">Do the skylights provide sufficient daylight to light this warehouse zone?</div>
	<div class="col2"><%=rs_gtr.getString("zone_isskylightsufficient")%></div>
	<div class="col3"></div>
	<div class="col4">Are the skylights regulary cleaned?</div>
	<div class="col5"><%=rs_gtr.getString("zone_isskylightcleaned")%></div>
</div>
<div class="past_quest_table">	
	<div class="col1">What is the main type of lighting installed?</div>
	<div class="col2"><%=rs_gtr.getString("zone_lighting")%></div>
	<div class="col3"></div>
	<div class="col4">If fluoresent what are the main type of tubes are installed?</div>
	<div class="col5"><%=rs_gtr.getString("zone_fluorescent_tube")%></div>
</div>
<div class="past_quest_table">	
	<div class="col11">If T8 tubes are used, what type of ballast is installed?</div>
	<div class="col12"><%=rs_gtr.getString("zone_t8_ballasttype")%></div>
	<div class="col3"></div>
	<div class="col11">What is the power rating of each fitting in this zone's main warehouse lighting system?</div>
	<div class="col12"><%=rs_gtr.getString("zone_powerrating")%></div>
</div>
<div class="past_quest_table">	
	<div class="col11">Approximately how many lighting fittings make up this zone's main lighting system?</div>
	<div class="col12"><%=rs_gtr.getString("zone_numoflightings")%></div>
	<div class="col3"></div>
	<div class="col11">What type of control is used on this zone's main warehouse lighting system?</div>
	<div class="col12"><%=rs_gtr.getString("zone_lightcontroltype")%></div>
</div>
<div class="past_quest_table">	
	<div class="col1">If manual, are the lights turned off if there is natural daylight or during non-working time?</div>
	<div class="col2"><%=rs_gtr.getString("zone_ismanuallyturnedoff")%></div>
	<div class="col3"></div>
	<div class="col4">Is part or all of this zone heated with radiant heaters?</div>
	<div class="col5"><%=rs_gtr.getString("zone_hasradiantheaters")%></div>
</div>
<% 
} 
ro_gtr.close();
%>

<%
String zone_id_office = (String) session.getAttribute("zone_id");
String where_office = "zone_id = \'" + zone_id_office + "\'";
ResultSet rs_office = SQLManager.retrieveRecords("office_form", where_office);
while (rs_office.next()) {
%>
<div class="page-header">
	<br><img src="../icons/icon_zone.png" height="5%" width="5%">&nbsp;&nbsp;<%=rs_office.getString("building_name")%>_<%=rs_office.getString("zone_name")%>:&nbsp;Offices
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
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_mon")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_tues")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_wed")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_thurs")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_fri")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_sat")%></div>
	<div class="col7"><%=rs_office.getString("zone_operationalhrs_sun")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col1">What is the total floor area of this zone?</div>
	<div class="col2"><%=rs_office.getString("zone_floorarea")%>&nbsp;&nbsp;m<sup>2</sup></div>
	<div class="col3"></div>
	<div class="col4">How many floors does this zone occupy?</div>
	<div class="col5"><%=rs_office.getString("zone_numoffloors")%></div>
</div>
<div class="past_quest_table">
	<div class="col11">What is the average number of office employees during the typical working hours?</div>
	<div class="col12"><%=rs_office.getString("zone_aveemployees")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col8">How many and what type of office computers are used?</div>
</div>
<div class="past_quest_table">
	<div class="col9">Laptop</div>
	<div class="col9">Desktop with flat screen monitor</div>
	<div class="col9">Desktop with CRT monitor</div>
</div>
<div class="past_quest_table">
	<div class="col10"><%=rs_office.getString("zone_numoflaptops")%></div>
	<div class="col10"><%=rs_office.getString("zone_numofflatscreen")%></div>
	<div class="col10"><%=rs_office.getString("zone_numofCRTmonitor")%></div>
</div>
<hr>
<div class="past_quest_table">
	<div class="col11">Are all PCs and monitors always shutdown overnight?</div>
	<div class="col12"><%=rs_office.getString("zone_isalwaysshutdown")%></div>
	<div class="col3"></div>
	<div class="col11">Are power saving settings enabled, for example do PCs go to sleep mode if not used for a short time?</div>
	<div class="col12"><%=rs_office.getString("zone_ispowersavingmode")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">What is the main type of lighting installed?</div>
	<div class="col2"><%=rs_office.getString("zone_lighting")%></div>
	<div class="col3"></div>
	<div class="col4">If fluoresent what are the main type of tubes are installed?</div>
	<div class="col5"><%=rs_office.getString("zone_fluorescent_tube")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">If T8 tubes are used, what type of ballast is installed?</div>
	<div class="col2"><%=rs_office.getString("zone_t8_ballasttype")%></div>
	<div class="col3"></div>
	<div class="col4">What type of control is used on this zone's main warehouse lighting system?</div>
	<div class="col5"><%=rs_office.getString("zone_lightcontroltype")%></div>
</div>
<div class="past_quest_table">
	<div class="col1">If the office has external glazing is it?</div>
	<div class="col2"><%=rs_office.getString("zone_externalglazingtype")%></div>
	<div class="col3"></div>
</div>
<%
}
%>
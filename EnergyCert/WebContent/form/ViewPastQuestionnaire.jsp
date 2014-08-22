<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.ResultSet,utility.*" %>
<%@include file="../protectusers.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../header.jsp" %>

	<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>GTL Energy Certificate Questionnaire</title>
		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		
		<%-- JQuery script --%>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		
		<%-- Questionnaire validation --%>
		<link rel="stylesheet" href="../css/bootstrap.css"/>
		<link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>	
		<script type="text/javascript" src="../js/validation.js"></script>	
		
		<%-- This is for SiteInfo.jsp --%>
		<link href="../css/siteInfo.css" rel="stylesheet">
		<script type="text/javascript" src="../js/siteInfo.js"></script>	
		<script type="text/javascript" src="../js/expand.js"></script>	
			
		<%-- Questionnaire.jsp --%>
		<link href="../css/questionnaire.css" rel="stylesheet">
		<script type="text/javascript" src="../js/questionnaire.js"></script>
		
		<%-- This is for SiteDef.jsp --%>
		<script type="text/javascript" src="../js/siteDef.js"></script>
	
</head>
<body>
		  
  	<br><br>
  	<div class="main">
		<div class="header">
            View Past GTL Energy Certificate Questionnaires
        </div>
		<div style="width:50%;margin:0 auto;">
		<form action="PastQuestionnaire.jsp" id="main-questionnaire" method="post" class="form-horizontal">
			
			<% 
			String desc = (String) session.getAttribute("userdesc");
			String comp = (String) session.getAttribute("company");
			String type = (String) session.getAttribute("usertype");
			if (type.equals("Site")) {
				type = "site_info_name";
			} else if (type.equals("Country")) {
				type = "site_info_address_country";
			}

			String where = "company=\'"+ comp + "\' and " + type + "=\'" + desc + "\'";
			ResultSet rs = SQLManager.retrieveRecords("site", where); 
			%>
			
			<% String company = (String) session.getAttribute("company");
				int month = PeriodManager.getMonthInt(company);
				Calendar cal = Calendar.getInstance();
				cal.set(Calendar.MONTH,month);
				cal.set(Calendar.DATE,1);
				Calendar today = Calendar.getInstance();
				int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
				if (!today.before(cal)) {
					previousYear -= 1;
				}
				%>
			
			<div class="form-group">
				<label class="col-lg-3 control-label">Questionnaire ID</label>
				<div class="col-lg-5">
					<select class="form-control" name="quest_id" id="dropdown_required">
					<option value="">-- Select one --</option>
					<%
					while (rs.next()) {
						where = "site_id=\'" + rs.getString("site_id") + "\' and year<" + previousYear;
						ResultSet rs2 = SQLManager.retrieveRecords("questionnaire", where); 
						while (rs2.next()) {
					%>
						<option value="<%=rs2.getString("questionnaire_id")%>"><%=rs2.getString("questionnaire_id")+" - " + rs2.getString("site_id")%></option>
					<% }
					}%>
					</select>
				</div>
		        <div class="col-md-offset-9">
		            <button type="submit" class="btn btn-primary">View This Questionnaire</button>
				</div>
			</div>
		</form>
		</div>
	</div>
</body>
</html>
<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.ResultSet;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	<%@include file="../header.jsp" %>
  	<br><br>
  	<div class="main">
		<div class="header">
             Oops! The link has expired!
        </div>
	</div>
</body>
</html>
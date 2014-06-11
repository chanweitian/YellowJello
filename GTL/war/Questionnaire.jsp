<%-- Questionnaire.jsp before validation is added --%>
<%@page import="java.util.*;" %>
<%-- Get previous year --%>
<%
int previousYear = Calendar.getInstance().get(Calendar.YEAR) - 1;
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GTL Energy Certificate Questionnaire</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    
    <%-- This is for SiteInfo.jsp --%>
    <link href="css/siteInfo.css" rel="stylesheet">
	<script type="text/javascript" src="../js/siteInfo.js"></script>	
		
		
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="js/expand.js"></script>
	<script type="text/javascript" src="../js/siteInfo2.js"></script>	
		
	<%-- Questionnaire.jsp --%>
	<link href="css/questionnaire.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
    
    <%-- no conflict: load jQuery 1.2.6 --%>
    <script type="text/javascript">
    	var $jq = jQuery.noConflict(true);
    </script>
    <script type="text/javascript" src="../js/formToWizard.js"></script>
    <script type="text/javascript" src="../js/questionnaire.js"></script>
    
    
    <%-- This is for SiteDef.jsp --%>
    <link href="css/siteDef.css" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    
	<%-- no conflict: load jQuery 2.0.2 --%>
    <script type="text/javascript">
    	var $jq1 = jQuery.noConflict(true);
    </script>
    <script type="text/javascript" src="../js/siteDef.js"></script>
    
  </head>
  
  <body onload="MakeWizard()">
  
	<%@include file="../header.jsp" %>
  
  	<br><br>
    <div id="main">
        <div id="header">
            <h1>GTL Energy Certificate Questionnaire</h1>
        </div>
        <form id="questionnaire" action="processQuestionnaire">
        
        <%@include file="../SiteDef.jsp" %>
        <%@include file="../SiteInfo.jsp" %>
        <%@include file="../Usage.jsp" %>
        
        <br><br>
        <p>
            <input id="SaveAccount" type="submit" value="Submit Questionnaire" />
        </p>
        </form>
    </div>
</body>
</html>
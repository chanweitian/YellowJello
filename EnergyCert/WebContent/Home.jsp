<%@page import="java.util.*,db.*,java.lang.Thread,java.sql.ResultSet;" %>
<%@include file="protect.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>GTL Energy Certificate Questionnaire</title>
		
		
		<%-- JQuery script --%>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		
		<!-- Bootstrap -->
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<%-- Questionnaire.jsp --%>
		<link href="css/questionnaire.css" rel="stylesheet">
		<script type="text/javascript" src="js/questionnaire.js"></script>
		
<script>
function showModal() {
	$('#savedModal').modal('show');
}
</script>
    
</head>
<%
String saved_quest_id = (String) session.getAttribute("saved_quest_id");
session.removeAttribute("saved_quest_id");
if (saved_quest_id != null) { %>
<body onload="showModal()">
<% }  else {%>
<body>
<% } %>

<%@include file="header.jsp" %>
		  
  	<br><br>
  	<div class="main">
		<div class="header">
            GTL Energy Certificate Home Page
            <img src="img/dhl-home.jpg" height="60%" width="60%" />
        </div>
        
	</div>
	

<%-- Modal --%>
<div class="modal fade" id="savedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="left:0px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h4 class="modal-title">Saved Questionnaire</h4>
            </div>

            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
				Your Questionnaire has been successfully saved. <br><br>
				<b>Questionnaire ID: <%=saved_quest_id%></b><br>
				<%
				String questionnaire_link = (String) session.getAttribute("questionnaire_link");
				if (questionnaire_link != null) {
					session.removeAttribute("questionnaire_link");
					String where = "questionnaire_link = \'" + questionnaire_link + "\'";
					RetrievedObject ro = SQLManager.retrieveRecords("questionnaire_link", where);
					ResultSet rs = ro.getResultSet();
					String sender_email = "";
					while (rs.next()) {
						sender_email = rs.getString("sender_email");
					}
				%>	
					<br>Would you like to notify the sender that you have filled up the questions?<br>
					<form id="sendEmailForm" action="form/processsendemail">
						<input type="hidden" name="sender_email" value="<%=sender_email%>" />
						<input type="hidden" name="questionnaire_id" value="<%=saved_quest_id%>" />
						<button class="btn btn btn-success" style="width:80px;" type="submit">Yes</button> &nbsp;
						<button class="btn btn btn-danger" style="width:80px;" data-dismiss="modal">No</button>
					</form>
					<br>
					<font color="maroon"><div id="result"></div></font>
				<%	
				} else {
				%>
				You can continue to work on it under the <b>Edit Questionnaire</b> function. 
				<% } %>
            </div>
        </div>
    </div>
</div>
		
</body>

<script type="text/javascript">
var form = $('#sendEmailForm');
form.submit(function () {
 
$.ajax({
type: form.attr('method'),
url: form.attr('action'),
data: form.serialize(),
success: function (data) {
var result=data;
$('#result').text(result);
}
});
 
return false;
});

</script>
</html>
<% 
String utype = (String) session.getAttribute("usertype");
if (utype==null || utype.contains("Admin")) {
	response.sendRedirect("/EnergyCert");
	return;
}
%>
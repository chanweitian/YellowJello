<% 
if (session.getAttribute("usertype")==null || !session.getAttribute("usertype").equals("Company Admin")) {
	response.sendRedirect("/EnergyCert");
	return;
}
%>
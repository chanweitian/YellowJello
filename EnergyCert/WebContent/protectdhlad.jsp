<% 
if (session.getAttribute("usertype")==null || !session.getAttribute("usertype").equals("DHL Admin")) {
	response.sendRedirect("/EnergyCert");
	return;
}
%>
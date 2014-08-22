<% 
if (session.getAttribute("userid")==null) {
	response.sendRedirect("/EnergyCert");
	return;
}
%>
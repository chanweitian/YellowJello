<%@page import="db.*,java.sql.*,java.io.*,java.awt.*,javax.imageio.*" %>
<%
response.setHeader("content-type","image/jpeg");
RetrievedObject ro = SQLManager.retrieveRecords("pic", "idpic=1");
ResultSet rs = ro.getResultSet();
try {
    while (rs.next()) {
    	Blob b = rs.getBlob("img");
    	InputStream is = new BufferedInputStream(b.getBinaryStream());
        Image image = ImageIO.read(is);
        // Use a label to display the image
        out.println(image);
        // Use a label to display the image
    }
} catch (SQLException e) {
	e.printStackTrace();
}
ro.close();
%>
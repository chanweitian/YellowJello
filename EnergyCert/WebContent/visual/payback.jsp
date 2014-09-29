<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="db.*,java.util.*,java.sql.*,java.text.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">

<!-- Bootstrap-->
<link href="../css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../css/payback_stylesheet.css"> 
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script type="text/javascript" src="../js/Chart.js"></script>





<%

	HashMap<String, ArrayList<String>> paybackMap = (HashMap<String,ArrayList<String>>) request.getAttribute("paybackMap");


//	HashMap<String, ArrayList<String>> paybackMap = new HashMap<String, ArrayList<String>>();
	
/*
	ArrayList<String> list1 = new ArrayList<String>();
	//1.2	117	 6,327,720 
	list1.add("1.2");
	list1.add("5.653");
	list1.add("0.48");

	paybackMap.put("T5", list1);
	
	/*
	list1 = new ArrayList<String>();
	list1.add("0");
	list1.add("0");
	list1.add("0");
	paybackMap.put("Cur", list1);
	
	
	list1 = new ArrayList<String>();
	list1.add("1.3");
	list1.add("8.653");
	list1.add("0.48");
	paybackMap.put("T8", list1);
	
	/*
	list1 = new ArrayList<String>();
	list1.add("1.1");
	list1.add("5.653");
	list1.add("0.48");
	paybackMap.put("T15", list1);
	
	*/
	
	
	
	Set<String> keySet = paybackMap.keySet();
	
	String[] arr = {"192,262,63","82,225,203","255,26,0","110,16,232","2,213,255"};
	
	//220,220,220

%>



<script>

var radarChartData = {
	labels: ["Payback", "Rating", "Lighting"],
	datasets: [
	           <%
	           int count = 0;
	            for(String key: keySet){
	            	ArrayList<String> list = paybackMap.get(key);
	           %>
	           
	           	{
	   			label: "<%= key%>",
	   			
	   			fillColor: "rgba(<%= arr[count] %>, 0.2)",
	   			strokeColor: "rgba(<%= arr[count] %>, 1)",
	   			pointColor: "rgba(<%= arr[count] %>, 1)",
	   			pointStrokeColor: "#fff",
	   			pointHighlightFill: "#fff",
	   			pointHighlightStroke: "rgba(<%= arr[count] %>, 1)",
	   			data: [<%=list.get(0)%>,<%=list.get(1)%>,<%=list.get(2)%>]
	   			},
	           
	           <%
	           count++;
	           } %>
	    
	]
};

window.onload = function(){
	window.myRadar = new Chart(document.getElementById("canvas").getContext("2d")).Radar(radarChartData, {
		responsive: false,
	});
}


</script>

</head>


<body>
<%@include file="../header.jsp" %>
<br/>
<br/>


<br/>
<div id="main">




<canvas id="canvas" width="400" height="400"></canvas>
<div class='my-legend'>
<div class='legend-title'>Lighting Payback</div>
<div class='legend-scale'>
  <ul class='legend-labels'>
  	<%
  	count = 0;
	for(String key: keySet){
	%>
    <li><span style='background:rgba(<%= arr[count] %>,1);'></span><%=key %></li>
    <%
    count++;
    } 
    %>
  </ul>
</div>
<!-- <div class='legend-source'>Source: <a href="#link to source">Name of source</a></div> -->
</div>

<style type='text/css'>

.my-legend {
	float: right;
}


  .my-legend .legend-title {
    text-align: left;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 90%;
    
    }
  .my-legend .legend-scale ul {
    margin: 0;
    margin-bottom: 5px;
    padding: 0;
    float: left;
    list-style: none;
    }
  .my-legend .legend-scale ul li {
    font-size: 80%;
    list-style: none;
    margin-left: 0;
    line-height: 18px;
    margin-bottom: 2px;
    }
  .my-legend ul.legend-labels li span {
    display: block;
    float: left;
    height: 16px;
    width: 30px;
    margin-right: 5px;
    margin-left: 0;
    border: 1px solid #999;
    }
  .my-legend .legend-source {
    font-size: 70%;
    color: #999;
    clear: both;
    }
  .my-legend a {
    color: #777;
    }
</style>


</div>

</body>
</html>
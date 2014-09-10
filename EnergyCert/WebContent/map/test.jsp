<script type="text/javascript">
var xmlhttp;

if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
	  var res = xmlhttp.responseText;
	  var values = res.split(";");
      var siteArray = [];
      
	  for(x in values) {
		  var arr = values[x].split(",");
		  siteArray[x] = arr;
	  }
	  document.write(siteArray);
    }
  }
xmlhttp.open("GET","getsites.jsp?company="+"China Company",true);
xmlhttp.send();

</script>
	function showValues(str)
	{
	var xmlhttp;    
	if (str=="")
	  {
		var select = document.getElementById("zone_id"), option = null;
		var len = select.options.length;
		for (var i = 0; i < len; i++)
	    {
	        select.remove(0);
	    }
		option = document.createElement("option");
		option.value = ""
		option.innerHTML = "--Select a Site ID first--";
	    select.appendChild(option);
	    setTimeout(function() {
			$('#payback_form').bootstrapValidator('revalidateField', 'zone_id');
		}, 500);
	  return;
	  }
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
		  var select = document.getElementById("zone_id"), option = null, next_desc = null;
		  var len = select.options.length;
		 
		  for (var i = 0; i < len; i++)
	      {
	          select.remove(0);
	      }
	        
		  for(x in values) {
		        option = document.createElement("option");
		        next_desc = values[x];
		        option.value = next_desc.trim();
		        var temp = next_desc.split("//");
		        option.innerHTML = temp[0].trim();
		        select.appendChild(option);
		    }
	    }
	  }
	xmlhttp.open("GET","getzones.jsp?questionnaire_id="+str,true);
	xmlhttp.send();
	setTimeout(function() {
		$('#payback_form').bootstrapValidator('revalidateField', 'zone_id');
	}, 800);
	}
	
	function validateFields() {
		var len = document.getElementById("site_id").options.length;
	
		if (len == 1) {
			$('#paybackModal').modal('show');
		}
		
		$('[data-toggle="tooltip"]').tooltip({
		    'placement': 'left'
		});
	}
	
	function updateTable() {
		var checkboxes = document.getElementsByName('types[]');
		var checkboxesChecked = [];
		 // loop over them all
		for (var i=0; i<checkboxes.length; i++) {
		    // And stick the checked ones onto an array...
		    var temp = checkboxes[i].value + '_row';
			if (checkboxes[i].checked) {
		    	document.getElementById(temp).style.display = "block";
		    	document.getElementById(temp).style.display = "inline-flex";
		    } else {
		    	document.getElementById(temp).style.display = "none";
		    }
		 }
		$('#payback_form').bootstrapValidator('revalidateField', 'integer');
		$('#payback_form').bootstrapValidator('revalidateField', 'number');
	}
	
	function removeThis(str) {
		document.getElementById(str).checked = false;
		var temp_label = str + '_label';
		document.getElementById(temp_label).className = "btn btn-default";
		var temp_row = str + '_row';
		document.getElementById(temp_row).style.display = "none";
		//document.getElementById("add_new_button").style.display = "block";
	}
	
	function removeRow(str) {
		var temp = "row_" + str;
		document.getElementById(temp).remove();
		//document.getElementById("add_new_button").style.display = "block";
	}
	
	var count = 1;
	
	function addNewType() {
		/*
		var length_checkbox = $("input:checkbox:checked").length;
		var length_new_rows = document.getElementsByName("lighting_type[]").length;
		var total_length = length_checkbox+length_new_rows;
		
		if (total_length > 9) {
			document.getElementById("max-alert").style.display = "block";
			document.getElementById("add_new_button").style.display = "none";
			setTimeout(function() {
				document.getElementById("max-alert").style.display = "none";
			}, 5000);
		} else {*/
		
		    var $templateEle = $('#type_row'),
		        $row         = $templateEle.clone().attr('id','row_'+count).insertBefore($templateEle).removeClass('hide'),
		        $el1         = $row.find('input').eq(0).attr('name', '\\[]').attr('id','lighting_type').attr('data-bv-field','number'),
		        $el2         = $row.find('input').eq(1).attr('name', 'num_fixtures[]').attr('id','integer').attr('data-bv-field','integer'),
		    	$el3         = $row.find('input').eq(2).attr('name', 'lamp_fixture[]').attr('id','integer').attr('data-bv-field','integer'),
		    	$el4         = $row.find('input').eq(3).attr('name', 'power_rating[]').attr('id','number').attr('data-bv-field','integer'),
		    	$el5         = $row.find('input').eq(4).attr('name', 'efficacy[]').attr('id','number').attr('data-bv-field','integer'),
		    	$el6         = $row.find('input').eq(5).attr('name', 'ballast_factor[]').attr('id','integer').attr('data-bv-field','integer'),
		    	$el7         = $row.find('input').eq(6).attr('name', 'op_hours[]').attr('id','integer').attr('data-bv-field','integer'),
			    $el8         = $row.find('input').eq(7).attr('name', 'cost_lamp[]').attr('id','number').attr('data-bv-field','integer'),
			   	$el9         = $row.find('input').eq(8).attr('name', 'installation_cost[]').attr('id','number').attr('data-bv-field','integer'),
			   	$el10        = $row.find('input').eq(9).attr('name', 'useful_life[]').attr('id','number').attr('data-bv-field','integer');
			   	$el11        = $row.find('img').eq(0).attr('id',count);
		    
		    $('#payback_form').bootstrapValidator('addField', $el1);
		    $('#payback_form').bootstrapValidator('addField', $el2);
		    $('#payback_form').bootstrapValidator('addField', $el3);
		    $('#payback_form').bootstrapValidator('addField', $el4);
		    $('#payback_form').bootstrapValidator('addField', $el5);
		    $('#payback_form').bootstrapValidator('addField', $el6);
		    $('#payback_form').bootstrapValidator('addField', $el7);
		    $('#payback_form').bootstrapValidator('addField', $el8);
		    $('#payback_form').bootstrapValidator('addField', $el9);
		    $('#payback_form').bootstrapValidator('addField', $el10);
		    count++;
		    $('#payback_form').bootstrapValidator('revalidateField', 'integer');
			$('#payback_form').bootstrapValidator('revalidateField', 'number');
		//}
	}
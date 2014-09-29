$(document).ready(function() {
	
    $('.addButton').on('click', function() {
    	
    	var $templateName, $name1, $name2, $name3, $name4, $name5, $name6;
    	
    	if (this.id == 'button1') {
    		$templateName = '#zone-container-1';
    		$name1 = 'b1_zone_name[]';
    		$name2 = 'b1_zone_heating_cooling[]';
    		$name3 = 'b1_zone_min_temp[]';
    		$name4 = 'b1_zone_max_temp[]';
    		$name5 = 'b1_zone_activity[]';
    		$name6 = 'b1_zone_operation[]';
    	} else if (this.id == 'button2') {
    		$templateName = '#zone-container-2';
    		$name1 = 'b2_zone_name[]';
    		$name2 = 'b2_zone_heating_cooling[]';
    		$name3 = 'b2_zone_min_temp[]';
    		$name4 = 'b2_zone_max_temp[]';
    		$name5 = 'b2_zone_activity[]';
    		$name6 = 'b2_zone_operation[]';
    	} else if (this.id == 'button3') {
    		$templateName = '#zone-container-3';
    		$name1 = 'b3_zone_name[]';
    		$name2 = 'b3_zone_heating_cooling[]';
    		$name3 = 'b3_zone_min_temp[]';
    		$name4 = 'b3_zone_max_temp[]';
    		$name5 = 'b3_zone_activity[]';
    		$name6 = 'b3_zone_operation[]';
    	} else if (this.id == 'button4') {
    		$templateName = '#zone-container-4';
    		$name1 = 'b4_zone_name[]';
    		$name2 = 'b4_zone_heating_cooling[]';
    		$name3 = 'b4_zone_min_temp[]';
    		$name4 = 'b4_zone_max_temp[]';
    		$name5 = 'b4_zone_activity[]';
    		$name6 = 'b4_zone_operation[]';
    	} else if (this.id == 'button5') {
    		$templateName = '#zone-container-5';
    		$name1 = 'b5_zone_name[]';
    		$name2 = 'b5_zone_heating_cooling[]';
    		$name3 = 'b5_zone_min_temp[]';
    		$name4 = 'b5_zone_max_temp[]';
    		$name5 = 'b5_zone_activity[]';
    		$name6 = 'b5_zone_operation[]';
    	} else if (this.id == 'button6') {
    		$templateName = '#zone-container-6';
    		$name1 = 'b6_zone_name[]';
    		$name2 = 'b6_zone_heating_cooling[]';
    		$name3 = 'b6_zone_min_temp[]';
    		$name4 = 'b6_zone_max_temp[]';
    		$name5 = 'b6_zone_activity[]';
    		$name6 = 'b6_zone_operation[]';
    	}
    	
        var $templateEle = $($templateName),
            $row         = $templateEle.clone().removeAttr('id').insertBefore($templateEle).removeClass('hide'),
            $el1         = $row.find('input').eq(0).attr('name', $name1);
        	$el2         = $row.find('select').eq(1).attr('name', $name2);
        	$el3         = $row.find('input').eq(1).attr('name', $name3);
        	$el4         = $row.find('input').eq(2).attr('name', $name4);
        	$el5         = $row.find('select').eq(0).attr('name', $name5);
        	$el6         = $row.find('select').eq(2).attr('name', $name6);
        
        $('#questionnaire').bootstrapValidator('addField', $el1);
        $('#questionnaire').bootstrapValidator('addField', $el2);
        $('#questionnaire').bootstrapValidator('addField', $el3);
        $('#questionnaire').bootstrapValidator('addField', $el4);
        $('#questionnaire').bootstrapValidator('addField', $el5);
        $('#questionnaire').bootstrapValidator('addField', $el6);

        $row.on('click', '.removeButton', function(e) {
            $('#questionnaire').bootstrapValidator('removeField', $el1);
            $('#questionnaire').bootstrapValidator('removeField', $el2);
            $('#questionnaire').bootstrapValidator('removeField', $el3);
            $('#questionnaire').bootstrapValidator('removeField', $el4);
            $('#questionnaire').bootstrapValidator('removeField', $el5);
            $('#questionnaire').bootstrapValidator('removeField', $el6);
                $row.remove();
            });
        });
    });
    
  //add/delete building
	jQuery(function($) {
	
   	var bNum = 1;
   	var cloned;
   	var newBuilding;
   	$('#add_building').click(function(){
   		cloned = $( '#building'+ bNum );
        newBuilding = $("#building0").clone(true,true).removeClass('hide').attr('id', 'building'+(++bNum) ).insertAfter( cloned );
        newBuilding.find('button').eq(0).attr('id', 'button' + bNum);
        newBuilding.find('#zone-container-0').attr('id', 'zone-container-' + bNum);
            var $el1         = newBuilding.find('input').eq(1).attr('name', 'b' + bNum + '_zone_name[]');
	        	$el2         = newBuilding.find('select').eq(1).attr('name', 'b' + bNum + '_zone_heating_cooling[]');
	        	$el3         = newBuilding.find('input').eq(2).attr('name', 'b' + bNum + '_zone_min_temp[]');
	        	$el4         = newBuilding.find('input').eq(3).attr('name', 'b' + bNum + '_zone_max_temp[]');
	        	$el5         = newBuilding.find('select').eq(0).attr('name', 'b' + bNum + '_zone_activity[]');
	        	$el6         = newBuilding.find('select').eq(2).attr('name', 'b' + bNum + '_zone_operation[]');
	        	$elName      = newBuilding.find('input').eq(0).attr('name', 'building_name[]');
	        	
        	 $('#questionnaire').bootstrapValidator('addField', $el1);
             $('#questionnaire').bootstrapValidator('addField', $el2);
             $('#questionnaire').bootstrapValidator('addField', $el3);
             $('#questionnaire').bootstrapValidator('addField', $el4);
             $('#questionnaire').bootstrapValidator('addField', $el5);
             $('#questionnaire').bootstrapValidator('addField', $el6); 
             $('#questionnaire').bootstrapValidator('addField', $elName);
             
	    var deleteBuildingButton = document.getElementById("delete_building");
        if (bNum == 1) {
   			deleteBuildingButton.style.display = 'none';
   		} else {
   			deleteBuildingButton.style.display = 'block'; 
   		}
    });
   	
   	$('#delete_building').click(function(){
   		var div = document.getElementById("building" + bNum);
   		div.parentNode.removeChild(div);
   		bNum--;
   		var deleteBuildingButton = document.getElementById("delete_building");
   		if (bNum == 1) {
   			deleteBuildingButton.style.display = 'none';
   		} else {
   			deleteBuildingButton.style.display = 'block'; 
   		}
   		
    });
   	
});
	
function updateHeatingCooling(selectedVal) {
	var selectedValue = selectedVal.value;
	
	var heating_cooling = $(":input:eq(" + ($(":input").index(selectedVal) + 1) + ")");
	var html_heating_cooling = heating_cooling[0];
	
	var min_temp = $(":input:eq(" + ($(":input").index(selectedVal) + 2) + ")");
	var max_temp = $(":input:eq(" + ($(":input").index(selectedVal) + 3) + ")");
	var html_min_temp = min_temp[0];
	var html_max_temp = max_temp[0];
	
	//clear all options in drop down list
	html_heating_cooling.options.length = 0;
	
	//clear min and max temp
	html_min_temp.value = html_max_temp.value = "";

	//array with textContent
	var textArray = ["Heated","Air Conditioned","Heated + Air Conditioned","Other","Frost Protected","Heated","Chilled","Frozen","Temperature Controlled","Other"];
	//array with values
	var valueArray = ["heated_20","air_conditioned","heated_air_conditioned","other","frost_protected","heated_14","chilled","frozen","temp_controlled","other"];
	
	//add the default value
	var el_default = document.createElement("option");
	el_default.textContent = "-- Select one --";
	el_default.value = "";
	html_heating_cooling.appendChild(el_default);
	
	if (selectedValue == "offices" || selectedValue == "wh_value_add") {
		for (var i = 0; i < 4; i++) {
			var el = document.createElement("option");
			el.textContent = textArray[i];
			el.value = valueArray[i];
			html_heating_cooling.appendChild(el);
		}
	} else if (selectedValue == "") {
	
	} else {
		for (var i = 4; i < textArray.length; i++) {
			var el = document.createElement("option");
			el.textContent = textArray[i];
			el.value = valueArray[i];
			html_heating_cooling.appendChild(el);
		}
	}
	
}

function updateMinMaxTemp(selectedVal) {
	var selectedValue = selectedVal.value;
	var min_temp = $(":input:eq(" + ($(":input").index(selectedVal) + 1) + ")");
	var max_temp = $(":input:eq(" + ($(":input").index(selectedVal) + 2) + ")");
	var html_min_temp = min_temp[0];
	var html_max_temp = max_temp[0];

	if (selectedValue == "heated_20") {
		html_min_temp.value = "20";
		html_max_temp.value = "";
	} else if (selectedValue == "air_conditioned") {
		html_min_temp.value = "";
		html_max_temp.value = "28";
	} else if (selectedValue == "heated_air_conditioned") {
		html_min_temp.value = "20";
		html_max_temp.value = "28";
	} else if (selectedValue == "frost_protected") {
		html_min_temp.value = "3";
		html_max_temp.value = "";
	} else if (selectedValue == "heated_14") {
		html_min_temp.value = "14";
		html_max_temp.value = "";
	} else if (selectedValue == "chilled") {
		html_min_temp.value = "2";
		html_max_temp.value = "6";
	} else if (selectedValue == "frozen") {
		html_min_temp.value = "-20";
		html_max_temp.value = "-16";
	} else if (selectedValue == "temp_controlled") {
		html_min_temp.value = "7";
		html_max_temp.value = "18";
	} else {
		html_min_temp.value = "";
		html_max_temp.value = "";		
	}
	$('#questionnaire').bootstrapValidator('revalidateField', 'integer');
	
}

function saveFunction() {
	$('#master_form').bootstrapValidator('destroy');
	document.getElementById("master_form").action = "processmaster";
	$('#master_form').bootstrapValidator('defaultSubmit');
}

function submitFunction() {
	document.getElementById("master_form").action = "processmaster";
}
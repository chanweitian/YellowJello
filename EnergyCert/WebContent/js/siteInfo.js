$(document).ready(function() {
	$(function() {
	    $("#content h4.expand").toggler();
	    $("#content div.demo").expandAll({trigger: "h4.expand", ref: "h4.expand"});
	    $("#content div.other").expandAll({
	      expTxt : "[Show]", 
	      cllpsTxt : "[Hide]",
	      ref : "ul.collapse",
	      showMethod : "show",
	      hideMethod : "hide"
	    });
	    $("#content div.post").expandAll({
	      expTxt : "[Read this entry]", 
	      cllpsTxt : "[Hide this entry]",
	      ref : "div.collapse", 
	      localLinks: "p.top a"    
	    });    
	});
	
	$('.add_EHE_Button').on('click', function() {

	    var $templateEle = $('#elect_handling_equipment_row'),
	        $row         = $templateEle.clone().removeAttr('id').insertBefore($templateEle).removeClass('hide'),
	        $el1         = $row.find('input').eq(0).attr('id','integer').attr('name', 'ampere_hours[]').attr('data-bv-field','integer');
	    	$el2         = $row.find('input').eq(1).attr('id','integer').attr('name', 'voltage[]').attr('data-bv-field','integer');
	    	$el3         = $row.find('input').eq(2).attr('id','integer').attr('name', 'total_charges[]').attr('data-bv-field','integer');
	    	$el4         = $row.find('input').eq(3).attr('id','integer').attr('name', 'total_charge_duration[]').attr('data-bv-field','integer');
	    
	    $('#master_form').bootstrapValidator('addField', $el1);
	    $('#master_form').bootstrapValidator('addField', $el2);
	    $('#master_form').bootstrapValidator('addField', $el3);
	    $('#master_form').bootstrapValidator('addField', $el4);
	
	    $row.on('click', '.remove_EHE_Button', function(e) {
	        $('#master_form').bootstrapValidator('removeField', $el1);
	        $('#master_form').bootstrapValidator('removeField', $el2);
	        $('#master_form').bootstrapValidator('removeField', $el3);
	        $('#master_form').bootstrapValidator('removeField', $el4);
	        $row.remove();
	    });
	});
	
	$('.add_ERI_done_Button').on('click', function() {

	    var $templateEle = $('#ERI_done_row'),
	        $row         = $templateEle.clone().removeAttr('id').insertBefore($templateEle).removeClass('hide'),
	        $el1         = $row.find('input').eq(0).attr('name', 'site_info_initiatives_done[]');
	    	$el2         = $row.find('input').eq(1).attr('name', 'site_info_initiatives_done_when[]');
	    	$el3         = $row.find('input').eq(2).attr('name', 'site_info_initiatives_done_zone[]');
	    	$el4         = $row.find('input').eq(3).attr('name', 'site_info_initiatives_done_impact[]');
	    
	    $('#master_form').bootstrapValidator('addField', $el1);
	    $('#master_form').bootstrapValidator('addField', $el2);
	    $('#master_form').bootstrapValidator('addField', $el3);
	    $('#master_form').bootstrapValidator('addField', $el4);
	
	    $row.on('click', '.remove_ERI_done_Button', function(e) {
	        $('#master_form').bootstrapValidator('removeField', $el1);
	        $('#master_form').bootstrapValidator('removeField', $el2);
	        $('#master_form').bootstrapValidator('removeField', $el3);
	        $('#master_form').bootstrapValidator('removeField', $el4);
	        $row.remove();
	    });
	});
	
	$('.add_ERI_planned_Button').on('click', function() {

	    var $templateEle = $('#ERI_planned_row'),
	        $row         = $templateEle.clone().removeAttr('id').insertBefore($templateEle).removeClass('hide'),
	        $el1         = $row.find('input').eq(0).attr('name', 'site_info_initiatives_planned[]');
	    	$el2         = $row.find('input').eq(1).attr('name', 'site_info_initiatives_planned_when[]');
	    	$el3         = $row.find('input').eq(2).attr('name', 'site_info_initiatives_planned_zone[]');
	    	$el4         = $row.find('input').eq(3).attr('name', 'site_info_initiatives_planned_impact[]');
	    
	    $('#master_form').bootstrapValidator('addField', $el1);
	    $('#master_form').bootstrapValidator('addField', $el2);
	    $('#master_form').bootstrapValidator('addField', $el3);
	    $('#master_form').bootstrapValidator('addField', $el4);
	
	    $row.on('click', '.remove_ERI_planned_Button', function(e) {
	        $('#master_form').bootstrapValidator('removeField', $el1);
	        $('#master_form').bootstrapValidator('removeField', $el2);
	        $('#master_form').bootstrapValidator('removeField', $el3);
	        $('#master_form').bootstrapValidator('removeField', $el4);
	        $row.remove();
	    });
	});
});
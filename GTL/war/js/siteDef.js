//add/delete building
jQuery(function($) {
   	var bNum = 1;
   	var cloned;
   	$('#add_building').click(function(){
   		cloned = $( '#building'+ bNum );
        $("#building"+bNum).clone().attr('id', 'building'+(++bNum) ).insertAfter( cloned );
        if (bNum == 1) {
   			document.getElementById("delete_building").disabled = true; 
   		} else {
   			document.getElementById("delete_building").disabled = false; 
   		}
    });
   	
   	$('#delete_building').click(function(){
   		var div = document.getElementById("building" + bNum);
   		div.parentNode.removeChild(div);
   		bNum--;
   		if (bNum == 1) {
   			document.getElementById("delete_building").disabled = true; 
   		} else {
   			document.getElementById("delete_building").disabled = false; 
   		}
   		
    });
   	
});
	
//add/delete zone
jQuery(function($) {
   	var c = 1;
   	var cloned;
   	$('#add_zone').click(function(){
   		cloned = $( '#building'+ bNum );
        $("#building"+bNum+"_zone"+zNum).clone().attr('id', 'building'+(++bNum) ).insertAfter( cloned );
        if (zNum == 1) {
   			document.getElementById("delete_zone").disabled = true; 
   		} else {
   			document.getElementById("delete_zone").disabled = false; 
   		}
    });
   	
   	$('#delete_zone').click(function(){
   		var div = document.getElementById("building" + bNum + "_zone" + zNum);
   		div.parentNode.removeChild(div);
   		zNum--;
   		if (zNum == 1) {
   			document.getElementById("delete_zone").disabled = true; 
   		} else {
   			document.getElementById("delete_zone").disabled = false; 
   		}
   		
    });
   	
});
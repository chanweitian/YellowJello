<!DOCTYPE html>
 <html>
 <head>
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>

	

 <script>
 $(function () {
	    $('table').on('click', 'tr a', function (e) {
	        e.preventDefault();
	        $(this).parents('tr').remove();
	    });
	    
	    $("#addTableRow").click(function() {
	        $("#mans").each(function () {
	            var tds = '<tr>';
	            jQuery.each($('tr:last td', this), function () {
	                tds += '<td>' + $(this).html() + '</td>';
	            });
	            tds += '</tr>';
	            if ($('tbody', this).length > 0) {
	                $('tbody', this).append(tds);
	            } else {
	                $(this).append(tds);
	            }
	        });
	    });
	});
 </script>
 </head>
 <body>

<form method="post" action="">
    <table width="100%" border="1" cellspacing="0" cellpadding="0" id="mans">
        <tr>
            <td>11
                <label for="11"></label>
                <input type="text" name="11" id="11" />
            </td>
            <td>12
                <label for="12"></label>
                <input type="text" name="12" id="12" />
            </td>
            <td>13
                <label for="13"></label>
                <input type="text" name="13" id="13" />
            </td>
            <td><a href="#">del</a>

            </td>
        </tr>
    </table>
</form>
<button type="button" id="addTableRow">add row</button>

</body>
 </html>
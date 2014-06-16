   google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawConsumptionChart);
      google.setOnLoadCallback(drawEmissionChart);
      
      function drawConsumptionChart() {
   		var data = google.visualization.arrayToDataTable([
        ['Genre', 'Natural Gas', 'Electricity', { role: 'annotation' } ],
        ['2007', 0, 4857, ''],
        ['2008', 0, 7234, ''],
        ['2009', 6000, 5000, ''],
      	]);

      	var options = {
        width: 600,
        height: 400,
        vAxis: {title: 'Energy (kWh) 1000', titleTextStyle: {color: 'black'}},
        legend: { position: 'top', maxLines: 3 },
		bar: { groupWidth: '75%' },
        isStacked: true,
      	};

        var chart = new google.visualization.ColumnChart(document.getElementById('tc_chart'));
        chart.draw(data, options);
      }

      function drawEmissionChart() {
   		var data = google.visualization.arrayToDataTable([
        ['Genre', 'Natural Gas', 'Electricity', { role: 'annotation' } ],
        ['2007', 0, 4857, ''],
        ['2008', 0, 7234, ''],
        ['2009', 6000, 5000, ''],
      	]);

      	var options = {
        width: 600,
        height: 400,
        vAxis: {title: 'Energy (kWh) 1000', titleTextStyle: {color: 'black'}},
        legend: { position: 'top', maxLines: 3 },
		bar: { groupWidth: '75%' },
        isStacked: true,
      	};

        var chart = new google.visualization.ColumnChart(document.getElementById('te_chart'));
        chart.draw(data, options);
      }

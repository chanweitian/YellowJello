   google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawConsumptionChart);
      google.setOnLoadCallback(drawEmissionChart);
      
      function drawConsumptionChart() {
   		var data = google.visualization.arrayToDataTable([
        ['Genre', 'Electricity', 'Natural Gas', { role: 'annotation' } ],
        ['2007', 4857, 0, ''],
        ['2008', 7234, 0, ''],
        [<%= year1 %>, 6000, 5000, ''],
      	]);

      	var options = {
        width: 500,
        height: 300,
        vAxis: {title: 'Energy (kWh) 1000', titleTextStyle: {color: 'black'}},
        legend: { position: 'top', maxLines: 3 },
		bar: { groupWidth: '75%' },
        isStacked: true,
        colors:['#ffcd00','#c10435']
      	};

        var chart = new google.visualization.ColumnChart(document.getElementById('tc_chart'));
        chart.draw(data, options);
      }

      function drawEmissionChart() {
   		var data = google.visualization.arrayToDataTable([
        ['Genre', 'Natural Gas', 'Electricity', { role: 'annotation' } ],
        ['2007', 0, 2756, ''],
        ['2008', 0, 3925, ''],
        ['2009', 3321, 901, ''],
      	]);

      	var options = {
        width: 500,
        height: 300,
        vAxis: {title: 'CO2 Emmission', titleTextStyle: {color: 'black'}},
        legend: { position: 'top', maxLines: 3 },
		bar: { groupWidth: '75%' },
        isStacked: true,
        colors:['#ffcd00','#c10435']
      	};

        var chart = new google.visualization.ColumnChart(document.getElementById('te_chart'));
        chart.draw(data, options);
      }


		var lineColors = [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ]

		var backgroundColors = [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ]

function charter(elementId, chart_data){
	//cheap shot JSON validation, makes sure we have what we want
	chart_data = JSON.parse(JSON.stringify(chart_data))

	file_data = JSON.parse(chart_data['file'])
	
	var ctx = document.getElementById(elementId).getContext('2d');
	
	var x_is_integers = 1;
	var y_is_integers = 1;

	var x_max = 0;
	var y_max = 0;

	var labels = []

	file_data.forEach(function(el){
		if(el[chart_data['x_field']].match(/[A-Za-z]/)){
			x_is_integers = 0;
		}
		if(el[chart_data['y_field']].match(/[A-Za-z]/)){
			y_is_integers = 0;
		}
		
		var current_x = parseInt(el[chart_data['x_field']])
		var current_y = parseInt(el[chart_data['y_field']])

		if(current_x > x_max){
			x_max = current_x
		}
		if(current_y > y_max){
			y_max = current_y
		}
	});

	if(x_is_integers == 1){
		for(i = 0; i <= x_max; i++){
			labels.push(i)
		}
	}else{
		//labels comes as strings from x field values uniqued
	}

	if(y_is_integers != 1){
		//I don't know what I'll need to do here, will depend on chart.js
	}

	var separator_fields = chart_data['separator_fields'].split(',')
	var datasets = {}

	for(i=0; i < separator_fields.length; i++){
		for(n=0; n < file_data.length; n++){
			datasets[file_data[n][separator_fields[i]]] = datasets[file_data[n][separator_fields[i]]] || file_data.filter(function (el) {
																											  return el[separator_fields[i]] == file_data[n][separator_fields[i]]
																											});
		}
	}

	//alert(JSON.stringify(datasets))

	var datasets_final = []

	dataset_labels = Object.keys(datasets)

	for(i=0; i < dataset_labels.length; i++){
		var data_list = []
		for(n=0; n < labels.length; n++){
			var isone = datasets[dataset_labels[i]].filter(function(el) {
				return el[chart_data['x_field']] == n
			})
			if(JSON.stringify(isone) != '[]'){
				data_list.push(isone[0][chart_data['y_field']])
			}else{
				data_list.push(null)
			}
		}

		datasets_final.push(
				{
					label: dataset_labels[i],
					data: data_list,
					borderColor: lineColors[i],
					backgroundColor: backgroundColors[i],
					borderWidth: 1,
					fill: false
				}
			)
	};
	

	var myChart = new Chart(ctx, {
	    type: chart_data['graph_type'],
	    data: {
	        labels: labels,
	        datasets: datasets_final
	    },
	    options: {
	        scales: {
	            yAxes: [{
	            	scaleLabel: {
			          display: true,
			          labelString: chart_data['y_field']
			        },
	                ticks: {
	                    beginAtZero:true
	                }
	            }],
	            xAxes: [{
	            	scaleLabel: {
			          display: true,
			          labelString: chart_data['x_field']
			        },
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});
}
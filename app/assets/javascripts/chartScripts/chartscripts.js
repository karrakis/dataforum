
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
		if(typeof(el[chart_data['x_field']]) == typeof "string"){
			//if this is attempted on integers, it explodes.  If integers are converted into Strings in Javascript, they explode.  Fuck it.
			if(el[chart_data['x_field']].match(/[^0-9]/)){
				x_is_integers = 0;
			}
		}
		if(typeof(el[chart_data['y_field']]) == typeof "string"){
			//if this is attempted on integers, it explodes.  If integers are converted into Strings in Javascript, they explode.  Fuck it.
			if(el[chart_data['y_field']].match(/[^0-9]/)){
				y_is_integers = 0;
			}
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
		labels = file_data.map(function(el){
			return el[chart_data['x_field']]
		})
	}

	if(y_is_integers != 1){
		//I don't know what I'll need to do here, will depend on chart.js
	}

	if(chart_data['separator_fields'] != null){
		var separator_fields = chart_data['separator_fields'].split(',')
		var datasets = {}
	}else{
		separator_fields = []
		var datasets = {}
	}

	if (JSON.stringify(separator_fields) == '[""]'){
		separator_fields = []
	}
	
	if (separator_fields.length != 0) {
		for(i=0; i < separator_fields.length; i++){
			for(n=0; n < file_data.length; n++){
				datasets[file_data[n][separator_fields[i]]] = datasets[file_data[n][separator_fields[i]]] || file_data.filter(function (el) {
																												  return el[separator_fields[i]] == file_data[n][separator_fields[i]]
																												});
			}
		}
	}else{
		datasets[chart_data['x_field']] = []
		file_data.forEach(function(el){
			datasets[chart_data['x_field']].push(el[chart_data['y_field']])
		});
	}

	alert(JSON.stringify(datasets))

	var datasets_final = []

	dataset_labels = Object.keys(datasets)

	for(i=0; i < dataset_labels.length; i++){
		var data_list = [];
		var lineColor = [];
		var backgroundColor = [];
		for(n=0; n < labels.length; n++){
			if (datasets[dataset_labels[i]][0].hasOwnProperty(chart_data['x_field'])){
				var isone = datasets[dataset_labels[i]].filter(function(el) {
					return el[chart_data['x_field']] == n
				})
				if(JSON.stringify(isone) != '[]'){
					data_list.push(isone[0][chart_data['y_field']])
				}else{
					data_list.push(null)
				}
				dataset_label = dataset_labels[i]
				lineColor = lineColors[i]
				backgroundColor = backgroundColors[i]
			} else {
				data_list = datasets[dataset_labels[i]]
				if (chart_data['graph_type'] == 'bar'){
					dataset_label = 0
				} else {
					dataset_label = dataset_labels[i]
				}
	
				data_list.forEach(function(el, i){
					lineColor.push(lineColors[i])
					backgroundColor.push(backgroundColors[i])
				});
			}

		}

		if (dataset_label == 0){
			Chart.defaults.global.legend.display = false;
			Chart.defaults.global.tooltips.enabled = false;
		} else {
			Chart.defaults.global.legend.display = true;
			Chart.defaults.global.tooltips.enabled = true;
		}
		
		datasets_final.push(
				{
					label: dataset_label,
					data: data_list,
					borderColor: lineColor,
					backgroundColor: backgroundColor,
					borderWidth: 1,
					fill: false,
					spanGaps: true
				}
			)
	};

	//this doesn't work quite as intended, we'll need to set a flag.
	var display_xaxis_label = true
	//if (x_is_integers == 1 || chart_data['graph_type'] == 'pie'){
	//	display_xaxis_label = true
	//}

	var chart_description = {
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
			          display: display_xaxis_label,
			          labelString: chart_data['x_field']
			        }
	            }]
	        },
	        title: {
	        	display: true,
	        	text: chart_data['graph_label']
	        }
	    }
	}

	if (chart_data['graph_type'] == 'pie'){
		delete chart_description['options']['scales']
	}

	var myChart = new Chart(ctx, chart_description);
	return myChart
}

function parseTSV(str) {

	var x = str.split('\n');
	for (var i=0; i<x.length; i++) {
		if(i==0){
			var headers = x[i].split('\t')
		} else {
			y = x[i].split('\t');
			z = y.map(function(e,i){
				return [headers[i], e]
			})
		    var result = z.reduce(function(map, obj) {
			    map[obj[0]] = obj[1];
			    return map;
			}, {});

		    x[i] = result;
		}
	}
	x.shift()
	return JSON.stringify(x)
}
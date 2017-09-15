function charter(elementId){
	var ctx = document.getElementById(elementId).getContext('2d');
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
	        datasets: [{
	            label: '# of Votes',
	            data: [12, 19, 3, 5, 2, 3],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});
}

function charter(elementId, chart){
	var ctx = document.getElementById(elementId).getContext('2d');
	
	ctx.globalAlpha = 0.95;
	ctx.rect(0, 0, 550, 550);
	ctx.fillStyle = "#435a6b";
	ctx.fill();

	ctx.font = 'italic 10pt Calibri';
	ctx.fillStyle = "black";

	var json = chart.data('graph_data')

	lines = getLines(ctx, JSON.stringify(chart.data('graph_data')), 550)
	var linesLength = lines.length
	for(i=0; i < lines.length; i++){
		ctx.fillText(lines[i],50,(38 + (i*12)));	
	}
	
}

function getLines(ctx, text, maxWidth) {
    var words = text.split("");
    var lines = [];
    var currentLine = words[0];

    for (var i = 1; i < words.length; i++) {
        var word = words[i];
        var width = ctx.measureText(currentLine + " " + word).width;
        if (width < maxWidth) {
            currentLine += " " + word;
        } else {
            lines.push(currentLine);
            currentLine = word;
        }
    }
    lines.push(currentLine);
    return lines;
}
$("#graph_type").change(function() {
	alert(this.children[this.selectedIndex]);
   var selopt = $(this.children[this.selectedIndex]),
       graphType = parseInt(selopt.attr('data-graph_type'));
   if (graphType == 'bar') {
       $("#twoAxis").hide();
       $("#oneAxis").show();
   } else if (graphType == 'line') {
       $("#twoAxis").show();
       $("#oneAxis").hide();
   }
})
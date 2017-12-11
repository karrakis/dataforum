window.onload = function() {
   //Params
   var scriptPram = document.getElementById('load_widget');
   var id = scriptPram.getAttribute('data-graph');

   //iFrame
   var iframe = document.createElement('iframe');
   iframe.style.display = "inherit";
   iframe.src = "https://graphity.space/embed/" + id;
   document.body.appendChild(iframe);
};
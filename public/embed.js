window.onload = function() {
   //Params
   var scriptPram = document.getElementById('load_widget');
   var id = scriptPram.getAttribute('data-graph');

   //iFrame
   var iframe = document.createElement('iFrame');
   iframe.style.display = "inherit";
   iframe.src = "http://localhost:3000/embed/" + id;
   document.body.appendChild(iframe);
};
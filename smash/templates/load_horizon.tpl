

function load_lib(url, callback){
  var s = document.createElement('script');
  s.src = url;
  s.async = true;
  s.onreadystatechange = s.onload = callback;
  s.onerror = function(){console.warn("failed to load library " + url);};
  document.getElementsByTagName("head")[0].appendChild(s);
}

if ( typeof(horizon) !== "undefined" ){
    console.log('horizon is defined');
    graph_{{id}}();
}else if(typeof define === "function" && define.amd){
  console.log('trying horizon with require');
  require.config({paths: { horizon: "{{ horizon_url[:-3] }}"}});
      console.log('trying {{ horizon_url[:-3] }}');
        
      require(["horizon"], function(horizon){
        window.horizon = horizon;
        console.log('loaded d3 with require');
        graph_{{id}}();
  });
}else{
    console.log('trying to load from load_lib');
    load_lib("http://d3js.org/d3.v3.min.js", graph_{{id}}());
}




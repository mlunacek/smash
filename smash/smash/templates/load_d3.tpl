


if ( typeof(d3) !== "undefined" ){
    console.log('d3 is defined');
    graph_{{id}}();
}else if(typeof define === "function" && define.amd){
  console.log('trying d3 with require');
  require.config({paths: {d3: "{{ d3_url[:-3] }}"}});
      console.log('trying {{ d3_url[:-3] }}');
        
      require(["d3"], function(d3){
        window.d3 = d3;
        console.log('loaded d3 with require');
        graph_{{id}}();
  });
}else{
    console.log('trying to load from load_lib');
    url = "http://d3js.org/d3.v3.min.js"
    var s = document.createElement('script');
    s.src = url;
    s.onload = function () {
        graph_{{id}}();
    };
    s.onerror = function(){console.log("failed to load library " + url);};
    document.head.appendChild(s);

}




{% if standalone %}
{% extends 'base.tpl' %}
{% endif %}
{% block content %}
<div id="graph_{{id}}"></div>
<style>



#horizon-chart {
  /* position: absolute; */
  width: 800px;
  padding: 10px;
  margin-left: auto;
  margin-right: auto;
  z-index: 1;
}

#horizon-bands {
  float: right;
}

</style>



<script>



graph_{{id}} = function(){

// d3.json("unemployment.json", function(error, data) {
// d3.csv("measured_real_power.csv", function(error, data) {
    data = {{data}};
    
    var keys = d3.keys(data).filter(function(key) { return key !== "time"; });
    var number_of_keys = keys.length;
    var width = {{width}},
        height = {{height}};
    
    var key_height = (height/number_of_keys);

    var chart = d3.horizon()
        .width(width)
        .height(key_height-1)
        .bands(4)
        .mode("offset")
        .interpolate("basis");

    var parseDate = d3.time.format("%H:%M:%S").parse;

    var dates = d3.values(data["time"]).map(function(d) {  return parseDate(d); })
    
    var key_data = {};
    arrayLength = keys.length;
    for (var i = 0; i < arrayLength; i++) {
        key_data[keys[i]] = d3.values(data[keys[i]]).map(function(d) {  return +d; })
    }
    

    var svg_{{id}} = d3.select("#graph_{{id}}").append("svg")
        .attr("width", width)
        .attr("height", height);

    for(var x=0; x<number_of_keys; x++){

        data = d3.zip(dates, key_data[keys[x]]);
        svg_{{id}}.append("g")
            .attr("transform", "translate(0," + x*key_height + ")")
            .data([data]).call(chart);
    
    }

}

{% include "load_d3.tpl" %}

</script>
{% endblock %}

{% if standalone %}
{% extends 'base.tpl' %}
{% endif %}
{% block content %}
<div id="graph_{{id}}"></div>
<!-- <script src="http://d3js.org/d3.v3.min.js"></script> -->
<style>
#graph{
    float: left;
}

.overlay {
  fill: none;
  pointer-events: all;
}

text{
    font-family: sans-serif;
    /* font-size: 3px; */
    font-color: grey;
    shape-rendering: crispEdges;
}

#table{
    float: right;
}
#graph{
    float: left;
}

#data{
    font-family: sans-serif;
    font-size: 9px;
    font-color: grey;
}

table{
    width: 300px;
    margin-left: 0px;
    font-size: 12px;
    table-layout: fixed;

}

th{
    text-align: left;
}

td, th {
    width: 140px;
    word-wrap:break-word;
    padding: 1px 4px;
}
</style>

<script type="text/javascript">
graph_{{id}} = function(){

var margin = {top: 50, right: 20, bottom: 50, left:20},
    width = {{width}} - margin.left - margin.right,
    height = {{height}} - margin.top - margin.bottom;

var svg_{{id}} = d3.select("#graph_{{id}}").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .call(d3.behavior.zoom().scaleExtent([0.75, 8]).on("zoom", zoom_{{id}}))
    .append("g");

svg_{{id}}.append("rect")
    .attr("class", "overlay")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom);


    draw = function(edges, nodes, svg){

     var x_scale = d3.scale.linear()
                    .domain([d3.min(nodes, function(d){ return d['x'];}), 
                             d3.max(nodes, function(d){ return d['x'];})])
                    .range([0, width]);

    var y_scale = d3.scale.linear()
                    .domain([d3.min(nodes, function(d){ return d['y'];}), 
                             d3.max(nodes, function(d){ return d['y'];})])
                    .range([height, 0]);


    svg.selectAll("line")
       .data(edges)
       .enter()
       .append("line")
       .attr("x1", function(d) { return x_scale(d['x1']); })
       .attr("y1", function(d) { return y_scale(d['y1']); })
       .attr("x2", function(d) { return x_scale(d['x2']); })
       .attr("y2", function(d) { return y_scale(d['y2']); })
       .attr("stroke-width", function(d) { return d['stroke_width']; })
       .attr("stroke","#d3d3d3");

    svg.selectAll("circle")
       .data(nodes)
       .enter()
       .append("circle")
       .attr("cx", function(d) { return x_scale(d['x']); })
       .attr("cy", function(d) { return y_scale(d['y']); })
       .attr("r",  function(d) { return d['size']; })
       .attr("fill",  function(d) { return d3.rgb(d['color'][0]*255,
                                                  d['color'][1]*255,
                                                  d['color'][2]*255); })
       .attr("stroke-width",  0.15)
       .attr("stroke",  function(d) { return "#d3d3d3"; });

    svg.selectAll("text")
       .data(nodes)
       .enter()
       .append("text")
       .attr("x", function(d) { return x_scale(d['x']); })
       .attr("y", function(d) { return y_scale(d['y']); })
       .attr("dy", ".55em")
        .attr("fill","#d3d3d3")
       .attr("font-size", function(d){ console.log(d['font_size']); return d['font_size'] + "px";})
       .text(function(d){ return d['name']; });

    }

    var edges_{{id}} = {{edges}};
    var nodes_{{id}} = {{nodes}};

    draw(edges_{{id}}, nodes_{{id}}, svg_{{id}});

    function zoom_{{id}}() {
      svg_{{id}}.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
    }

}

{% include "load_d3.tpl" %}


</script>
{% endblock %}

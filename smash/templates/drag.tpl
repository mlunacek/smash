{% if standalone %}
{% extends 'base.tpl' %}
{% endif %}
{% block content %}
<div id="graph_{{id}}"></div>
<div id="save_{{id}}"></div>
<button class="btn btn-default" type="submit" onclick="set_value_{{id}}()">save</button>
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
var margin = {top: 50, right: 50, bottom: 50, left:50},
    width = {{width}} - margin.left - margin.right,
    height = {{height}} - margin.top - margin.bottom;

var svg_{{id}} = d3.select("#graph_{{id}}").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g");


graph_{{id}} = function(){



    // .call(d3.behavior.zoom().scaleExtent([0.75, 8]).on("zoom", zoom_{{id}}))
    // .append("g");
    //
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

    nodes.forEach(function(d) {
        d.x = x_scale(d.x);
        d.y = y_scale(d.y); 
    });
                    
    var node_map = {};
    var names = nodes.forEach(function(d){
        node_map[d.name] = d;
    });

    edges.forEach(function(d) {
        d.x1 = node_map[d.source].x;
        d.y1 = node_map[d.source].y;
        d.x2 = node_map[d.target].x;
        d.y2 = node_map[d.target].y;
      });


    var link = svg.append("g")
          .attr("class", "link")
          .selectAll("line")
          .data(edges)
          .enter()
          .append("line")
          .attr("x1", function(d) { return d.x1; })
          .attr("y1", function(d) { return d.y1; })
          .attr("x2", function(d) { return d.x2; })
          .attr("y2", function(d) { return d.y2; })
          .attr("stroke-width", function(d) { return d['stroke_width']; })
          .attr("stroke","#d3d3d3");

    var node = svg.append("g")
          .attr("class", "node")
          .selectAll("circle")
          .data(nodes)
          .enter()
          .append("circle")
          .attr("r",  function(d) { return d['size']; })
          .attr("fill",  function(d) { return d3.rgb(d['color'][0]*255,
                                                     d['color'][1]*255,
                                                     d['color'][2]*255); })
          .attr("stroke-width",  0.15)
          .attr("stroke",  function(d) { return "#d3d3d3"; })
          .attr("cx", function(d) { return d.x; })
          .attr("cy", function(d) { return d.y; })
          .call(d3.behavior.drag()
                .origin(function(d) { return d; })
                .on("drag", function(d) {
                      d.x = (d3.event.x);
                      d.y = (d3.event.y);
                      d3.select(this).attr("cx", d.x).attr("cy", d.y);
                      link.filter(function(l) { return l.source === d.name; }).attr("x1", d.x).attr("y1", d.y);
                      link.filter(function(l) { return l.target === d.name; }).attr("x2", d.x).attr("y2", d.y);
                      text.filter(function(t) { return t.name == d.name; }).attr("x", d.x).attr("y", d.y);
            }));
      
    var text = svg.append("g")
          .selectAll("text")
          .data(nodes)
          .enter()
          .append("text")
          .attr("font-size",  function(d) { return d.font_size + "px"; })
          .text(function(d){ return d.name; })
          .attr("x", function(d) { return d.x; })
          .attr("y", function(d) { return d.y; });






    //
    //
    // svg.selectAll("line")
    //    .data(edges)
    //    .enter()
    //    .append("line")
    //    .attr("x1", function(d) { return x_scale(d['x1']); })
    //    .attr("y1", function(d) { return y_scale(d['y1']); })
    //    .attr("x2", function(d) { return x_scale(d['x2']); })
    //    .attr("y2", function(d) { return y_scale(d['y2']); })
    //    .attr("stroke-width", function(d) { return d['stroke_width']; })
    //    .attr("stroke","#d3d3d3");
    //
    // svg.selectAll("circle")
    //    .data(nodes)
    //    .enter()
    //    .append("circle")
    //    .attr("cx", function(d) { return x_scale(d['x']); })
    //    .attr("cy", function(d) { return y_scale(d['y']); })
    //    .attr("r",  function(d) { return d['size']; })
    //    .attr("fill",  function(d) { return d3.rgb(d['color'][0]*255,
    //                                               d['color'][1]*255,
    //                                               d['color'][2]*255); })
    //    .attr("stroke-width",  0.15)
    //    .attr("stroke",  function(d) { return "#d3d3d3"; });
    //
    // svg.selectAll("text")
    //    .data(nodes)
    //    .enter()
    //    .append("text")
    //    .attr("x", function(d) { return x_scale(d['x']); })
    //    .attr("y", function(d) { return y_scale(d['y']); })
    //    .attr("dy", ".55em")
    //     .attr("fill","#d3d3d3")
    //    .attr("font-size", function(d){ console.log(d['font_size']); return d['font_size'] + "px";})
    //    .text(function(d){ return d['name']; });

    }

    var edges_{{id}} = {{edges}};
    var nodes_{{id}} = {{nodes}};

    draw(edges_{{id}}, nodes_{{id}}, svg_{{id}});

    function zoom_{{id}}() {
      svg_{{id}}.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
    }


}

function set_value_{{id}}(){
    var data = JSON.stringify(svg_{{id}}.selectAll('line').data())
    var command = "drag_line = " + data;
    var kernel = IPython.notebook.kernel;
    kernel.execute(command);
    
    var data = JSON.stringify(svg_{{id}}.selectAll('circle').data())
    var command = "drag = " + data;
    var kernel = IPython.notebook.kernel;
    kernel.execute(command);

}


{% include "load_d3.tpl" %}


</script>
{% endblock %}

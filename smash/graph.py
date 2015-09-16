import json
import networkx as nx

import smash
from base import smash_base

def get_edges(graph, pos, stroke_width):
    
    return [ {'x1': pos[x[0]][0], 
              'y1': pos[x[0]][1],
              'x2': pos[x[1]][0], 
              'y2': pos[x[1]][1],
              'stroke_width': stroke_width } for x in graph.edges()]

def get_nodes(graph, pos, size, font_size, colors, scale):
   
    fs = 0
    if not isinstance(font_size, dict):
        fs = font_size
        font_size = dict()
 
    return [ {'name': x,
              'object': 'node',
              'x': y[0], 
              'y': y[1], 
              'size': scale.get(x, 1.0)*size,
              'font_size': font_size.get(x, fs),
              'color': colors.get(x, smash._grey_default) } for x,y in pos.items() ]

@smash_base
def graph(data, **kwargs):

    pos = kwargs.get('pos')
    if not pos:
        try:
            pos = nx.graphviz_layout(data, prog="neato")
        except: 
            pos = nx.random_layout(data) 


    edge_json = get_edges(data, pos, 
                          kwargs.get('stroke_width', 1))


    nodes_json = get_nodes(data, pos, 
                           kwargs.get('size', 10),
                           kwargs.get('font_size', 0),
                           kwargs.get('colors', dict()),
                           kwargs.get('scale', dict()))

    return {'edges': json.dumps(edge_json), 
            'nodes': json.dumps(nodes_json)}


    





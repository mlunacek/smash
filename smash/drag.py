import json
import networkx as nx

import smash
from base import smash_base

def get_edges(g, stroke_width):
    return [ {'source': x[0], 'target': x[1], 'stroke_width': stroke_width } for x in g.edges()] 

def get_nodes(pos, size, font_size, colors, scale):
   
    fs = 0
    if not isinstance(font_size, dict):
        fs = font_size
        font_size = dict()
 
    return [ {'name': x,
              'x': y[0], 
              'y': y[1], 
              'size': scale.get(x, 1.0)*size,
              'font_size': font_size.get(x, fs),
              'color': colors.get(x, smash._grey_default) } for x,y in pos.items() ]

@smash_base
def drag(data, **kwargs):

    pos = kwargs.get('pos')
    if not pos:
        try:
            pos = nx.graphviz_layout(data, prog="neato")
        except: 
            pos = nx.random_layout(data) 


    edge_json = get_edges(data, 
                          kwargs.get('stroke_width', 1))


    nodes_json = get_nodes(pos, 
                           kwargs.get('size', 10),
                           kwargs.get('font_size', 0),
                           kwargs.get('colors', dict()),
                           kwargs.get('scale', dict()))

    return {'edges': json.dumps(edge_json), 
            'nodes': json.dumps(nodes_json)}


    





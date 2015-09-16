import os
import cytoolz
import subprocess
from IPython.core.display import display, HTML
import codecs

import smash

def smash_base(func):
    smash_base.count=0

    def wrapper(input_data, **kwargs):
        data = func(input_data, **kwargs)

        smash_base.count+=1
        index = smash._template_env().get_template("{}.tpl".format(func.__name__))
       
        d = {'d3_url': smash._d3_src,
             'horizon_url': smash._horizon_src,
             'id': smash_base.count,
             'func_name': func.__name__,
             'height': kwargs.get('height',  300),
             'width': kwargs.get('width',  700),
             'standalone': kwargs.get('standalone', False)}
        
        render_data = cytoolz.merge(d, data)

        if render_data['standalone']:
            return standalone(render_data, index)
        
        return notebook(render_data, index)

    return wrapper

def standalone(render_data, index):
    d3_src = os.path.join(smash.base_dir(), 'js', 'd3.v3.min.js') 
    horizon_src = os.path.join(smash.base_dir(), 'js', 'horizon.js') 
    render_data['d3'] = open(d3_src).read() 
    render_data['horizon'] = codecs.open(horizon_src).read()
    render_data['height'] = 500
    render_data['width'] = 1200
    output = index.render(render_data).decode('utf-8')
    filename = "{}.html".format(render_data['func_name'])

    with open(filename, 'w') as outfile:
        outfile.write(output)
    
    subprocess.Popen("open {}".format(filename), shell=True)
    return filename

def notebook(render_data, index):
    output = index.render(render_data)
    return display(HTML(output.decode('utf-8')))




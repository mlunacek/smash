
from graph import graph
from drag import drag
from parallel import parallel
from horizon import horizon


_d3_src = '/nbextensions/d3.v3.min.js' 
_horizon_src = '/nbextensions/horizon.js' 

_grey_default = (0.65, 0.64, 0.58)


def measured_real_power():
    import os
    return os.path.join(base_dir(), 'data', 'measured_real_power.csv')

def cars():
    import os
    return os.path.join(base_dir(), 'data', 'cars.csv')

def example_network():
    import os
    return os.path.join(base_dir(), 'data', 'edges.json')


def base_dir():
    """ returns the base dir of the project"""
    import os
    return os.path.abspath(os.path.dirname(__file__))

def _template_env():
    import os
    import jinja2 as jin
    return jin.Environment(loader=jin.FileSystemLoader(os.path.join(base_dir(), 'templates')))

def _copy_js():
    import os
    """ Copies javascript to ipython nbextension for loading in notebook"""
    try:
        from IPython.html import install_nbextension
    except ImportError:
        location = os.getcwd()
        nbextension = False
    else:
        nbextension = True

    d3_src = os.path.join(base_dir(), 'js', 'd3.v3.min.js') 
    hz_src = os.path.join(base_dir(), 'js', 'horizon.js') 
    
    jslib = [d3_src, hz_src]

    for src in jslib:

        if not os.path.exists(src):
            raise ValueError("src not found at '{0}'".format(src))

        if nbextension:
            try:
                install_nbextension(src, user=True)
            except IOError:
                # files may be read only. We'll try deleting them and re-installing
                from IPython.utils.path import get_ipython_dir
                nbext = os.path.join(get_ipython_dir(), "nbextensions")
                dest = os.path.join(nbext, os.path.basename(src))
                if os.path.exists(dest):
                    os.remove(dest)
                
                install_nbextension(src, user=True)

_copy_js()

# def load_d3():
#     import os
#     from IPython.display import display, HTML
#     base = os.path.abspath(os.path.dirname(__file__))
#     d3 = open(os.path.join(base, 'js', 'd3.v3.min.js')).read()
#     return display(HTML("""<script type="text/Javascript">{}</script>""".format(d3)))
# load_d3()



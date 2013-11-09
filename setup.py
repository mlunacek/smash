import os
import glob
from setuptools import setup

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

template_dir = os.path.join('smash','templates') 
datafiles = [(template_dir, [f for f in glob.glob(os.path.join(template_dir, '*'))])]

setup(
    name = "smash",
    version = "0.0.1",
    author = "Monte Lunacek",
    author_email = "monte.lunacek@gmail.com",
    description = ("A method for controlling d3 visualizations with pandas data."),
    license = "BSD",
    keywords = "pandas d3 python",
    url = "https://github.com/mlunacek/smash",
    packages=['smash'],
    long_description=read('README.md'),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
        "License :: OSI Approved :: BSD License",
    ],
    data_files = datafiles,
)

from setuptools import setup, find_packages
from os.path import join, dirname

setup(
    name='lab',
    version='0.1',
    include_package_data=True,
    packages=find_packages(),
    long_description=open(join(dirname(__file__), 'README.txt')).read(),
    entry_points={
        "console_scripts":
            ["lab_genarate = lab.generate:main",
             "lab_cashed = lab.cashed:main",
             "lab_dict = lab.defaultdict:main",
             "lab_fromjson = lab.from_json:main",
             "lab_logger = lab.logger:main",
             "lab_meta = lab.meta:main",
             "lab_metastring = lab.metastring:main",
             "lab_sort = lab.sort:main",
             "lab_seq = lab.seq:main",
             "lab_singleton = lab.singleton:main",
             "lab_tojson = lab.to_json:main",
             "lab_vector = lab.vector:main",
             "lab_xrange = lab.my_xrange:main"]
    }

)

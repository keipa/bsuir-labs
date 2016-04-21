import argparse
from generate import *
import to_json
import vector


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', "--program", default='generate')
    parser.add_argument('-n', "--nums",  default='0')
    parser.add_argument('-b', "--fixedblocks",  default='0')
    parser.add_argument('-l', "--fixedlines",  default='0')
    parser.add_argument('-s', "--symbols", default='0')
    parser.add_argument('-ls', "--lineseparator", default='\n')
    parser.add_argument('-t', "--blockseparator", default='\t')
    return parser


def menu(): 
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "generate":
        generate(int(namespace.fixedblocks),
                 namespace.blockseparator,
                 int(namespace.fixedlines),
                 namespace.lineseparator,
                 namespace.nums, int(namespace.symbols))
    if namespace.program == "vector":
        vector.main()
    if namespace.program == "json":
        to_json.main()


if __name__ == '__main__':
    menu()
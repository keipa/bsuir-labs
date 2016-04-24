import argparse

import generate
import to_json
import vector
import cashed
import logger
import my_xrange
import sort

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', "--program", default='generate')
    parser.add_argument('-n', "--nums",  default='0')
    parser.add_argument('-b', "--fixedblocks",  default='0')
    parser.add_argument('-l', "--fixedlines",  default='0')
    parser.add_argument('-s', "--symbols", default='0')
    parser.add_argument('-ls', "--lineseparator", default='\n')
    parser.add_argument('-t', "--blockseparator", default='\t')
    parser.add_argument('-i', "--input", default="strfiles/genrated.txt")
    parser.add_argument('-o', "--output", default="strfiles/sorted.txt")
    parser.add_argument('-bu', "--buffer", default='5000')

    return parser


def menu(): 
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "generate":
        generate.generate(int(namespace.fixedblocks),
                          namespace.blockseparator,
                          int(namespace.fixedlines),
                          namespace.lineseparator,
                          namespace.nums,
                          int(namespace.symbols))
    if namespace.program == "sort":
        sort.main(namespace.blockseparator,
                  namespace.lineseparator,
                  namespace.input,
                  namespace.output,
                  int(namespace.buffer))
    if namespace.program == "vector":
        vector.main()
    if namespace.program == "json":
        to_json.main()
    if namespace.program == "cashed":
        cashed.main()
    if namespace.program == "logger":
        logger.main()
    if namespace.program == "xrange":
        my_xrange.main()



if __name__ == '__main__':
    menu()
import argparse
import lab.defaultdict
import lab.generate
import lab.to_json
import lab.vector
import lab.cashed
import lab.logger
import lab.my_xrange
import lab.sort
# import lab.meta


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
    parser.add_argument('-k', "--keys", nargs="+", default=[])
    parser.add_argument('-r', "--reverse", action='store_true')
    parser.add_argument("--checked", action='store_true')

    return parser


def menu(): 
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "generate":
        lab.generate.generate(int(namespace.fixedblocks),
                          namespace.blockseparator,
                          int(namespace.fixedlines),
                          namespace.lineseparator,
                          namespace.nums,
                          int(namespace.symbols))
    if namespace.program == "sort":
        lab.sort.main(namespace.blockseparator,
                  namespace.lineseparator,
                  namespace.input,
                  namespace.output,
                  int(namespace.buffer),
                  namespace.reverse,
                  namespace.checked,
                  namespace.keys)
    if namespace.program == "vector":
        lab.vector.main()
    if namespace.program == "json":
        lab.to_json.main()
    if namespace.program == "cashed":
        lab.cashed.main()
    if namespace.program == "logger":
        lab.logger.main()
    if namespace.program == "xrange":
        lab.my_xrange.main()
    if namespace.program == "dict":
        lab.defaultdict.main()
    if namespace.program == "meta":
        lab.meta.main()

if __name__ == '__main__':
    menu()
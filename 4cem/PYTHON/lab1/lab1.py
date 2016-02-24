import fib,strproc,sorts,storage,sys,argparse



def createparser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p',"--program", default='fib')
    parser.add_argument('-t', "--type", nargs='?')
    parser.add_argument('-s', "--source", default='innums', nargs='?')
    return parser


def main():
    parser = createparser()
    namespace = parser.parse_args()
    if namespace.program == "sort":
        with open(namespace.source, 'r') as f:
            A = "7 5 5 433 3 5 7 32 2 5 78"
            if namespace.type == "quick":
                sorts.quicksort(f.read())
            elif namespace.type == "merge":
                sorts.mergesort(f.read())
            elif namespace.type == "digit":
                sorts.digitsort(f.read())
            elif namespace.type is None:
                sorts.quicksort(f.read())
            else:
                print("err Parameter -t")
    elif namespace.program == "fib":
        fib.fib()
    elif namespace.program == "string":
        if namespace.source == 'innums':
            namespace.source = 'intext'
        with open(namespace.source,'r') as f:
            if namespace.type is None:
                print("enter -t parameter *top*, *medium*,*average* or *repeats* ")
            elif namespace.type == "top":
                strproc.tkmrlng(f.read())
            elif namespace.type == "medium":
                strproc.mcwis(f.read())
            elif namespace.type == "average":
                strproc.acwis(f.read())
            elif namespace.type == "repeats":
                strproc.wr(f.read())
            elif namespace.type == "show":
                strproc.showSource(f.read())
            else:
                print("err no such parameter -t")
    elif namespace.program == "set":
        storage.initstorage()
    else:
        print("there is no such parameter")


if __name__ == '__main__':
    main()

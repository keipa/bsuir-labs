import sys


def main():
    c = 0
    s = raw_input()
    n = int(raw_input())
    l = [0] * len(s)
    r = [0] * len(s)
    if n == 0:
        sys.stdout.write(s)
        return 0

    for each in xrange(n):
        current = raw_input().split()
        le = int(current[0])-1
        ri = int(current[1])-1
        if le > ri:
            t = le
            le = ri
            ri = t
        l[le] += 1
        r[ri] += 1

    for each in xrange(len(s)):
        c += l[each]
        if c % 2 != 0:
            if s[each].islower():
                sys.stdout.write(s[each].upper())
            else:
                sys.stdout.write(s[each].lower())
        else:
            sys.stdout.write(s[each])
        c -= r[each]

    return 0

if __name__ == '__main__':
    main()
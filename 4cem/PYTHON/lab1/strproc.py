# word_repeats
def wr(st):
    st = str(st)
    words = st.split()
    repeat = dict()
    for each in words:
        repeat[each] = words.count(each)
    for each in repeat:
        print(each, ":", repeat[each])


# average_count_of_words_in_sentences
def acwis(st):

    sentences = st.split(".")
    counts = dict()
    a = 0
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a += counts[each]
    print("average: ", round(a/len(counts)))


# medium_count_of_words_in_sentences
def mcwis(st):
    sentences = st.split(".")
    counts = dict()
    a = list()
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a.append(counts[each])
    a.sort()
    print(a[round(len(a)/2)])


def showSource(st):
    print(st)


# top k most repeatable letter n-grams
def tkmrlng(st):
    k = ""
    n = ""

    while True:
        a = input("Use default settings?(y/n): ")
        if a == 'y':
            k = 10
            n = 4
            print("k = 10, n = 4")
            break
        if a == 'n':
            while not k.isdigit():
                k = input("Input K: ")
            while not n.isdigit():
                n = input("Input N: ")
            print("k = ", k,  ", n = ",n)
            break
    k = int(k)
    n = int(n)
    # print(k-n)
    gramcoll = dict()
    top = dict()
    allgramms = list()
    words = st.split()
    for each in words:
        gramword = dict()
        for i in range(0, len(each)-n+1):
                if len(each)-n+1 <= 0:
                    break
                gramword[i] = each[i:i+n]
                allgramms.append(each[i:i+n])
        gramcoll[each] = gramword
    # print(gramcoll)
    for gram in allgramms:
        top[gram] = allgramms.count(gram)
    # print(top)
    for i in range(1,k):
        fav = 0
        g = ""
        for each in top:
            if top[each] > fav:
                g = each
                fav = top[each]
        try:
            del top[g]
        except KeyError:
            print("K or N is too strange nums for this stroke restart the app")
            print("please, look at your input and think a little")
            print(st)
            break
        print(i, ") ", g, " - ", fav, "t.")


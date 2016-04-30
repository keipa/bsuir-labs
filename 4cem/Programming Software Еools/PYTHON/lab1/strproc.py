# word_repeats
def word_repeats(st):
    words = str(st).split()
    repeat = dict()
    for each in words:
        repeat[each] = 0
    for each in words:
        repeat[each] += 1
    for each in repeat:
        print(each, ":", repeat[each])


# average_count_of_words_in_sentences
def average_count_of_words_in_sentences(st):

    sentences = st.split(".")
    counts = dict()
    a = 0
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a += counts[each]
    print("average: ", round(a/len(counts)))


# median_count_of_words_in_sentences
def median_count_of_words_in_sentences(st):
    sentences = st.split(".")
    counts = dict()
    a = list()
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a.append(counts[each])
    a.sort()
    print(a[round(len(a)/2)])


def show_source(st):
    print(st)


# top k most repeatable letter n-grams
def top_most_repeat_letter_grams(st):
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
            print("k = ", k,  ", n = ", n)
            break
    k = int(k)
    n = int(n)
    # print(k-n)
    gram_collection = dict()
    top = dict()
    all_gram = list()
    words = st.split()
    for each in words:
        gram_word = dict()
        for i in range(0, len(each)-n+1):
                if len(each)-n+1 <= 0:
                    break
                gram_word[i] = each[i:i+n]
                all_gram.append(each[i:i+n])
        gram_collection[each] = gram_word
    for gram in all_gram:
        top[gram] = all_gram.count(gram)
    for i in range(1, k):
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

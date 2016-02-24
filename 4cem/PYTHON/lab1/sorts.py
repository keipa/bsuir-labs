def prepfqs(st):
    st = str(st)
    nums = st.split()
    for i in range(0, len(nums)):
        nums[i] = int(nums[i])
    print(nums)
    print("sort")
    return nums


###################################################################
def algquicksort(lst):
    if len(lst) <= 1:
        return lst
    smaller = [x for x in lst[1:] if x < lst[0]]
    larger = [x for x in lst[1:] if x >= lst[0]]
    return algquicksort(smaller) + [lst[0]] + algquicksort(larger)


def quicksort(st):
    # print(prepfqs(st))
    print(algquicksort(prepfqs(st)))


###################################################################
def mergesort(st):
    algmergesort(prepfqs(st))


def algmergesort(alist):
    print("Splitting ", alist)
    if len(alist) > 1:
        mid = len(alist)//2
        lefthalf = alist[:mid]
        righthalf = alist[mid:]

        algmergesort(lefthalf)
        algmergesort(righthalf)

        i = 0
        j = 0
        k = 0
        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                alist[k] = lefthalf[i]
                i += 1
            else:
                alist[k] = righthalf[j]
                j += 1
            k += 1

        while i < len(lefthalf):
            alist[k] = lefthalf[i]
            i += 1
            k += 1

        while j < len(righthalf):
            alist[k] = righthalf[j]
            j += 1
            k += 1
    print("Merging ", alist)


###################################################################
# не ест float (45.1321)
# для работы заменить в prepfqs(5) float → int
def algdigitsort(A):
    # print(A)
    # A = [12, 5, 664, 63, 5, 73, 93, 127, 432, 64, 34]
    # print(A)
    length = len(str(max(A)))
    rang = 10
    for i in range(length):
        B = [[] for k in range(rang)]
        for x in A:
            figure = x // 10**i % 10
            B[figure].append(x)
        A = []
        for k in range(rang):
            A += B[k]
    print(A)

def digitsort(str):

    algdigitsort(prepfqs(str))
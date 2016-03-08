def prepare_for_sort(st):
    st = str(st)
    nums = st.split()
    for i in range(0, len(nums)):
        nums[i] = int(nums[i])
    print(nums)
    print("sort")
    return nums


# list comprehension
###################################################################
def algorithm_quick_sort(lst):
    if len(lst) <= 1:
        return lst
    smaller = [x for x in lst[1:] if x < lst[0]]
    larger = [x for x in lst[1:] if x >= lst[0]]
    return algorithm_quick_sort(smaller) + [lst[0]] + algorithm_quick_sort(larger)


def quick_sort(st):
    print(algorithm_quick_sort(prepare_for_sort(st)))


###################################################################
def merge_sort(st):
    algorithm_merge_sort(prepare_for_sort(st))


def algorithm_merge_sort(sorting_list):
    print("Splitting ", sorting_list)
    if len(sorting_list) > 1:
        mid = len(sorting_list) // 2
        left_half = sorting_list[:mid]
        right_half = sorting_list[mid:]

        algorithm_merge_sort(left_half)
        algorithm_merge_sort(right_half)

        i = 0
        j = 0
        k = 0
        while i < len(left_half) and j < len(right_half):
            if left_half[i] < right_half[j]:
                sorting_list[k] = left_half[i]
                i += 1
            else:
                sorting_list[k] = right_half[j]
                j += 1
            k += 1

        while i < len(left_half):
            sorting_list[k] = left_half[i]
            i += 1
            k += 1

        while j < len(right_half):
            sorting_list[k] = right_half[j]
            j += 1
            k += 1
    print("Merging ", sorting_list)


###################################################################
# не ест float (45.1321)
# для работы заменить в (5) float → int
def algorithm_digit_sort(sorting_list):
    length = len(str(max(sorting_list)))
    rang = 10
    for i in range(length):
        b = [[] for _ in range(rang)]
        for x in sorting_list:
            figure = x // 10**i % 10
            b[figure].append(x)
        sorting_list = []
        for k in range(rang):
            sorting_list += b[k]
    print(sorting_list)


def digit_sort(string):
    algorithm_digit_sort(prepare_for_sort(string))

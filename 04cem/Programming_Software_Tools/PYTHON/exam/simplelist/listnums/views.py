from django.shortcuts import render
from django.http import HttpResponse


# Create your views here.
def simple_num(request, kek):
    nums = [x+1 for x in range(1, int(kek))]
    snums = []

    snums.append(nums[0])
    howmuchn = nums[len(nums)-1]//snums[len(snums)-1]
    nums.remove(nums[0])
    while howmuchn > 1:
        for i in range(1, howmuchn):
            try:
                nums.remove(i*snums[len(snums)-1])
            except:
                pass
        snums.append(nums[0])
        howmuchn = nums[len(nums) - 1] // snums[len(snums) - 1]
        nums.remove(nums[0])
    snums +=nums
    return render(request, "nums.html", {'nums': snums})

from django.shortcuts import render
from django.template import RequestContext
# Create your views here.


def contact(request):
    if request.method == "POST":
        print(request.POST['name'])
        print(request.POST['message'])
        message = "THNX"
        return render(request, "contact.html", {'success':message}, context_instance=RequestContext(request))
    else:
        return render(request, "contact.html", {}, context_instance=RequestContext(request))
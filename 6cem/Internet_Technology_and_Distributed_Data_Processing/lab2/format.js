function Fibonacci() {
    var a = 0, b = 1, c;
    document.write("Fibonacci");
    while (b <= 10) {
        document.write(c);
        document.write("<br/>");
        c = a + b;
        a = b;
        b = c;
    }
}

function Palindrome() {
    var revStr = "";
    var str = document.getElementById("str").value;
    var i = str.length;
    for (var j = i; j >= 0; j--) {
        revStr = revStr + str.charAt(j);
    }
    if (str == revStr) {
        alert(str + " -is Palindrome");
    } else {
        alert(str + " -is not a Palindrome");
    }
}
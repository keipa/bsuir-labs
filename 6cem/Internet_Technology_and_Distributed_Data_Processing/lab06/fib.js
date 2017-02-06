/**
 * Created by keipa on 2/4/2017.
 */


//4-2-2017

// Вычисление и вывод i-го числа Фибоначчи, где параметр i вводится
// пользователем. При вводе некорректных данных предусмотреть генерацию
// исключительной ситуации.

function getint(message, limit) {
    while (true) {
        var value = +prompt("Введите " + message, '');
        if (!value || value <= 0 || value > limit) alert('Неверный ввод - повторите');
        else return value;
    }
}

function fib(n) {
    var a = 1,
        b = 1;
    for (var i = 3; i <= n; i++) {
        var c = a + b;
        a = b;
        b = c;
    }
    return b;
}

alert(fib(getint('номер i-го числа Фибоначчи', 1476)));// input more that 1476 returns Infinity
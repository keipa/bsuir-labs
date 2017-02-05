/**
 * Created by keipa on 2/5/2017.
 */


// Декоратор функции получает на вход существующую функцию и
// возвращает новую функцию, изменяющую (дополняющую) поведение
// исходной.
// 2. Создать декоратор для функции с произвольным количеством
// параметров, дополняющий переданную функцию проверкой всех аргумента на
// указанный тип.


function numCheck(value, checking_type) {
    return typeof value == checking_type;
}

function typeCheck(f, checks, checking_type) {
    return function () {
        for (var i = 0; i < arguments.length; i++) {
            if (!checks(arguments[i], checking_type)) alert("Некорректный тип");
            else return f.apply(this, arguments);
        }
    }
}

function num() {
    return "hello";
}

num = typeCheck(num, numCheck, 'number');

alert(num(1));
alert(num(1, 3, 4, 5));
alert(num(num()));
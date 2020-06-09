/**
 * Created by keipa on 2/5/2017.
 * @return {boolean}
 */


// Декоратор функции получает на вход существующую функцию и
// возвращает новую функцию, изменяющую (дополняющую) поведение
// исходной.
// 2. Создать декоратор для функции с произвольным количеством
// параметров, дополняющий переданную функцию проверкой всех аргумента на
// указанный тип.


function Check(value, checking_type = 'number') {
    return typeof value == checking_type;
}

function typeCheck(f, checks, checking_type) {
    return function () {
        for (var i = 0; i < arguments.length; i++) if (!checks(arguments[i], checking_type)) console.log("Некорректный тип");
        else return f.apply(this, arguments);
    }
}

function num(
...
m
)
{
    return "hello";
}

num = typeCheck(num, Check, 'number');

console.log(num(1));
console.log(num(1, 3, 4, 5));
console.log(num(num()));
/**
 * Created by keipa on 2/5/2017.
 */

// Напишите функцию range(), принимающую два аргумента, начало и конец
// диапазона, и возвращающую массив, который содержит все числа из диапазона,
// включая начальное и конечное. Третий необязательный аргумент функции
// range() – шаг для построения массива. Убедитесь, что функция range() работает
// с отрицательным шагом: например, вызов range(5, 2, -1) возвращает [5, 4, 3, 2].


function myrange(start, finish, step) {
    if (typeof step !== 'number') step = 1;
    if ((start > finish && step > 0) || (start < finish && step < 0) || step === 0) return;
    var a = [];
    if (step > 0) for (var i = start; i <= finish; i += step) a.push(i);
    else for (var i = start; i >= finish; i += step) a.push(i);
    return a;
}

alert(myrange(5, 2, -1));
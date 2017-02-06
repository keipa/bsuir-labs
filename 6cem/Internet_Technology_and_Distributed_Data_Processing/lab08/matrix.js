/**
 * Created by keipa on 2/5/2017.
 */

// Создать функцию createMatrix(), принимающую количество строк и
// количество столбцов матрицы и возвращающее матрицу (массив массивов),
// заполненную случайными числами в диапазоне от 0 до 100. Написать функцию,
// выполняющую суммирование двух таких «матриц».

function randomInteger(min, max) {
    var rand = min + Math.random() * (max - min);
    rand = Math.round(rand);
    return rand;
}

function createMatrix(rows, columns) {
    var a = [];
    for (var i = 0; i < rows; i++) {
        var b = [];
        for (var j = 0; j < columns; j++) {
            b.push(randomInteger(0, 10));
        }
        a.push(b);
    }
    return a;
}

function sumMatrix(left, right) {
    var sum = [];
    for (var i = 0; i < left.length; i++) {
        sum.push([]);
        for (var j = 0; j < left[i].length; j++) {
            sum[i].push(left[i][j] + right[i][j]);
        }

    }
    return sum;
}

a = createMatrix(5, 5);
b = createMatrix(5, 5);
console.log(a);
console.log(b);

console.log(sumMatrix(a, b));

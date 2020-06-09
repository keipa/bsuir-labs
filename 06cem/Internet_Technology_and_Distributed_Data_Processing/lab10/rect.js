/**
 * Created by keipa on 2/5/2017.
 */


// 5-2-2017


// На декартовой плоскости прямоугольник задаётся четырьмя точками –
// своими вершинами (у каждой точки две числовые координаты). Вершины
// перечисляются последовательно, в порядке обхода по часовой стрелке,
//начиная
// с произвольной вершины.
// 1. Написать функцию, проверяющую, образуют ли заданные восемь
// чисел вершины некоего прямоугольника.
// 2. Написать функцию, проверяющую принадлежность указанной точки
// заданному прямоугольнику.


//допускаю, что стороны прямоугольника параллельны осям

function getint(message, limit=100000) {
    while (true) {
        var value = +prompt("Введите " + message, '');
        if (!value || value > limit) console.log('Неверный ввод - повторите');
        else return value;
    }
}

var is_vertical = false;
var a1 = getint("точку a1");
var a2 = getint("точку a2");
var b1 = getint("точку b1");
var b2 = getint("точку b2");
var c1 = getint("точку c1");
var c2 = getint("точку c2");
var d1 = getint("точку d1");
var d2 = getint("точку d2");
var coordinates = [[a1, a2], [b1, b2], [c1, c2], [d1, d2]];

if (coordinates[0][0] === coordinates[2][0] || coordinates[0][1] === coordinates[2][1]) {
    console.log("not a rect");
    throw "export";
}
if (coordinates[0][0] === coordinates[1][0]) is_vertical = true;
if (is_vertical) {
    if (coordinates[0][0] === coordinates[1][0] &&
        coordinates[1][1] === coordinates[2][1] &&
        coordinates[2][0] === coordinates[3][0] &&
        coordinates[3][1] === coordinates[0][1])
        console.log("it is a rect");
    else  console.log("not a rect");

} else {
    if (coordinates[0][1] === coordinates[1][1] &&
        coordinates[1][0] === coordinates[2][0] &&
        coordinates[2][1] === coordinates[3][1] &&
        coordinates[3][0] === coordinates[0][0])
        console.log("it is a rect");
    else  console.log("not a rect");
}


if (getint("1 чтобы перейти ко второму заданию:") === 1) {
    if (issitting_in_rect([getint("x "), getint("y")], coordinates))
        console.log("ваша точка принадлежит прямоугольнику");
    else console.log("ваша точка ****НЕ**** принадлежит прямоугольнику");
}

function issitting_in_rect(xy, coords) {
    var min_xy, max_xy;
    if (coords[0][0] < coords[2][0] && coords[0][1] < coords[2][1]) {
        min_xy = coords[0];
        max_xy = coords[2];
    }
    else {
        min_xy = coords[1];
        max_xy = coords[3];
    }
    return !!(min_xy[0] <= xy[0] &&
    min_xy[1] <= xy[1] &&
    max_xy[0] >= xy[0] &&
    max_xy[1] >= xy[1]);
}











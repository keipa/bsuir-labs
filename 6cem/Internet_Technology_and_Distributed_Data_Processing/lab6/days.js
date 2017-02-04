/**
 * Created by keipa on 2/4/2017.
 */


// 4-2-2017

// 1 января 2015 года – это был четверг. Скрипт запрашивает номер месяца
// (1..12) и число в этом месяце (1..31). Выведите имя дня недели.


function getint(message, limit) {
    while (true) {
        var value = +prompt("Введите " + message, '');
        if (!value || value <= 0 || value > limit) alert('Неверный ввод - повторите');
        else return value;
    }
}

var year = getint("год");
var month = getint("номер месяца", 12);
var day = getint("день месяца", 31);
var date = new Date(year, month - 1, day);

var days = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"];
alert(day + "-" + month + "-" + year + " года – это  " + days[date.getDay()]);
/**
 * Created by keipa on 2/4/2017.
 */

//4-2-2017

// Многоквартирный дом характеризуется следующими тремя показателями:
// этажность, число подъездов, количество квартир на этаже. Скрипт запрашивает
// эти показатели и номер квартиры. Выводится номер подъезда, в котором
// находится указанная квартира. При вводе некорректных данных предусмотреть
// генерацию исключительных ситуаций.

//input
//этажность, число подъездов, количество квартир на этаже.
//apartment Number
//output
//porch num

function getint(message, limit) {
    while (true) {
        var value = +prompt("Введите " + message, '');
        if (!value || value <= 0 || value > limit) alert('Неверный ввод - повторите');
        else return value;
    }
}


var floor = getint("этажность", 163); //Burj_Khalifa
var porch = getint("число подъездов", 1000000);
var apartments_at_floor = getint("количество квартир на этаже", 1000000);
var count_of_apartments = floor * porch * apartments_at_floor;
var searching_apartment = getint("номер квартиры (0 - " + count_of_apartments + ")", count_of_apartments);
var apartments_in_porch = floor * apartments_at_floor;
var search = 0;

for (var i = 0; i < porch; i++) {
    search += apartments_in_porch;
    if (search >= searching_apartment) {
        alert(i + 1);
        break;
    }
}

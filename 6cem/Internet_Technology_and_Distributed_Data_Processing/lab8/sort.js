/**
 * Created by keipa on 2/5/2017.
 */
// Самостоятельно реализуйте любой алгоритм сортировки массива.
// Желательно, чтобы ваша функция сортировки могла принимать компаратор для
// сравнения элементов (как это делает стандартный метод sort()).

var a = [34, 203, 3, 746, 200, 984, 198, 764, 9];
var b = [[34, 21], [203, 4], [3, 0], [746, 14], [200, 201], [984, 84], [198, 12], [764, 417], [9, 0]];


function sorting(a, comporator) {
    var swapped;
    do {
        swapped = false;
        for (var i = 0; i < a.length - 1; i++) {
            if (comporator(a[i], a[i + 1])) {
                var temp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = temp;
                swapped = true;
            }
        }
    } while (swapped);
}

function num_compare(left, right) {
    return left > right;
}

function array_compare(left, right) {
    return left[1] > right[1];
}

sorting(a, num_compare);
console.log(a);

sorting(b, array_compare);
console.log(b);

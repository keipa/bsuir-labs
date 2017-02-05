/**
 * Created by keipa on 2/5/2017.
 */
// Создайте класс Vector для представления вектора в трехмерном
// пространстве (свойства для координат x, y, z). Добавьте в прототип Vector два
// метода plus() и scalar() для вычисления суммы двух векторов и скалярного
// произведения двух векторов. Добавьте в прототип свойство только для чтения
// length, подсчитывающее длину вектора. Переопределите в классе Vector методы
// toString() и valueOf(). Протестируйте созданный класс.


class Vector {

    constructor(x, y, z) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.toString = function () {
            return String("Vector : [ " + [this.x, this.y, this.z] + " ]")
        };
        this.valueOf = function () {
            return "[Object Vector]"
        };
    }

    get length() {
        return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
    }

    set length(value) {
        console.log("this property is read-only");
    }


    plus(vec) {
        this.x += vec.x;
        this.y += vec.y;
        this.z += vec.z;
        return 0;
    }

    scalar(vec) {
        return this.x * vec.x + this.y * vec.y + this.z * vec.z;
    }
}

let a = new Vector(1, 2, 3);
let b = new Vector(4, 5, 6);

a.length = 2017;
console.log(a.length);
console.log(a.toString());
console.log(a.valueOf());
console.log(a.scalar(b));
console.log(a.plus(b));
console.log(a.toString());













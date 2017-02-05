/**
 * Created by keipa on 2/5/2017.
 */


// Задача имеет название, описание, дату начала и дату окончания. Любая
// задача может иметь набор дочерних подзадач. Создайте класс для
// представления задачи.
// Выполняемая задача – наследник задачи с дополнительным свойствами:
// процент выполнения (число) и флагом задача завершена. Реализуйте данное
// наследование.


class Task {

    constructor(name, startdate, enddate) {
        this.name = name;
        this.startdate = startdate;
        this.enddate = enddate;
        this.subtasks = [];
    }

    addtasks(task) {
        this.subtasks.push(task);
    }
}

class RunningTask extends Task {
    constructor(name, startdate, enddate) {
        super(name, startdate, enddate);
        this.precentage = 0;
        this.isready = false;
    }

}

let a = new Task("a", 1, 2);
let b = new RunningTask("b", 3, 4);
b.precentage = 10;
a.addtasks(b);
console.log(a);





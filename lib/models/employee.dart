//import 'package:last/models/basic_data/date.dart';

import '../models/Human.dart';

class Employee extends Human {
  int worksHour;
  int costAtTheHour;
  double salary;
  String email;
  String password;
  DateTime startWork;

  get getWorksHour => this.worksHour;

  set setWorksHour(worksHour) => this.worksHour = worksHour;

  get getCostAtTheHour => this.costAtTheHour;

  set setCostAtTheHour(costAtTheHour) => this.costAtTheHour = costAtTheHour;

  get getSalary => this.salary;

  set setSalary(salary) => this.salary = salary;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getStartWork => this.startWork;

  set setStartWork(startWork) => this.startWork = startWork;

  Employee.employee() : super.human();

  Employee({
    String id,
    String name,
    String phoneNumber,
    String sex,
    String birthday,
    this.worksHour,
    this.costAtTheHour,
    this.email,
    this.password,
    this.startWork,
    this.salary,
  }) : super(id, name, birthday, phoneNumber, sex);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'phoneNumber': this.phoneNumber,
        'sex': this.sex,
        'worksHour': this.worksHour,
        'costAtTheHour': this.costAtTheHour,
        'email': this.email,
        'password': this.password,
        'startWork': this.startWork,
        'salary': this.salary,
      };
}

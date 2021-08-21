class Human {
  String id;
  String name;
  String birthday;
  String phoneNumber;
  String sex;

  Human.human();
  Human(this.id, this.name, this.birthday, this.phoneNumber, this.sex);
  String get getSex => this.sex;

  set setSex(String sex) => this.sex = sex;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getBirthday => this.birthday;

  set setBirthday(birthday) => this.birthday = birthday;

  get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;
}

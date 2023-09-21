class Person {
  String name;
  int age;
  Address address;

  Person({required this.name, required this.age, required this.address});
}

class Address {
  String village;
  int postCode;
  String thana;
  String district;
  String division;

  Address(
      {required this.village,
      required this.postCode,
      required this.thana,
      required this.district,
      required this.division});
}

Person person3 = Person(
    name: 'Tanvir',
    age: 20,
    address: Address(
        village: 'Sukundi',
        postCode: 1650,
        thana: 'Kapasia',
        district: 'Gazipur',
        division: 'Dhaka'));

// Person person1 = Person(name: 'Kamal', age: 31, village: 'Khirati');
// Person person2 = Person(name: 'Sakib', age: 22, village: 'Kapasia');

void main() {
  print(person3.name);
  print(person3.age);
  print(person3.address.thana);
}

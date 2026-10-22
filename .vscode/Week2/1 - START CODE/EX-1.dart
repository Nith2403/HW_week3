enum Skill { FLUTTER, DART, OTHER }


class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee(
    this._name,
    this._baseSalary,
    this._skills,
    this._address,
    this._yearsOfExperience,
  );

  Employee.mobileDeveloper(
    String name,
    Address address,
    int yearsOfExperience,
  ) : this(
          name,
          40000,
          [Skill.FLUTTER, Skill.DART],
          address,
          yearsOfExperience,
        );



  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  void printDetails() {
    print('Employee: $_name, Base Salary: \$$_baseSalary');
  }


double calculateSalary() {
  double salary = _baseSalary;

  salary = salary + (_yearsOfExperience * 2000);

  for (Skill skill in _skills) {
    if (skill == Skill.FLUTTER) {
      salary = salary + 5000;
    } else if (skill == Skill.DART) {
      salary = salary + 3000;
    } else {
      salary = salary + 1000;
    }
  }

  return salary ;
  }

}
class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  Address(this._street, this._city, this._zipCode);

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;
}


void main() {
  Address address = Address('Street 1', 'Phnom Penh', '12000');

  Employee emp1 = Employee.mobileDeveloper('Sokea', address, 2);
  emp1.printDetails();
  print('Total salary: \$${emp1.calculateSalary()}');

  Employee emp2 = Employee.mobileDeveloper('Ronan', address, 1);
  emp2.printDetails();
  print('Total salary: \$${emp2.calculateSalary()}');
}
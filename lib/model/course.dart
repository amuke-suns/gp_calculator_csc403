class Course {
  String? name;
  int? units;
  String? _grade;

  int? _gradeUnit;

  String? get grade => _grade;
  int? get gradeUnit => _gradeUnit;

  set grade(String? grade) {
    _grade = grade;

    switch (grade) {
      case 'A':
        _gradeUnit = 5;
        break;
      case 'B':
        _gradeUnit = 4;
        break;
      case 'C':
        _gradeUnit = 3;
        break;
      case 'D':
        _gradeUnit = 2;
        break;
      case 'E':
        _gradeUnit = 1;
        break;
      case 'F':
        _gradeUnit = 0;
        break;
      default:
        _gradeUnit = null;
    }
  }

  Course({
    this.name,
    this.units,
  });

  @override
  String toString() {
    return '$name, $units, $grade';
  }
}

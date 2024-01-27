class Validators {
  static String? validateCourseName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Specify name';
    } else if(name.trim().length <= 2) {
      return 'Too short';
    } else {
      return null;
    }
  }

  static String? validateUnit(int? value) {
    if (value == null) {
      return 'Select an option';
    } else {
      return null;
    }
  }

  static String? validateGrade(String? value) {
    if (value == null) {
      return 'Select an option';
    } else {
      return null;
    }
  }
}
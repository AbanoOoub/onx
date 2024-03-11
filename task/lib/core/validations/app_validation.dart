class AppValidator {
  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'password required';
    }
    return null;
  }

  static String? userIdValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'userId required';
    } else if (value.isNotEmpty && value.length < 4) {
      return 'userId must be at least 4 numbers';
    }
    return null;
  }
}

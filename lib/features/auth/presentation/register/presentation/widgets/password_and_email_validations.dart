class PasswordAndEmailValidations {
  static bool isValidEmail({required String email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }

  static bool hasANumber(String password) {
    RegExp regex = RegExp(r'(?=.*?[0-9])');
    return regex.hasMatch(password);
  }
  static bool hasAValidPhoneNumber(String phone) {
    RegExp regex = RegExp(r'^(\+201|01|00201)[0-2,5]{1}[0-9]{8}');
    return regex.hasMatch(phone);
  }

  static bool hasUpperLetter(String password) {
    RegExp regex = RegExp(r'(?=.*[A-Z])');
    return regex.hasMatch(password);
  }

  static bool hasLowerLetter(String password) {
    RegExp regex = RegExp(r'(?=.*[a-z])');
    return regex.hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    RegExp regex = RegExp(r'(?=.*?[!@#\$&*~])');
    return regex.hasMatch(password);
  }

  static bool hasMinimumLength(String password) {
    RegExp regex = RegExp(r'.{8,}');
    return regex.hasMatch(password);
  }

  static bool hasMatchedPassword(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) return false;
    return password == confirmPassword;
  }
}

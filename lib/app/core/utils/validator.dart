class Validator {
  static var emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool checkEmail(String email) {
    return emailValidator.hasMatch(email.trim());
  }

  static String? commonValidation(String value, String messageError) {
    if (value.isEmpty) {
      return messageError;
    }
    else{
      return null;
    }
  }

  static String? passwordValidation(String value, String messageError) {
    if (value.isEmpty) {
      return messageError;
    } else if (!(value.length > 5) && value.isNotEmpty) {
      return "Password must be at least 6 characters!";
    } else {
      return null;
    }
  }
}

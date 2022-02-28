String? validateEmail(String? value) {
  if (value != null) {
    if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
      return null;
    }
    return 'Enter a Valid Email Address';
  }
}

/// check if the string contains only numbers
String? isNumeric(String? str) {
  RegExp _numeric = RegExp(r'^-?[0-9]+$');
  if (str != null) {
    if (str.length < 9) {
      return "Passowrd too short";
    } else if (_numeric.hasMatch(str)) {
      return "Password too weak, consider using letters.";
    }
    return null;
  }
}

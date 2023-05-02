class ValidationsLogin{
  String validateUsername(String value) {
    if (value.isEmpty) return 'Username is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z0-9_.-]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

    String validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please insert a password.';
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) return 'Phone is required';
    // final RegExp nameExp = new RegExp(r'^[0-9]{13}$');
    // if (!nameExp.hasMatch(value))
    //   return 'Please enter only number';
    return null;
  }

String validateResi(String value) {
    if (value.isEmpty) return 'Field is required';
    // final RegExp nameExp = new RegExp(r'^[0-9]{13}$');
    // if (!nameExp.hasMatch(value))
    //   return 'Please enter only number';
    return null;
  }

}
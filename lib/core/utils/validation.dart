class Validation {

  static String? validateEmailTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateNumberTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Number';
    }
    final phoneRegex = RegExp(r'^01\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid Number';
    }
    return null;
  }

  static String? validateRegularTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }

    return null;
  }
  static String? validateCardNumberTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }else if (value.length!=4){
      return 'please enter 4 digits';
    }

    return null;
  }
  static String? validatePinTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }else if (value.length!=1){
      return 'please enter 1 digits';
    }

    return null;
  }
  static String? validateCVVNumberTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }else if (value.length!=3){
      return 'please enter CVV correctly';
    }

    return null;
  }
  static String? validateExpDateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }else if (value.length!=5){
      return 'please enter Expiration date correctly';
    }else if (int.parse(value.split("/")[0])<=0){
      return 'Cant enter negative or zero month';
    }else if (int.parse(value.split("/")[0])>12){
      return 'Cant enter month greater than 12';
    }else if (int.parse(value.split("/")[1])<24){
      return 'That card is not a valid';
    }

    return null;
  }

  static String? validatePasswordTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s])[A-Za-z\d[^\W]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one small letter, one capital letter, one number and one special character';
    }
    return null;
  }
}
class ValidatorMixin {
  String? nameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter a name";
    } else if (val.length < 3) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  String? messageValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter any message";
    } else {
      return null;
    }
  }

  String? phoneValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter a phone number";
    } else if (val.length < 10) {
      return "Please enter a valid phone number";
    } else {
      return null;
    }
  }

  String? emailValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter a phone number";
    } else if (RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)) {
      return null;
    } else {
      return "Please enter a valid email";
    }
  }
}

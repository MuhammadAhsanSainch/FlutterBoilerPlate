String? validateEmail(value) {
  String? msg;
  RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    msg = "Your email address is required";
  } else if (!regex.hasMatch(value)) {
    msg = "Please provide a valid email address";
  }
  return msg;
}

String? validatePassword(String? value) {
  String? msg;
  if (value!.isEmpty) {
    msg = "Password is required";
  } else if (value.length < 8) {
    msg = "Password should be 8 characters";
  }
  return msg;
}

String? validateConfirm(String? pwd, String? confirmPwd) {
  String? msg;
  if (confirmPwd!.isEmpty) {
    msg = "Password is required";
  } else if (pwd != confirmPwd) {
    msg = "Confirm Password does not matched.";
  }
  return msg;
}

String? validatePhoneNum(String? value) {
  String? msg;
  if (value!.isEmpty) {
    msg = "Phone Number is required.";
  } else if (value.length < 12) {
    msg = "Phone Number must be greater than 12 character.";
  }
  return msg;
}

String? validateInputData(value, validatorRequired) {
  String? msg;
  if (validatorRequired == true) {
    if (value == null || value == "") {
      msg = "This field is required.";
    }
  }
  return msg;
}

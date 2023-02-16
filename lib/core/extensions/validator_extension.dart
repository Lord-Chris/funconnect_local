import 'package:flutter/material.dart';

extension ValidatorExtension on BuildContext {
  String? validateNotEmpty(String? value) {
    return (value ?? "").isEmpty ? 'Field cannot be empty' : null;
  }

  String? validateNotNull(String? value) {
    return value == null ? 'Field cannot be empty' : null;
  }

  String? validateLength(String? value, int length) {
    if (value != null && value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value!.length < length) {
      return 'Field must be at least 3 characters long';
    } else {
      return null;
    }
  }

  String? validateFullName(String? value) {
    return value != null && value.split(' ').length < 2
        ? 'Enter your first and last name'
        : null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email address';

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? 'Enter a Valid Email Address' : null;
  }

  String? validateNotNullEmail(String? value) {
    if (value == null) return 'Please enter an email address';

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return value.isEmpty
        ? null
        : !emailValid
            ? 'Enter a Valid Email Address'
            : null;
  }

  String? validatePhoneNumber(String? value) =>
      value != null && value.length < 10 ? 'Enter a Valid Phone Number' : null;

  String? validatePassword(String? value) => value == null || value.length < 6
      ? 'Password should be more than 5 Characters'
      : null;

  String? validateLink(String? val) {
    if (val == null || val.isEmpty) return null;
    if (!val.startsWith("http") && !val.startsWith("www")) {
      return "Link must start with http or www";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) =>
      value != null && value != password ? 'Passwords do not match' : null;

  String? validateOtp(String? value) =>
      value != null && value.length == 6 ? null : 'Enter valid OTP';

  String? validateGender(String? value) => value != null && value == 'Gender'
      ? 'Choose one of male or female'
      : null;
}

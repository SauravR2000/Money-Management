String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.contains(' ')) {
    return 'Password cannot contain spaces';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (value.length > 16) {
    return 'Password must not exceed 16 characters';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null; // Valid password
}

String? validateConfirmPassword(
  String? confirmPassword,
  String? password,
) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm Password cannot be empty';
  }

  if (confirmPassword != password) {
    return "Confirm password didn't match with password";
  }

  return null;
}

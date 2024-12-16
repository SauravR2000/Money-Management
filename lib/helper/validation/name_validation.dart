String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  }
  // Ensure the name contains only alphabets and spaces
  if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
    return 'Name can only contain alphabets and spaces';
  }
  // Check minimum and maximum length constraints
  if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }
  if (value.length > 50) {
    return 'Name cannot be more than 50 characters';
  }
  return null; // Valid name
}

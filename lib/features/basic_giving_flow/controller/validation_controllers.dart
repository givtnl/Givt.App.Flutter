postCodeValidation(value) {
  bool isZipValid = false;
  if (value != null && value.isEmpty == false) {
    isZipValid =
        RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false)
            .hasMatch(value);
    if (isZipValid) {
      // yay zip is valid
      return null;
    }
  }
  return 'Not a Valid Post Code';
}

nameValidation(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the cardholders\' name';
  }
  if (value.length > 30) {
    return 'Cannot exceed 30 characters';
  }
  return null;
}

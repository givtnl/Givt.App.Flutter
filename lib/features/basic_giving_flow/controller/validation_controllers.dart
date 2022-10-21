postCodeValidation(value) {
  bool isZipValid = false;
  if (value != null && value.isEmpty == false) {
    isZipValid = isZipValid =
        RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false)
            .hasMatch(value);
    print(isZipValid);
    if (isZipValid) {
      // yay zip is valid
      return null;
    }
  }
  return 'Not a Valid Post Code';
}

nameValidation(value) {
  if (value == null || value.isEmpty) {
    return 'Please fill in the field';
  }
  return null;
}

//90210
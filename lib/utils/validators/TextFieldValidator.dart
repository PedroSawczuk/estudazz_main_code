String? textFieldValidator(String? value, String requiredMessage) {
  if (value == null || value.trim().isEmpty) {
    return requiredMessage;
  }

  if (value.length < 3) {
    return 'O campo deve ter pelo menos 3 caracteres';
  }

  return null;
}
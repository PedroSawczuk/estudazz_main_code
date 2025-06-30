String? textFieldValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo é obrigatório';
  }

  if (value.length < 3) {
    return 'O campo deve ter pelo menos 3 caracteres';
  }

  return null;
}
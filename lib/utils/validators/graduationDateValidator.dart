String? graduationDateValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo é obrigatório';
  }

  final separateMonthYear = value.split('/');

  final month = int.tryParse(separateMonthYear[0]);
  final year = int.tryParse(separateMonthYear[1]);
  final today = DateTime.now();

  if (month == null || month < 1 || month > 12) {
    return 'Mês inválido. Deve ser entre Janeiro (01) e Dezembro (12).';
  }

  if (year == null || year < today.year) {
    return 'Ano Inválido. Deve ser no futuro!.';
  }

  if (year > today.year + 20) {
    return 'Ano inválido. Deve ser no máximo 20 anos no futuro.';
  }

  if (month < today.month && year == today.year) {
    return 'Mês inválido. Deve ser no futuro!.';
  }

  return null;
}

String? birthDateValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo é obrigatório';
  }

  final separateDayMonthYear = value.split('/');
  final day = int.tryParse(separateDayMonthYear[0]);
  final month = int.tryParse(separateDayMonthYear[1]);
  final year = int.tryParse(separateDayMonthYear[2]);

  final today = DateTime.now();

  if (day == null || day < 1 || day > 31) {
    return 'Dia inválido. Deve ser entre 01 e 31.';
  }

  if (month == null || month < 1 || month > 12) {
    return 'Mês inválido. Deve ser entre Janeiro (01) e Dezembro (12).';
  }

  if (year == null || year < 1950 || year > today.year) {
    return 'Ano inválido. Deve ser entre 1950 e o ano atual.';
  }

  final birthDate = DateTime(year, month, day);

  if (birthDate.isAfter(today)) {
    return 'Data de nascimento inválida. Deve ser no passado.';
  }

  return null;
}

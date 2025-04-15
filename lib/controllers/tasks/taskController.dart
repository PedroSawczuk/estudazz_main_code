class TaskController {
  static String? validateTaskName(String value) {
    if (value.trim().isEmpty) return 'Nome da tarefa é obrigatório';
    final regex = RegExp(r'^[a-zA-ZÀ-ÿ0-9\s\.,!?-]{3,100}$');
    if (!regex.hasMatch(value)) return 'Nome inválido';
    return null;
  }
}

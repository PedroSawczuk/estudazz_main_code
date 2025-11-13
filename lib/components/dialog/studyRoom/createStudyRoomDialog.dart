import 'package:flutter/material.dart';

class CreateStudyRoomDialog extends StatefulWidget {
  final Function(String name, String? description) onCreate;

  const CreateStudyRoomDialog({super.key, required this.onCreate});

  @override
  _CreateStudyRoomDialogState createState() => _CreateStudyRoomDialogState();
}

class _CreateStudyRoomDialogState extends State<CreateStudyRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Criar Sala de Estudos'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Sala',
                hintText: 'Ex: Grupo de Cálculo I',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um nome para a sala.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição (opcional)',
                hintText: 'Ex: Encontros às segundas-feiras',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onCreate(
                _nameController.text,
                _descriptionController.text.isNotEmpty
                    ? _descriptionController.text
                    : null,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Criar'),
        ),
      ],
    );
  }
}

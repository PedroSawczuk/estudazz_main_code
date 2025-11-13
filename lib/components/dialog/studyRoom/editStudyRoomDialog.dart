import 'package:flutter/material.dart';

class EditStudyRoomDialog extends StatefulWidget {
  final String currentName;
  final Function(String newName) onSave;

  const EditStudyRoomDialog({
    super.key,
    required this.currentName,
    required this.onSave,
  });

  @override
  _EditStudyRoomDialogState createState() => _EditStudyRoomDialogState();
}

class _EditStudyRoomDialogState extends State<EditStudyRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Nome da Sala'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Novo nome da sala',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um nome para a sala.';
            }
            return null;
          },
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
              widget.onSave(_nameController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

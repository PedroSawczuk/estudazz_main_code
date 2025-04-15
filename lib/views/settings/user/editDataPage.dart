import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class EditDataPage extends StatefulWidget {
  const EditDataPage({super.key});

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController(text: 'Pedro Sawczuk');
  TextEditingController _usernameController = TextEditingController(text: 'pedrosawczuk');
  TextEditingController _emailController = TextEditingController(text: 'pedrosawczuk53@gmail.com');
  TextEditingController _birthDateController = TextEditingController(text: '15/08/1995');
  TextEditingController _institutionController = TextEditingController(text: 'Universidade Federal');
  TextEditingController _courseController = TextEditingController(text: 'Engenharia de Software');
  TextEditingController _graduationDateController = TextEditingController(text: 'Dezembro de 2025');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Editar Dados'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informações Pessoais',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 1),
                _buildTextField('Nome', _nameController),
                const SizedBox(height: 10),
                _buildTextField('Username', _usernameController),
                const SizedBox(height: 10),
                _buildTextField('Email', _emailController),
                const SizedBox(height: 10),
                _buildTextField('Data de Nascimento', _birthDateController),
                const SizedBox(height: 30),
                const Text(
                  'Informações Acadêmicas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 1),
                _buildTextField('Instituição', _institutionController),
                const SizedBox(height: 10),
                _buildTextField('Curso', _courseController),
                const SizedBox(height: 10),
                _buildTextField('Conclusão Prevista', _graduationDateController),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Dados atualizados')));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar Alterações', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      backgroundColor: const Color(0xFFED820E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo é obrigatório';
        }
        return null;
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estudazz_main_code/components/custom/customAppBar.dart';

class EditDataPage extends StatefulWidget {
  const EditDataPage({super.key});

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _institutionController = TextEditingController();
  final _courseController = TextEditingController();
  final _graduationDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final data = doc.data();
    if (data != null) {
      _nameController.text = data['display_name'] ?? '';
      _usernameController.text = data['username'] ?? '';
      _emailController.text = data['email'] ?? '';
      _birthDateController.text = data['birth_date'] ?? '';
      _institutionController.text = data['institution'] ?? '';
      _courseController.text = data['course'] ?? '';
      _graduationDateController.text = data['expected_graduation'] ?? '';
    }
  }

  Future<void> _saveData() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final uid = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'display_name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'birth_date': _birthDateController.text,
          'institution': _institutionController.text,
          'course': _courseController.text,
          'expected_graduation': _graduationDateController.text,
          'profileCompleted': true,
        });

        CustomSnackBar.show(
          title: 'Sucesso',
          message: 'Dados atualizados com sucesso!',
          backgroundColor: ConstColors.greenColor,
        );
        Get.offAllNamed(AppRoutes.myDataPage);
      }  
    } catch (e) {
      print(e);
      CustomSnackBar.show(
        title: 'Erro',
        message: 'Erro ao atualizar os dados. Tente novamente mais tarde.',
        backgroundColor: ConstColors.redColor,
      );
      Get.offAllNamed(AppRoutes.myDataPage);       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Editar Dados'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações Pessoais',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                _buildTextField('Nome', _nameController),
                SizedBox(height: 10),
                _buildTextField('Username', _usernameController),
                SizedBox(height: 10),
                _buildTextField('Email', _emailController),
                SizedBox(height: 10),
                _buildTextField('Data de Nascimento', _birthDateController),
                SizedBox(height: 30),
                Text(
                  'Informações Acadêmicas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                _buildTextField('Instituição', _institutionController),
                SizedBox(height: 10),
                _buildTextField('Curso', _courseController),
                SizedBox(height: 10),
                _buildTextField(
                  'Conclusão Prevista',
                  _graduationDateController,
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveData,
                    child: Text(
                      'Salvar Alterações',
                      style: TextStyle(color: ConstColors.whiteColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      backgroundColor: ConstColors.orangeColor,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo é obrigatório';
        }
        return null;
      },
    );
  }
}

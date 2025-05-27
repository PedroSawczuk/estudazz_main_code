import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  /* 
    Junto com a lib 'mask_text_input_formatter', criei um formatador para a data de nascimento e para data prevista para conclusão do curso que o usuário adicionar
    para ter uma padronização nos dados! 
  */
  final _birthDateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _graduationDateFormatter = MaskTextInputFormatter(
    mask: '##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      final user = UserModel.fromMap(doc.data()!, uid);

      _nameController.text = user.displayName;
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _birthDateController.text = user.birthDate;
      _institutionController.text = user.institution;
      _courseController.text = user.course;
      _graduationDateController.text = user.expectedGraduation;
    }
  }

  Future<void> _saveUserData() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final uid = FirebaseAuth.instance.currentUser!.uid;

        final updatedUser = UserModel(
          uid: uid,
          displayName: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          birthDate: _birthDateController.text,
          institution: _institutionController.text,
          course: _courseController.text,
          expectedGraduation: _graduationDateController.text,
          profileCompleted: true,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(updatedUser.toMap());

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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    CustomSnackBar.show(
                      title: 'Atenção!',
                      message: 'Você não pode alterar o email do usuário.',
                      backgroundColor: ConstColors.orangeColor,
                    );
                  },
                  child: TextFormField(
                    controller: _emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Este campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                controller: _birthDateController,
                inputFormatters: [_birthDateFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  hintText: 'DD/MM/AAAA',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
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
                },
              ),

                SizedBox(height: 30),
                Text(
                  'Informações Acadêmicas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1),
                TextFormField(
                  controller: _institutionController,
                  decoration: InputDecoration(
                    labelText: 'Instituição',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _courseController,
                  decoration: InputDecoration(
                    labelText: 'Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _graduationDateController,
                  inputFormatters: [_graduationDateFormatter],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Data de Conclusão',
                    hintText: 'MM/AAAA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
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

                    if (month < today.month &&
                        year == today.year) {
                      return 'Mês inválido. Deve ser no futuro!.';
                    }

                    return null;

                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveUserData,
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
}

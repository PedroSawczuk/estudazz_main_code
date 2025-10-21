import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/formatter/inputsFormatter.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:estudazz_main_code/utils/validators/TextFieldValidator.dart';
import 'package:estudazz_main_code/utils/validators/birthDateValidator.dart';
import 'package:estudazz_main_code/utils/validators/graduationDateValidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  String _photoUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = await GetUserData.getUserUid();
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      final user = UserModel.fromMap(snapshot.data()!, uid!);

      _nameController.text = user.displayName;
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _birthDateController.text = user.birthDate;
      _institutionController.text = user.institution;
      _courseController.text = user.course;
      _graduationDateController.text = user.expectedGraduation;
      _photoUrl = user.photoUrl;
    }
  }

  Future<void> _saveUserData() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        final uid = await GetUserData.getUserUid();

        final updatedUser = UserModel(
          uid: uid!,
          displayName: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          birthDate: _birthDateController.text,
          institution: _institutionController.text,
          course: _courseController.text,
          expectedGraduation: _graduationDateController.text,
          profileCompleted: true,
          photoUrl: _photoUrl,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(updatedUser.toMap());

        CustomSnackBar.show(
          title: 'Sucesso!',
          message: 'Dados atualizados com sucesso!',
          backgroundColor: ConstColors.greenColor,
        );

        Get.offNamedUntil(
          AppRoutes.myDataPage,
          ModalRoute.withName(AppRoutes.settingsPage),
        );
      }
    } catch (e) {
      print(e);
      CustomSnackBar.show(
        title: 'Erro!',
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
                  inputFormatters: [nameFormatter],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          textFieldValidator(value, 'Nome é obrigatório'),
                ),
                ConstSizedBox.h10,
                TextFormField(
                  controller: _usernameController,
                  inputFormatters: [usernameFormatter],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          textFieldValidator(value, 'Username é obrigatório'),
                ),
                ConstSizedBox.h10,
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
                    validator:
                        (value) =>
                            textFieldValidator(value, 'Email é obrigatório'),
                  ),
                ),
                ConstSizedBox.h10,
                TextFormField(
                  controller: _birthDateController,
                  inputFormatters: [birthDateFormatter],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: 'DD/MM/AAAA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: birthDateValidator,
                ),

                ConstSizedBox.h30,
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
                  validator:
                      (value) => textFieldValidator(
                        value,
                        'Instituição é obrigatória',
                      ),
                ),
                ConstSizedBox.h10,
                TextFormField(
                  controller: _courseController,
                  decoration: InputDecoration(
                    labelText: 'Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          textFieldValidator(value, 'Curso é obrigatório'),
                ),
                ConstSizedBox.h10,
                TextFormField(
                  controller: _graduationDateController,
                  inputFormatters: [graduationDateFormatter],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Data de Conclusão',
                    hintText: 'MM/AAAA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: graduationDateValidator,
                ),
                ConstSizedBox.h30,
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

import 'package:estudazz_main_code/components/cards/user/userDataCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/user/userController.dart';
import 'package:image_picker/image_picker.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key});

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final UserController _userController = UserController();
  late Stream<UserModel?> _userDataStream;

  @override
  void initState() {
    super.initState();
    _userDataStream = _userController.streamUserData();
  }

  void _showImageSourceSelection() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Câmera'),
              onTap: () async {
                Get.back();
                await _userController.updateProfilePicture(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () async {
                Get.back();
                await _userController.updateProfilePicture(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Meus Dados'),
      body: StreamBuilder<UserModel?>(
        stream: _userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Dados não encontrados."));
          }

          final data = snapshot.data!;
          String? photoURL = data.photoUrl;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstSizedBox.h20,
                Center(
                  child: GestureDetector(
                    onTap: _showImageSourceSelection,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: photoURL.isNotEmpty
                          ? NetworkImage(photoURL)
                          : const AssetImage('assets/images/no-profile-photo.png') as ImageProvider,
                    ),
                  ),
                ),
                ConstSizedBox.h30,
                const Text(
                  'Informações Pessoais',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const Divider(thickness: 1),
                ConstSizedBox.h8,

                UserDataCard(label: "Nome", value: data.displayName),
                UserDataCard(label: "Username", value: data.username),
                UserDataCard(label: "Email", value: data.email),
                UserDataCard(
                  label: "Data de Nascimento",
                  value: data.birthDate,
                ),

                ConstSizedBox.h13,

                const Text(
                  'Informações Acadêmicas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const Divider(thickness: 1),
                ConstSizedBox.h8,

                UserDataCard(
                  label: "Instituição",
                  value: data.institution,
                ),
                UserDataCard(label: "Curso", value: data.course),
                UserDataCard(
                  label: "Conclusão Prevista",
                  value: data.expectedGraduation,
                ),
                ConstSizedBox.h30,
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.editDataPage);
                    },
                    icon: const Icon(Icons.edit, color: ConstColors.whiteColor),
                    label: const Text("Editar Dados"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstColors.orangeColor,
                      foregroundColor: ConstColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

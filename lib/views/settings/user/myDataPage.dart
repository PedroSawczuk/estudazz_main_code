import 'package:estudazz_main_code/components/cards/user/userDataCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/user/fetchUserDataService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/user/userController.dart';
import 'package:image_picker/image_picker.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key});

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final FetchUserDataService _fetchUserDataService = FetchUserDataService();
  final UserController _userController = UserController();
  late Future<DocumentSnapshot> _futureUserData;

  @override
  void initState() {
    super.initState();
    _futureUserData = _fetchUserData();
  }

  Future<DocumentSnapshot> _fetchUserData() {
    return _fetchUserDataService.getUserData();
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
                setState(() {
                  _futureUserData = _fetchUserData(); 
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () async {
                Get.back();
                await _userController.updateProfilePicture(ImageSource.gallery);
                setState(() {
                  _futureUserData = _fetchUserData(); 
                });
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
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Dados não encontrados."));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          String? photoURL = data['photoURL'];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstSizedBox.h20,
                Center(
                  child: GestureDetector(
                    onTap: _showImageSourceSelection,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: photoURL != null && photoURL.isNotEmpty
                          ? NetworkImage(photoURL)
                          : const AssetImage('assets/images/no-profile-photo.png') as ImageProvider,
                    ),
                  ),
                ),
                ConstSizedBox.h30,
                Text(
                  'Informações Pessoais',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Divider(thickness: 1),
                ConstSizedBox.h8,

                UserDataCard(label: "Nome", value: data['display_name'] ?? ''),
                UserDataCard(label: "Username", value: data['username'] ?? ''),
                UserDataCard(label: "Email", value: data['email'] ?? ''),
                UserDataCard(
                  label: "Data de Nascimento",
                  value: data['birth_date'] ?? '',
                ),

                ConstSizedBox.h13,

                Text(
                  'Informações Acadêmicas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Divider(thickness: 1),
                ConstSizedBox.h8,

                UserDataCard(
                  label: "Instituição",
                  value: data['institution'] ?? '',
                ),
                UserDataCard(label: "Curso", value: data['course'] ?? ''),
                UserDataCard(
                  label: "Conclusão Prevista",
                  value: data['expected_graduation'] ?? '',
                ),
                ConstSizedBox.h30,
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.editDataPage);
                    },
                    icon: Icon(Icons.edit, color: ConstColors.whiteColor),
                    label: Text("Editar Dados"),
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

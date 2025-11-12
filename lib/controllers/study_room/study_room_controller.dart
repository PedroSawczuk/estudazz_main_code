import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/models/study_room/study_room_model.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/db/study_room/study_room_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StudyRoomController extends GetxController {
  final StudyRoomDB _studyRoomDB = StudyRoomDB();
  final Rx<List<StudyRoomModel>> _studyRooms = Rx<List<StudyRoomModel>>([]);

  List<StudyRoomModel> get studyRooms => _studyRooms.value;

  @override
  void onInit() {
    super.onInit();
    _studyRooms.bindStream(_getStudyRoomsStream());
  }

  Stream<List<StudyRoomModel>> _getStudyRoomsStream() {
    return _studyRoomDB.getStudyRoomsStream().map((snapshot) {
      return snapshot.docs.map((doc) => StudyRoomModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> createStudyRoom(String name, String? description) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      CustomSnackBar.show(
          title: 'Erro',
          message: 'Você precisa estar logado para criar uma sala.',
          backgroundColor: ConstColors.redColor);
      return;
    }

    if (name.isEmpty) {
      CustomSnackBar.show(
          title: 'Erro',
          message: 'O nome da sala não pode ser vazio.',
          backgroundColor: ConstColors.redColor);
      return;
    }

    await _studyRoomDB.createStudyRoom(
      name: name,
      description: description,
      creatorUid: user.uid,
    );
  }

  Future<void> joinStudyRoom(String roomCode) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      CustomSnackBar.show(
          title: 'Erro',
          message: 'Você precisa estar logado para entrar em uma sala.',
          backgroundColor: ConstColors.redColor);
      return;
    }

    try {
      final roomSnapshot = await _studyRoomDB.findRoomByCode(roomCode);

      if (roomSnapshot.docs.isEmpty) {
        CustomSnackBar.show(
            title: 'Erro',
            message: 'Nenhuma sala encontrada com este código.',
            backgroundColor: ConstColors.redColor);
        return;
      }

      final roomDoc = roomSnapshot.docs.first;
      final room = StudyRoomModel.fromFirestore(roomDoc);

      await _studyRoomDB.addUserToRoom(room.id, user.uid);

      CustomSnackBar.show(
          title: 'Sucesso!',
          message: 'Você entrou na sala "${room.name}".',
          backgroundColor: ConstColors.greenColor);

      Get.toNamed(AppRoutes.studyRoomDetailsPage, arguments: room);
    } catch (e) {
      CustomSnackBar.show(
          title: 'Erro',
          message: 'Ocorreu um erro ao entrar na sala.',
          backgroundColor: ConstColors.redColor);
    }
  }
}

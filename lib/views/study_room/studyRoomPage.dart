import 'dart:math';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/dialog/study_room/createStudyRoomDialog.dart';
import 'package:estudazz_main_code/components/dialog/study_room/joinStudyRoomDialog.dart';
import 'package:estudazz_main_code/controllers/study_room/study_room_controller.dart';
import 'package:estudazz_main_code/models/study_room/study_room_model.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyRoomPage extends StatefulWidget {
  const StudyRoomPage({super.key});

  @override
  State<StudyRoomPage> createState() => _StudyRoomPageState();
}

class _StudyRoomPageState extends State<StudyRoomPage> {
  final StudyRoomController _studyRoomController = Get.put(StudyRoomController());

  void _showCreateStudyRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateStudyRoomDialog(
          onCreate: (name, description) {
            _studyRoomController.createStudyRoom(name, description);
          },
        );
      },
    );
  }

  void _showJoinStudyRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return JoinStudyRoomDialog(
          onJoin: (code) {
            _studyRoomController.joinStudyRoom(code);
          },
        );
      },
    );
  }

  void _showStudyRoomOptionsModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Criar sala de estudos'),
                onTap: () {
                  Navigator.pop(context);
                  _showCreateStudyRoomDialog();
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_add),
                title: const Text('Entrar em sala de estudos'),
                onTap: () {
                  Navigator.pop(context);
                  _showJoinStudyRoomDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: 'Sala de Estudos',
      ),
      body: Obx(() {
        if (_studyRoomController.studyRooms.isEmpty) {
          return const Center(
            child: Text('Nenhuma sala de estudos criada.'),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: _studyRoomController.studyRooms.length,
          itemBuilder: (context, index) {
            return _StudyRoomCard(room: _studyRoomController.studyRooms[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showStudyRoomOptionsModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StudyRoomCard extends StatelessWidget {
  final StudyRoomModel room;

  const _StudyRoomCard({required this.room});

  Color _getColorFromId(String id) {
    final random = Random(id.hashCode);
    return Color.fromRGBO(
      random.nextInt(200),
      random.nextInt(200),
      random.nextInt(200),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorFromId(room.id),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.studyRoomDetailsPage, arguments: room);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.group, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${room.members.length} membro(s)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

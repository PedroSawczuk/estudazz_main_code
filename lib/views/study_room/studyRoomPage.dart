import 'dart:math';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/dialog/study_room/createStudyRoomDialog.dart';
import 'package:flutter/material.dart';

class StudyRoom {
  final String name;
  final String? description;
  final Color color;

  StudyRoom({required this.name, this.description, required this.color});
}

class StudyRoomPage extends StatefulWidget {
  const StudyRoomPage({super.key});

  @override
  State<StudyRoomPage> createState() => _StudyRoomPageState();
}

class _StudyRoomPageState extends State<StudyRoomPage> {
  final List<StudyRoom> _studyRooms = [];

  void _addStudyRoom(String name, String? description) {
    final random = Random();
    final color = Color.fromRGBO(
      random.nextInt(200),
      random.nextInt(200),
      random.nextInt(200),
      1,
    );
    setState(() {
      _studyRooms.add(
        StudyRoom(name: name, description: description, color: color),
      );
    });
  }

  void _showCreateStudyRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateStudyRoomDialog(
          onCreate: _addStudyRoom,
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
                  // TODO: Implement navigation to join study room page
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
      body: _studyRooms.isEmpty
          ? const Center(
              child: Text('Nenhuma sala de estudos criada.'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.2,
              ),
              itemCount: _studyRooms.length,
              itemBuilder: (context, index) {
                return _StudyRoomCard(room: _studyRooms[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showStudyRoomOptionsModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StudyRoomCard extends StatelessWidget {
  final StudyRoom room;

  const _StudyRoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: room.color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to study room details page
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                room.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

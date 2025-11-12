import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/models/study_room/study_room_model.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudyRoomDetailsPage extends StatefulWidget {
  final StudyRoomModel room;

  const StudyRoomDetailsPage({super.key, required this.room});

  @override
  State<StudyRoomDetailsPage> createState() => _StudyRoomDetailsPageState();
}

class _StudyRoomDetailsPageState extends State<StudyRoomDetailsPage> {
  List<UserModel> _members = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMembersData();
  }

  Future<void> _fetchMembersData() async {
    try {
      final List<UserModel> members = [];
      for (final uid in widget.room.members) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          members.add(UserModel.fromMap(userDoc.data()!, uid));
        }
      }
      if (mounted) {
        setState(() {
          _members = members;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        CustomSnackBar.show(
            title: 'Erro',
            message: 'Não foi possível carregar os membros da sala.',
            backgroundColor: ConstColors.redColor);
      }
    }
  }

  String _generateRoomCode(String roomId) {
    final code = widget.room.roomCode.replaceAll('-', '');
    if (code.length < 6) {
      return code.toUpperCase();
    }
    final part1 = code.substring(0, 3).toUpperCase();
    final part2 = code.substring(3, 6).toUpperCase();
    return '$part1-$part2';
  }

  void _showMembersList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Membros (${_members.length})',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Flexible(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _members.length,
                        itemBuilder: (context, index) {
                          final member = _members[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: member.photoUrl.isNotEmpty
                                  ? NetworkImage(member.photoUrl)
                                  : const AssetImage('assets/images/no-profile-photo.png')
                                      as ImageProvider,
                            ),
                            title: Text(member.displayName),
                            subtitle: Text(member.email),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final roomCode = _generateRoomCode(widget.room.id);

    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: widget.room.name,
        showMembersIcon: true,
        onMembersIconTap: _showMembersList,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Código da Sala:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              roomCode,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text('Copiar'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: roomCode));
                CustomSnackBar.show(
                  title: 'Copiado!',
                  message: 'Código da sala copiado para a área de transferência.',
                  backgroundColor: ConstColors.greenColor,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

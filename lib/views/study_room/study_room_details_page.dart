import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/models/study_room/study_room_model.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/views/study_room/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudyRoomDetailsPage extends StatefulWidget {
  final StudyRoomModel room;

  const StudyRoomDetailsPage({super.key, required this.room});

  @override
  State<StudyRoomDetailsPage> createState() => _StudyRoomDetailsPageState();
}

class _StudyRoomDetailsPageState extends State<StudyRoomDetailsPage> with TickerProviderStateMixin {
  List<UserModel> _members = [];
  bool _isLoading = true;
  late final TabController _tabController;
  bool get _canChat => widget.room.members.length >= 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _canChat ? 2 : 1, vsync: this);
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
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: widget.room.name,
        showMembersIcon: true,
        onMembersIconTap: _showMembersList,
        bottom: _canChat
            ? TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Detalhes'),
                  Tab(text: 'Chat'),
                ],
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDetailsTab(),
          if (_canChat)
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ChatPage(room: widget.room, members: _members),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    final roomCode = widget.room.roomCode;
    return Center(
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
    );
  }
}

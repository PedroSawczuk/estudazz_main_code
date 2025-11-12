import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/models/study_room/study_room_model.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/views/study_room/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class StudyRoomDetailsPage extends StatefulWidget {
  final StudyRoomModel room;

  const StudyRoomDetailsPage({super.key, required this.room});

  @override
  State<StudyRoomDetailsPage> createState() => _StudyRoomDetailsPageState();
}

class _StudyRoomDetailsPageState extends State<StudyRoomDetailsPage>
    with TickerProviderStateMixin {
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
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: widget.room.name,
        bottom: _canChat
            ? TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Chat'),
                  Tab(text: 'Detalhes'),
                ],
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _canChat
            ? [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ChatPage(room: widget.room, members: _members),
                _buildDetailsTab(),
              ]
            : [_buildDetailsTab()],
      ),
    );
  }

  Widget _buildDetailsTab() {
    final isOwner =
        FirebaseAuth.instance.currentUser?.uid == widget.room.creatorUid;
    final formattedDate =
        DateFormat('dd/MM/yyyy').format(widget.room.createdAt.toDate());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOwner) ...[
            const Text(
              'Código da Sala:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.room.roomCode,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.room.roomCode));
                    CustomSnackBar.show(
                      title: 'Copiado!',
                      message:
                          'Código da sala copiado para a área de transferência.',
                      backgroundColor: ConstColors.greenColor,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
          Text(
            'Criado em: $formattedDate',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Membros:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _members.length,
                  itemBuilder: (context, index) {
                    final member = _members[index];
                    return ListTile(
                      leading: ClipOval(
                        child: member.photoUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: member.photoUrl,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/no-profile-photo.png',
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              )
                            : Image.asset(
                                'assets/images/no-profile-photo.png',
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                      ),
                      title: Text(member.displayName),
                      subtitle: Text(member.email),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

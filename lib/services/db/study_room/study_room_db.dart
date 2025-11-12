import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudyRoomDB {
  final CollectionReference studyRoomsCollection =
      FirebaseFirestore.instance.collection('study_rooms');

  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final part1 = String.fromCharCodes(Iterable.generate(
        3, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    final part2 = String.fromCharCodes(Iterable.generate(
        3, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    return '$part1-$part2';
  }

  Future<void> createStudyRoom({
    required String name,
    String? description,
    required String creatorUid,
  }) async {
    // In a production app, you'd need to ensure the code is unique.
    // This might involve a loop that regenerates the code if it already exists.
    final roomCode = _generateRoomCode();

    await studyRoomsCollection.add({
      'name': name,
      'description': description,
      'creatorUid': creatorUid,
      'members': [creatorUid], // The creator is the first member
      'createdAt': Timestamp.now(),
      'roomCode': roomCode,
    });
  }

  Future<QuerySnapshot> findRoomByCode(String roomCode) {
    return studyRoomsCollection.where('roomCode', isEqualTo: roomCode).limit(1).get();
  }

  Future<void> addUserToRoom(String roomId, String userId) {
    return studyRoomsCollection.doc(roomId).update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

  Stream<QuerySnapshot> getStudyRoomsStream() {
    return studyRoomsCollection.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> updateStudyRoom({
    required String roomId,
    required Map<String, dynamic> data,
  }) {
    return studyRoomsCollection.doc(roomId).update(data);
  }

  Future<void> deleteStudyRoom(String roomId) async {
    await studyRoomsCollection.doc(roomId).delete();
  }
}

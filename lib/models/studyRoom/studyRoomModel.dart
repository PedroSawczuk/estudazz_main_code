import 'package:cloud_firestore/cloud_firestore.dart';

class StudyRoomModel {
  final String id;
  final String name;
  final String? description;
  final String creatorUid;
  final List<String> members;
  final Timestamp createdAt;
  final String roomCode;

  StudyRoomModel({
    required this.id,
    required this.name,
    this.description,
    required this.creatorUid,
    required this.members,
    required this.createdAt,
    required this.roomCode,
  });

  StudyRoomModel copyWith({
    String? id,
    String? name,
    String? description,
    String? creatorUid,
    List<String>? members,
    Timestamp? createdAt,
    String? roomCode,
  }) {
    return StudyRoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorUid: creatorUid ?? this.creatorUid,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      roomCode: roomCode ?? this.roomCode,
    );
  }

  factory StudyRoomModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return StudyRoomModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'],
      creatorUid: data['creatorUid'] ?? '',
      members: List<String>.from(data['members'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      roomCode: data['roomCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creatorUid': creatorUid,
      'members': members,
      'createdAt': createdAt,
      'roomCode': roomCode,
    };
  }
}

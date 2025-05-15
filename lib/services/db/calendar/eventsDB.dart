import 'package:cloud_firestore/cloud_firestore.dart';

class EventsDB {
  final CollectionReference eventsCollection = FirebaseFirestore.instance
      .collection('events');

  Future<void> addEvent({
    required String uid,
    required String eventName,
    required DateTime eventDate,
  }) async {
    await eventsCollection.add({
      'uid': uid,
      'event_name': eventName,
      'event_date': eventDate.toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<DocumentSnapshot> getEvents(String eventId) async {
    return await eventsCollection.doc(eventId).get();
  }

  Stream<QuerySnapshot> getEventsByUser(String uid) {
    return eventsCollection
      .where('uid', isEqualTo: uid)
      .orderBy('created_at', descending: true)
      .snapshots();
  }
}

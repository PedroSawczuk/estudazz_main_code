class EventModel {
  final String id;
  final String eventName;
  final DateTime eventDate;

  EventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
  });

  factory EventModel.fromDocument(Map<String, dynamic> doc, String docId) {
    return EventModel(
      id: docId,
      eventName: doc['event_name'] ?? '',
      eventDate: DateTime.parse(doc['event_date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_name': eventName,
      'event_date': eventDate.toIso8601String(),
    };
  }
}

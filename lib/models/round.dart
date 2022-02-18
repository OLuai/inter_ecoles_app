import 'package:cloud_firestore/cloud_firestore.dart';

class Round {
  final String id;
  final String name;
  final DateTime date;
  bool isActive;

  Round({
    required this.id,
    required this.name,
    required this.date,
    this.isActive = true,
  });

  Round.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          date: DateTime.fromMillisecondsSinceEpoch(
              (json['date']! as Timestamp).millisecondsSinceEpoch),
          isActive: json['isActive']! as bool,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'isActive': isActive,
    };
  }
}

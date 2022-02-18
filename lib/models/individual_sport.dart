import 'package:inter_ecoles_app/models/sport.dart';

class IndividualSport {
  final String id;
  final String name;
  final sport = Sports.individuels;

  IndividualSport({
    required this.id,
    required this.name,
  });

  IndividualSport.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

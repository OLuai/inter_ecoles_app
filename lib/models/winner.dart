import 'package:inter_ecoles_app/models/school.dart';

class Winner {
  String id;
  String fullName;
  int rank;
  String schoolId;
  late final School school;
  Winner(
      {required this.id,
      required this.fullName,
      required this.rank,
      required this.schoolId}) {
    school = Schools.getSchool(schoolId);
  }

  Winner.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          fullName: json['fullName']! as String,
          rank: json['rank']! as int,
          schoolId: json['schoolId']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'rank': rank,
      'schoolId': schoolId,
    };
  }
}

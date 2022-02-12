import 'package:inter_ecoles_app/models/school.dart';
import 'package:inter_ecoles_app/models/sport.dart';

class Match {
  final String roundId;
  final String id;
  late Sport sport;
  final String sportId;
  late School teamA;
  final String teamAId;
  late School teamB;
  final String teamBId;
  final String gender;
  int period;
  String matchStatus;
  //Le Score pour chaque periode de jeu.
  //Exemple {1:{'ID_ESI':2, 'ID_ESA':0},2:{'ID_ESI':1, 'ID_ESA':0}}
  Map<int, Map<String, int?>>? periodsScores;
  int playedTime;

  Match({
    required this.id,
    required this.roundId,
    required this.sportId,
    required this.gender,
    required this.teamAId,
    required this.teamBId,
    this.period = 1,
    this.matchStatus = "waiting",
    this.periodsScores,
    this.playedTime = 0,
  }) {
    sport = Sports.getSport(sportId);
    teamA = Schools.getSchool(teamAId);
    teamB = Schools.getSchool(teamBId);

    if (periodsScores == null) {
      periodsScores = <int, Map<String, int?>>{};
      for (int i = 0; i < period; i++) {
        periodsScores![i + 1] = {teamBId: 0, teamAId: 0};
      }
    }
  }

  Match.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          roundId: json['roundId']! as String,
          sportId: json['sportId']! as String,
          gender: json['gender']! as String,
          teamAId: json['teamAId']! as String,
          teamBId: json['teamBId']! as String,
          periodsScores: _Utils.convertMap(json['periodsScores']!),
          matchStatus: json['matchStatus']! as String,
          period: json['period'] as int,
          playedTime: json['playedTime'] as int,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'roundId': roundId,
      'sportId': sportId,
      'gender': gender,
      'teamAId': teamAId,
      'teamBId': teamBId,
      'periodsScores': periodsScores?.map(
          (dynamic key, dynamic value) => MapEntry(key.toString(), value)),
      'matchStatus': matchStatus,
      'period': period,
      'playedTime': playedTime,
    };
  }

//Pour recuperer le score Principal. exemple de retour: {'ID_ESI':2, 'ID_ESA':0}
  Map<String, int?> getScore() {
    Map<String, int?> score = {teamAId: 0, teamBId: 0};
    periodsScores?.forEach((_, sp) {
      int currentScoreTeamA = score[teamAId] ?? 0;
      int currentScoreTeamB = score[teamBId] ?? 0;
      int scoreTeamA = sp[teamAId] ?? 0;
      int scoreTeamB = sp[teamBId] ?? 0;

      score[teamAId] = currentScoreTeamA + scoreTeamA;
      score[teamBId] = currentScoreTeamB + scoreTeamB;
    });
    return score;
  }
}

//La maniere d'obtenir le score principal est different au volleyball
//d'ou l'existanstance de cette sous classe pour permettre le redefinition
//de la methode getScore
class VolleyballMatch extends Match {
  VolleyballMatch({
    required String id,
    required String roundId,
    required String sportId,
    required String gender,
    required String teamAId,
    required String teamBId,
    int period = 1,
    String matchStatus = "waiting",
    Map<int, Map<String, int?>>? periodsScores,
    int playedTime = 0,
  }) : super(
          id: id,
          roundId: roundId,
          sportId: sportId,
          gender: gender,
          teamAId: teamAId,
          teamBId: teamBId,
          matchStatus: matchStatus,
          period: period,
          periodsScores: periodsScores,
        );

  VolleyballMatch.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          roundId: json['roundId']! as String,
          sportId: json['sportId']! as String,
          gender: json['gender']! as String,
          teamAId: json['teamAId']! as String,
          teamBId: json['teamBId']! as String,
          periodsScores: _Utils.convertMap(json['periodsScores']!),
          matchStatus: json['matchStatus']! as String,
          period: json['period'] as int,
          playedTime: json['playedTime'] as int,
        );

  @override
  Map<String, int?> getScore() {
    Map<String, int?> score = {teamAId: 0, teamBId: 0};
    periodsScores?.forEach((_, sp) {
      int currentScoreTeamA = score[teamAId] ?? 0;
      int currentScoreTeamB = score[teamBId] ?? 0;

      int periodScoreTeamA = sp[teamAId] ?? 0;
      int periodScoreTeamB = sp[teamBId] ?? 0;

      if (periodScoreTeamA > periodScoreTeamB &&
          (periodScoreTeamA - periodScoreTeamB) >= 2 &&
          periodScoreTeamA >= 25) {
        score[teamAId] = currentScoreTeamA + 1;
      } else if (periodScoreTeamA < periodScoreTeamB &&
          (periodScoreTeamB - periodScoreTeamA) >= 2 &&
          periodScoreTeamB >= 25) {
        score[teamBId] = currentScoreTeamB + 1;
      }
    });
    return score;
  }
}

class MatchStatus {
  static String waiting = "waiting";
  static String pending = "pending";
  static String pause = "pause";
  static String end = "end";
}

class _Utils {
  static Map<int, Map<String, int?>> convertMap(dynamic map) {
    Map<int, Map<String, int?>> scores = {};
    map.forEach((key, value) {
      scores[int.parse(key)] = {};
      value.forEach((k, v) {
        scores[int.parse(key)]![k] = v;
      });
    });
    return scores;
  }
}

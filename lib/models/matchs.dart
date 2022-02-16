import 'package:inter_ecoles_app/models/school.dart';
import 'package:inter_ecoles_app/models/sport.dart';

import 'gender.dart';

enum MatchStatus {
  waiting,
  pending,
  pause,
  end,
}
String getMatchStatus(MatchStatus status){
  switch(status) {
    case MatchStatus.waiting: return "waiting";
    case MatchStatus.pending: return "pending";
    case MatchStatus.pause: return "pause";
    case MatchStatus.end: return "end";
    default : return "waiting";
  }
}

//La maniere d'obtenir le score principal est different au volleyball
//d'ou l'existance de cette sous classe pour permettre le redefinition
//de la methode getScore
class VolleyballMatchs extends Matchs {
  VolleyballMatchs({
    required String id,
    required String roundId,
    required String sportId,
    required Gender gender,
    required String teamAId,
    required String teamBId,
    int period = 1,
    MatchStatus status = MatchStatus.waiting,
    Map<int, Map<String, int?>>? periodsScores,
    int elapsedTime = 0,
  }) : super(
          id: id,
          roundId: roundId,
          sportId: sportId,
          gender: gender,
          teamAId: teamAId,
          teamBId: teamBId,
          status: status,
          period: period,
          periodsScores: periodsScores,
        );
  VolleyballMatchs.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          roundId: json['roundId']! as String,
          sportId: json['sportId']! as String,
          gender: _Utils.getGender(json['gender']! as String),
          teamAId: json['teamAId']! as String,
          teamBId: json['teamBId']! as String,
          periodsScores: _Utils.convertMap(json['periodsScores']!),
          status: _Utils.getStatus(json['status']! as String),
          period: json['period'] as int,
          elapsedTime: json['elapsedTime'] as int,
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

class Matchs {
  final String roundId; // la journée démi-final
  final String id; // l'identifiant du match
  late Sport sport;
  final String sportId;
  late School teamA;
  final String teamAId;
  late School teamB;
  final String teamBId;
  final Gender gender;
  int period; // les mi-temps
  MatchStatus status; // le status du match enuméré en haut
  Map<int, Map<String, int?>>? periodsScores;
  int elapsedTime; // le temps écoulé

  Matchs({
    required this.id,
    required this.roundId,
    required this.sportId,
    required this.gender,
    required this.teamAId,
    required this.teamBId,
    this.period = 1,
    this.status = MatchStatus.waiting,
    this.periodsScores,
    this.elapsedTime = 0,
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

  Matchs.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          roundId: json['roundId']! as String,
          sportId: json['sportId']! as String,
          gender: _Utils.getGender(json['gender']! as String),
          teamAId: json['teamAId']! as String,
          teamBId: json['teamBId']! as String,
          periodsScores: _Utils.convertMap(json['periodsScores']!),
          status: _Utils.getStatus(json['status']! as String),
          period: json['period'] as int,
          elapsedTime: json['elapsedTime'] as int,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'roundId': roundId,
      'sportId': sportId,
      'gender': gender.toString(),
      'teamAId': teamAId,
      'teamBId': teamBId,
      'periodsScores': periodsScores?.map(
          (dynamic key, dynamic value) => MapEntry(key.toString(), value)),
      'status': status.toString(),
      'period': period,
      'elapsedTime': elapsedTime,
    };
  }

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

List<dynamic> matchItems =[
  Matchs(id: "0", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.homme, teamAId: "ID_ESI", teamBId: "ID_EP"),
  Matchs(id: "1", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.dame, teamAId: "ID_ESCAE", teamBId: "ID_ESTP"),
  Matchs(id: "2", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.homme, teamAId: "ID_ESA", teamBId: "ID_ESMG"),
  Matchs(id: "3", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.dame, teamAId: "ID_ESI", teamBId: "ID_ESMG"),
  Matchs(id: "4", roundId: "1", sportId: "ID_BASKETBALL", gender: Gender.homme, teamAId: "ID_ESI", teamBId: "ID_EP"),
  Matchs(id: "5", roundId: "1", sportId: "ID_BASKETBALL", gender: Gender.dame, teamAId: "ID_ESCAE", teamBId: "ID_ESTP"),
  Matchs(id: "6", roundId: "1", sportId: "ID_BASKETBALL", gender: Gender.homme, teamAId: "ID_ESA", teamBId: "ID_ESMG"),
  Matchs(id: "7", roundId: "1", sportId: "ID_BASKETBALL", gender: Gender.dame, teamAId: "ID_ESI", teamBId: "ID_ESTP"),
  Matchs(id: "8", roundId: "1", sportId: "ID_HANDBALL", gender: Gender.homme, teamAId: "ID_ESI", teamBId: "ID_EP"),
  Matchs(id: "9", roundId: "1", sportId: "ID_HANDBALL", gender: Gender.dame, teamAId: "ID_ESCAE", teamBId: "ID_ESTP"),
  Matchs(id: "10", roundId: "1", sportId: "ID_HANDBALL", gender: Gender.homme, teamAId: "ID_ESA", teamBId: "ID_ESMG"),
  Matchs(id: "11", roundId: "1", sportId: "ID_HANDBALL", gender: Gender.dame, teamAId: "ID_ESI", teamBId: "ID_ESTP"),
  Matchs(id: "12", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.dame, teamAId: "ID_EP", teamBId: "ID_ESA"),
  Matchs(id: "12", roundId: "1", sportId: "ID_FOOTBALL", gender: Gender.homme, teamAId: "ID_ESTP", teamBId: "ID_ESCAE"),
];

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

  static Gender getGender(String gender) {
    Gender gd = Gender.homme;
    for (var g in Gender.values) {
      if (g.toString() == gender) {
        return g;
      }
    }
    return gd;
  }

  static MatchStatus getStatus(String status) {
    MatchStatus st = MatchStatus.waiting;
    for (var s in MatchStatus.values) {
      if (s.toString() == status) {
        return s;
      }
    }
    return st;
  }
}

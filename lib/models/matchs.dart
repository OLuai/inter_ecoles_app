// ignore_for_file: file_names

import 'package:inter_ecoles_app/models/school.dart';
import 'package:inter_ecoles_app/models/sport.dart';

import 'gender.dart';

enum MatchStatus {
  waiting,
  pending,
  pause,
  end,
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
    int playedTime = 0,
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

class Matchs {
  final String roundId;
  final String id;
  late Sport sport;
  final String sportId;
  late School teamA;
  final String teamAId;
  late School teamB;
  final String teamBId;
  final Gender gender;
  int period;
  MatchStatus status;
  Map<int, Map<String, int?>>? periodsScores;
  int playedTime;

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
          playedTime: json['playedTime'] as int,
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
      'playedTime': playedTime,
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

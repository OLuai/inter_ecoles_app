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
String getMatchStatus(MatchStatus status) {
  switch (status) {
    case MatchStatus.waiting:
      return "en attente";
    case MatchStatus.pending:
      return "en cours";
    case MatchStatus.pause:
      return "pause";
    case MatchStatus.end:
      return "Terminé";
    default:
      return "en attente";
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

  final int order;
  int period;
  MatchStatus status;
  Map<int, Map<String, int?>>? periodsScores;
  int elapsedTime;

  Matchs({
    required this.id,
    required this.roundId,
    required this.sportId,
    required this.gender,
    required this.order,
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
          order: json['order'] as int,
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
      'order': order,
      'elapsedTime': elapsedTime,
    };
  }

  Map<String, int> getScore() {
    Map<String, int> score = {teamAId: 0, teamBId: 0};
    if (sportId == Sports.volleyball.id) {
      periodsScores?.forEach((_, sp) {
        int currentScoreTeamA = score[teamAId] ?? 0;
        int currentScoreTeamB = score[teamBId] ?? 0;

        int periodScoreTeamA = sp[teamAId] ?? 0;
        int periodScoreTeamB = sp[teamBId] ?? 0;

        int periodFinishScore = period == sport.periodCount ? 15 : 25;

        if (periodScoreTeamA > periodScoreTeamB &&
            (periodScoreTeamA - periodScoreTeamB) >= 2 &&
            periodScoreTeamA >= periodFinishScore) {
          score[teamAId] = currentScoreTeamA + 1;
        } else if (periodScoreTeamA < periodScoreTeamB &&
            (periodScoreTeamB - periodScoreTeamA) >= 2 &&
            periodScoreTeamB >= periodFinishScore) {
          score[teamBId] = currentScoreTeamB + 1;
        }
      });
    } else {
      periodsScores?.forEach((_, sp) {
        int currentScoreTeamA = score[teamAId] ?? 0;
        int currentScoreTeamB = score[teamBId] ?? 0;
        int scoreTeamA = sp[teamAId] ?? 0;
        int scoreTeamB = sp[teamBId] ?? 0;

        score[teamAId] = currentScoreTeamA + scoreTeamA;
        score[teamBId] = currentScoreTeamB + scoreTeamB;
      });
    }
    return score;
  }

  Map<String, String> changeMatchStatus(MatchStatus st) {
    status = st;
    return {'status': status.toString()};
  }

  //Retourne le nouveau score par periode
  Map<String, Object?> newPeriod() {
    if (sportId == Sports.volleyball.id) {
      Map<String, int> score = getScore();
      if (score[teamAId] == 3 || score[teamBId] == 3) {
        return {
          'periodsScores': periodsScores
              ?.map((dynamic key, dynamic val) => MapEntry(key.toString(), val))
        };
      }
    }
    if (period < sport.periodCount) {
      period++;
      periodsScores![period] = {teamBId: 0, teamAId: 0};
    }
    return {
      'periodsScores': periodsScores
          ?.map((dynamic key, dynamic val) => MapEntry(key.toString(), val))
    };
  }

  Map<String, Object?> changeScore({
    required String teamId,
    required int value,
    bool increment = true,
  }) {
    Map<String, int> currentGlobalScore = getScore();

    int? scoreA = periodsScores![period]![teamAId];
    int? scoreB = periodsScores![period]![teamBId];

    int initialScoreA = scoreA ?? 0;
    int initialScoreB = scoreB ?? 0;

    if (sportId == Sports.volleyball.id) {
      currentGlobalScore = {teamAId: 0, teamBId: 0};
    }

    if (teamId == teamAId) {
      int globScoreA = currentGlobalScore[teamAId] ?? 0;
      scoreA = !increment
          ? value - globScoreA
          : scoreA == null
              ? 0
              : scoreA + value;
    } else {
      int globScoreB = currentGlobalScore[teamBId] ?? 0;
      scoreB = !increment
          ? value - globScoreB
          : scoreB == null
              ? 0
              : scoreB + value;
    }

    Map<String, int?> newScore = {
      teamAId: scoreA! < 0 ? initialScoreA : scoreA,
      teamBId: scoreB! < 0 ? initialScoreB : scoreB,
    };

    periodsScores![period] = newScore;
    return {
      'periodsScores': periodsScores
          ?.map((dynamic key, dynamic val) => MapEntry(key.toString(), val))
    };
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

class Sport {
  final String id;
  String name;
  int periodCount;
  String periodName;
  String periodShortName;

  Sport({
    required this.id,
    required this.name,
    this.periodCount = 2,
    this.periodName = 'MI-TEMPS',
    this.periodShortName = 'mt',
  });

  Sport.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          periodCount: json['periodCount']! as int,
          periodName: json['periodName']! as String,
          periodShortName: json['periodShortName']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'periodCount': periodCount,
      'periodName': periodName,
      'periodShortName': periodShortName,
    };
  }
}

//Class faisant reference de maniere static
//Aux principaux sports collectifs
class Sports {
  static Sport football = Sport(
    id: "ID_FOOTBALL",
    name: "FOOTBALL",
    periodCount: 2,
    periodName: "MI-TEMPS",
    periodShortName: "mt",
  );
  static Sport volleyball = Sport(
    id: "ID_VOLLEYBALL",
    name: "VOLLEYBALL",
    periodCount: 5,
    periodName: "SET",
    periodShortName: "set",
  );
  static Sport basketball = Sport(
    id: "ID_BASKETBAL",
    name: "BASKETBALL",
    periodCount: 4,
    periodName: "QUART-TEMPS",
    periodShortName: "qt",
  );
  static Sport handball = Sport(
    id: "ID_HANDBALL",
    name: "HANDBALL",
    periodCount: 2,
    periodName: "MI-TEMPS",
    periodShortName: "mt",
  );

  static Sport getSport(String id) {
    switch (id) {
      case "ID_FOOTBALL":
        return Sports.football;
      case "ID_VOLLEYBALLL":
        return Sports.volleyball;
      case "ID_BASKETBAL":
        return Sports.basketball;
      case "ID_HANDBALL":
        return Sports.handball;
      default:
        return Sports.football;
    }
  }
}

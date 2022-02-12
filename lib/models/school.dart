class School {
  final String id;
  final String name;
  final String logoUrl;
  School({required this.id, required this.name, required this.logoUrl});

  School.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          logoUrl: json['logoUrl']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
    };
  }
}

//Class faisant reference de maniere static
//Aux principales ecoles
class Schools {
  static School esi = School(id: "ID_ESI", name: "ESI", logoUrl: "");
  static School escae = School(id: "ID_ESCAE", name: "ESCAE", logoUrl: "");
  static School ep = School(id: "ID_EP", name: "EP", logoUrl: "");
  static School estp = School(id: "ID_ESTP", name: "ESTP", logoUrl: "");
  static School esmg = School(id: "ID_ESMG", name: "ESMG", logoUrl: "");
  static School esa = School(id: "ID_ESA", name: "ESA", logoUrl: "");

  static School getSchool(String id) {
    switch (id) {
      case "ID_ESI":
        return Schools.esi;
      case "ID_ESCAE":
        return Schools.escae;
      case "ID_EP":
        return Schools.ep;
      case "ID_ESTP":
        return Schools.estp;
      case "ID_ESMG":
        return Schools.esmg;
      case "ID_ESA":
        return Schools.esa;
      default:
        return Schools.esi;
    }
  }
}

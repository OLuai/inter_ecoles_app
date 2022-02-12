class Round {
  final String id;
  final String name;
  final DateTime date;
  bool isActive;

  Round(
      {required this.id,
      required this.name,
      required this.date,
      this.isActive = false});

  Round.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            date: json['date']! as DateTime,
            isActive: json['isActive']! as bool);
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'isAvtive': isActive,
    };
  }
}

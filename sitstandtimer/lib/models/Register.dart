final String tableRegister = 'register';

class RegisterFields {
  static final List<String> values = [
    // Add all fields
    id, date, sitTime, standTime, moveTime
  ];

  static final String id = '_id';
  static final String date = 'date';
  static final String sitTime = 'sitTime';
  static final String standTime = 'standTime';
  static final String moveTime = 'moveTime';
}

class Register {
  int? id;
  DateTime date;
  int sitTime;
  int standTime;
  int moveTime;

  Register({
    this.id,
    required this.date,
    required this.sitTime,
    required this.standTime,
    required this.moveTime,
  });

  Map<String, dynamic> toMap() {
    return {
      RegisterFields.id: id,
      RegisterFields.date: date.toIso8601String(),
      RegisterFields.sitTime: sitTime,
      RegisterFields.standTime: standTime,
      RegisterFields.moveTime: moveTime,
    };
  }

  Register.fromMap(Map<String, dynamic> map)
      : this.id = map[RegisterFields.id],
        this.date = DateTime.parse(map[RegisterFields.date] as String),
        this.sitTime = map[RegisterFields.sitTime],
        this.standTime = map[RegisterFields.standTime],
        this.moveTime = map[RegisterFields.moveTime];

  Register copy({
    int? id,
    DateTime? date,
    int? sitTime,
    int? standTime,
    int? moveTime,
  }) {
    return Register(
      id: id ?? this.id,
      date: date ?? this.date,
      sitTime: sitTime ?? this.sitTime,
      standTime: standTime ?? this.standTime,
      moveTime: moveTime ?? this.moveTime,
    );
  }
}

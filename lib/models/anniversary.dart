import 'package:age_calculator/age_calculator.dart';

const String tableAnniversary = 'anniversaries';

class AnniversaryFields {
  static final List<String> values = [
    id,
    name,
    date,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String date = 'date';
}

class Anniversary {
  int? id;
  final String name;
  final DateTime date;

  Anniversary({
    this.id,
    required this.name,
    required this.date,
  });

  Map<String, Object?> toJson() => {
        AnniversaryFields.id: id,
        AnniversaryFields.name: name,
        AnniversaryFields.date: date.toIso8601String(),
      };

  static Anniversary fromJson(Map<String, Object?> json) => Anniversary(
        id: json[AnniversaryFields.id] as int?,
        name: json[AnniversaryFields.name] as String,
        date: DateTime.parse(json[AnniversaryFields.date] as String),
      );

  Anniversary copy({
    int? id,
    String? name,
    DateTime? date,
  }) =>
      Anniversary(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
      );

  DateDuration get age {
    return AgeCalculator.age(date);
  }

  get remaining {
    final now = DateTime.now();
    final DateTime next;
    if (now.month > date.month || (now.month == date.month && now.day > date.day)) {
      next = DateTime(now.year + 1, date.month, date.day);
    } else {
      next = DateTime(now.year, date.month, date.day);
    }
    return next.difference(now).inDays;
  }
}

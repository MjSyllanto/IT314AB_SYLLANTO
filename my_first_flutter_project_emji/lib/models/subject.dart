class Subject {
  final int? id;
  final String code;
  final String name;
  final int units;
  final String? description;

  Subject({this.id, required this.code, required this.name, required this.units, this.description});

  factory Subject.fromRow(Map<String, dynamic> r) => Subject(
        id: r['subject_id'] as int,
        code: r['subject_code'] as String,
        name: r['subject_name'] as String,
        units: r['units'] as int,
        description: r['description'] as String?,
      );

  Map<String, dynamic> toRow() => {
        'subject_code': code,
        'subject_name': name,
        'units': units,
        'description': description,
      };
}

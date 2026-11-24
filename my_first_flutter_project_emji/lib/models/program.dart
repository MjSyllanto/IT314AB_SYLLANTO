class Program {
  final int id;
  final String code;
  final String? name;
  Program({required this.id, required this.code, this.name});

  factory Program.fromRow(Map<String, dynamic> r) => Program(
        id: r['program_id'] as int,
        code: r['program_code'] as String,
        name: r['program_name'] as String?,
      );
}

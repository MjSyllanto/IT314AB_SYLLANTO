class Student {
  final int? id;
  final String studentNumber;
  final String name;
  final String email;
  final int? programId;
  final String? programCode; // from JOIN, display only
  final int? yearLevel;
  final String? contactNumber;

  Student({
    this.id,
    required this.studentNumber,
    required this.name,
    required this.email,
    this.programId,
    this.programCode,
    this.yearLevel,
    this.contactNumber,
  });

  factory Student.fromRow(Map<String, dynamic> r) => Student(
        id: r['student_id'] as int,
        studentNumber: r['student_number'] as String,
        name: r['student_name'] as String,
        email: r['email'] as String,
        programId: r['program_id'] as int?,
        programCode: r['program_code'] as String?,
        yearLevel: r['year_level'] as int?,
        contactNumber: r['contact_number'] as String?,
      );

  Map<String, dynamic> toRow() => {
        'student_number': studentNumber,
        'student_name': name,
        'email': email,
        'program_id': programId,
        'year_level': yearLevel,
        'contact_number': contactNumber,
      };
}

class Grade {
  final int? id;
  final int enrollmentId;
  final double score;
  final String? remarks;
  final String? dateRecorded;
  final String? subjectCode; // display only
  final String? subjectName; // display only

  Grade({
    this.id,
    required this.enrollmentId,
    required this.score,
    this.remarks,
    this.dateRecorded,
    this.subjectCode,
    this.subjectName,
  });

  factory Grade.fromRow(Map<String, dynamic> r) => Grade(
        id: r['grade_id'] as int,
        enrollmentId: r['enrollment_id'] as int,
        score: (r['score'] as num).toDouble(),
        remarks: r['remarks'] as String?,
        dateRecorded: r['date_recorded'] as String?,
        subjectCode: r['subject_code'] as String?,
        subjectName: r['subject_name'] as String?,
      );

  Map<String, dynamic> toRow() => {
        'enrollment_id': enrollmentId,
        'score': score,
        'remarks': remarks,
      };
}

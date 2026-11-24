class Enrollment {
  final int id;
  final int studentId;
  final int subjectId;
  final int scheduleId;
  final String status; // 'Enrolled' | 'Dropped'
  final String subjectCode;
  final String subjectName;
  final String day;
  final String startTime;
  final String endTime;
  final String room;

  Enrollment({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.scheduleId,
    required this.status,
    required this.subjectCode,
    required this.subjectName,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
  });

  bool get isEnrolled => status == 'Enrolled';
  String get timeLabel => '${startTime.substring(0, 5)} - ${endTime.substring(0, 5)}';

  factory Enrollment.fromRow(Map<String, dynamic> r) => Enrollment(
        id: r['enrollment_id'] as int,
        studentId: r['student_id'] as int,
        subjectId: r['subject_id'] as int,
        scheduleId: r['schedule_id'] as int,
        status: r['status'] as String,
        subjectCode: r['subject_code'] as String,
        subjectName: r['subject_name'] as String,
        day: r['day_of_week'] as String,
        startTime: r['start_time'] as String,
        endTime: r['end_time'] as String,
        room: r['room'] as String,
      );
}

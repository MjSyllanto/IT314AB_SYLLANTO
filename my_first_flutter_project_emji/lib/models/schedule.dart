class Schedule {
  final int? id;
  final int subjectId;
  final String day;
  final String startTime; // "HH:mm" or "HH:mm:ss"
  final String endTime;
  final String room;
  final int capacity;
  // From JOIN / subquery, display only:
  final String? subjectCode;
  final String? subjectName;
  final int? remaining;

  Schedule({
    this.id,
    required this.subjectId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.capacity,
    this.subjectCode,
    this.subjectName,
    this.remaining,
  });

  String get timeLabel => '${startTime.substring(0, 5)} - ${endTime.substring(0, 5)}';

  factory Schedule.fromRow(Map<String, dynamic> r) => Schedule(
        id: r['schedule_id'] as int,
        subjectId: r['subject_id'] as int,
        day: r['day_of_week'] as String,
        startTime: r['start_time'] as String,
        endTime: r['end_time'] as String,
        room: r['room'] as String,
        capacity: r['slot_capacity'] as int,
        subjectCode: r['subject_code'] as String?,
        subjectName: r['subject_name'] as String?,
        remaining: r['remaining'] as int?,
      );

  Map<String, dynamic> toRow() => {
        'subject_id': subjectId,
        'day_of_week': day,
        'start_time': startTime,
        'end_time': endTime,
        'room': room,
        'slot_capacity': capacity,
      };
}

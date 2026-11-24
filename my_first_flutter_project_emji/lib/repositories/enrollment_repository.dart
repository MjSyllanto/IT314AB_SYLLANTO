import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/enrollment.dart';

class EnrollmentRepository {
  Future<List<Enrollment>> getByStudent(int studentId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT e.enrollment_id, e.student_id, e.subject_id, e.schedule_id, e.status,
             su.subject_code, su.subject_name, sc.day_of_week,
             sc.start_time::text AS start_time, sc.end_time::text AS end_time, sc.room
      FROM enrollment e
      JOIN subject su ON su.subject_id = e.subject_id
      JOIN schedule sc ON sc.schedule_id = e.schedule_id
      WHERE e.student_id = @studentId
      ORDER BY e.status DESC, su.subject_code
    '''), parameters: {'studentId': studentId});
    return result.map((r) => Enrollment.fromRow(r.toColumnMap())).toList();
  }

  /// The subject a schedule belongs to (null if schedule not found).
  Future<int?> subjectIdOfSchedule(int scheduleId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(
        Sql.named('SELECT subject_id FROM schedule WHERE schedule_id = @id'),
        parameters: {'id': scheduleId});
    if (result.isEmpty) return null;
    return result.first.toColumnMap()['subject_id'] as int;
  }

  /// Slots left = capacity - active enrollments.
  Future<int> remainingSlots(int scheduleId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT sc.slot_capacity - COUNT(e.enrollment_id) AS remaining
      FROM schedule sc
      LEFT JOIN enrollment e ON e.schedule_id = sc.schedule_id AND e.status = 'Enrolled'
      WHERE sc.schedule_id = @scheduleId
      GROUP BY sc.slot_capacity
    '''), parameters: {'scheduleId': scheduleId});
    if (result.isEmpty) return 0;
    return result.first.toColumnMap()['remaining'] as int;
  }

  /// Any existing enrollment row for this student + subject (Enrolled OR Dropped).
  Future<({int id, String status})?> findExisting(int studentId, int subjectId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT enrollment_id, status FROM enrollment
      WHERE student_id = @studentId AND subject_id = @subjectId
    '''), parameters: {'studentId': studentId, 'subjectId': subjectId});
    if (result.isEmpty) return null;
    final m = result.first.toColumnMap();
    return (id: m['enrollment_id'] as int, status: m['status'] as String);
  }

  /// True if the new schedule overlaps (same day) any of the student's active enrollments.
  Future<bool> hasConflict(int studentId, int scheduleId, {int excludeEnrollmentId = 0}) async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT 1
      FROM enrollment e
      JOIN schedule s ON s.schedule_id = e.schedule_id
      JOIN schedule n ON n.schedule_id = @scheduleId
      WHERE e.student_id = @studentId
        AND e.status = 'Enrolled'
        AND e.enrollment_id <> @excludeId
        AND s.day_of_week = n.day_of_week
        AND n.start_time < s.end_time
        AND n.end_time > s.start_time
      LIMIT 1
    '''), parameters: {
      'scheduleId': scheduleId,
      'studentId': studentId,
      'excludeId': excludeEnrollmentId,
    });
    return result.isNotEmpty;
  }

  Future<void> insert(int studentId, int subjectId, int scheduleId) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      INSERT INTO enrollment (student_id, subject_id, schedule_id, status)
      VALUES (@studentId, @subjectId, @scheduleId, 'Enrolled')
    '''), parameters: {'studentId': studentId, 'subjectId': subjectId, 'scheduleId': scheduleId});
  }

  /// Re-enroll a previously dropped row (UNIQUE(student_id, subject_id) allows only one row).
  Future<void> reactivate(int enrollmentId, int scheduleId) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      UPDATE enrollment SET status = 'Enrolled', schedule_id = @scheduleId, enrolled_at = NOW()
      WHERE enrollment_id = @id
    '''), parameters: {'id': enrollmentId, 'scheduleId': scheduleId});
  }

  Future<void> changeSchedule(int enrollmentId, int scheduleId) async {
    final c = await DbConnection.instance;
    await c.execute(
        Sql.named('UPDATE enrollment SET schedule_id = @scheduleId WHERE enrollment_id = @id'),
        parameters: {'id': enrollmentId, 'scheduleId': scheduleId});
  }

  Future<void> drop(int enrollmentId) async {
    final c = await DbConnection.instance;
    await c.execute(
        Sql.named("UPDATE enrollment SET status = 'Dropped' WHERE enrollment_id = @id"),
        parameters: {'id': enrollmentId});
  }
}

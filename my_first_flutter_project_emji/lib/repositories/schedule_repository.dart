import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/schedule.dart';

class ScheduleRepository {
  // remaining = capacity - number of students currently 'Enrolled'
  static const _select = '''
    SELECT sc.schedule_id, sc.subject_id, sc.day_of_week,
           sc.start_time::text AS start_time, sc.end_time::text AS end_time,
           sc.room, sc.slot_capacity, su.subject_code, su.subject_name,
           sc.slot_capacity - (
             SELECT COUNT(*) FROM enrollment e
             WHERE e.schedule_id = sc.schedule_id AND e.status = 'Enrolled'
           ) AS remaining
    FROM schedule sc
    JOIN subject su ON su.subject_id = sc.subject_id
  ''';

  Future<List<Schedule>> getBySubject(int subjectId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(
        Sql.named('$_select WHERE sc.subject_id = @subjectId ORDER BY sc.day_of_week, sc.start_time'),
        parameters: {'subjectId': subjectId});
    return result.map((r) => Schedule.fromRow(r.toColumnMap())).toList();
  }

  Future<List<Schedule>> getAll() async {
    final c = await DbConnection.instance;
    final result = await c.execute(
        Sql.named('$_select ORDER BY su.subject_code, sc.day_of_week, sc.start_time'));
    return result.map((r) => Schedule.fromRow(r.toColumnMap())).toList();
  }

  Future<void> insert(Schedule s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      INSERT INTO schedule (subject_id, day_of_week, start_time, end_time, room, slot_capacity)
      VALUES (@subject_id, @day_of_week, @start_time::text::time, @end_time::text::time,
              @room, @slot_capacity::int)
    '''), parameters: s.toRow());
  }

  Future<void> update(Schedule s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      UPDATE schedule SET day_of_week = @day_of_week,
        start_time = @start_time::text::time, end_time = @end_time::text::time,
        room = @room, slot_capacity = @slot_capacity::int
      WHERE schedule_id = @id
    '''), parameters: {
      'day_of_week': s.day,
      'start_time': s.startTime,
      'end_time': s.endTime,
      'room': s.room,
      'slot_capacity': s.capacity,
      'id': s.id,
    });
  }

  Future<void> delete(int id) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('DELETE FROM schedule WHERE schedule_id = @id'),
        parameters: {'id': id});
  }
}

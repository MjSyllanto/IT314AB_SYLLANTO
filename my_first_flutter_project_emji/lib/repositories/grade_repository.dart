import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/grade.dart';

class GradeRepository {
  Future<List<Grade>> getByStudent(int studentId) async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT g.grade_id, g.enrollment_id, g.score::float8 AS score, g.remarks,
             g.date_recorded::text AS date_recorded, su.subject_code, su.subject_name
      FROM grades g
      JOIN enrollment e ON e.enrollment_id = g.enrollment_id
      JOIN subject su ON su.subject_id = e.subject_id
      WHERE e.student_id = @studentId
      ORDER BY su.subject_code
    '''), parameters: {'studentId': studentId});
    return result.map((r) => Grade.fromRow(r.toColumnMap())).toList();
  }

  /// Inserts only if the enrollment exists AND is 'Enrolled'. Returns rows inserted (0 = rejected).
  Future<int> insert(Grade g) async {
    final c = await DbConnection.instance;
    final r = await c.execute(Sql.named('''
      INSERT INTO grades (enrollment_id, score, remarks)
      SELECT @enrollment_id::int, @score::float8, @remarks::text
      WHERE EXISTS (
        SELECT 1 FROM enrollment
        WHERE enrollment_id = @enrollment_id::int AND status = 'Enrolled'
      )
    '''), parameters: g.toRow());
    return r.affectedRows;
  }

  Future<void> update(Grade g) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      UPDATE grades SET score = @score::float8, remarks = @remarks::text,
        date_recorded = CURRENT_DATE
      WHERE grade_id = @id
    '''), parameters: {'score': g.score, 'remarks': g.remarks, 'id': g.id});
  }

  Future<void> delete(int id) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('DELETE FROM grades WHERE grade_id = @id'),
        parameters: {'id': id});
  }
}

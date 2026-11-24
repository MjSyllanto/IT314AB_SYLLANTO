import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/student.dart';

class StudentRepository {
  Future<List<Student>> getAll() async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named('''
      SELECT s.student_id, s.student_number, s.student_name, s.email,
             s.program_id, s.year_level, s.contact_number, p.program_code
      FROM students s
      LEFT JOIN programs p ON p.program_id = s.program_id
      ORDER BY s.student_name
    '''));
    return result.map((r) => Student.fromRow(r.toColumnMap())).toList();
  }

  Future<void> insert(Student s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      INSERT INTO students
        (student_number, student_name, email, program_id, year_level, contact_number)
      VALUES
        (@student_number, @student_name, @email, @program_id::int, @year_level::int, @contact_number)
    '''), parameters: s.toRow());
  }

  Future<void> update(Student s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      UPDATE students SET
        student_number = @student_number,
        student_name = @student_name,
        email = @email,
        program_id = @program_id::int,
        year_level = @year_level::int,
        contact_number = @contact_number
      WHERE student_id = @id
    '''), parameters: {...s.toRow(), 'id': s.id});
  }

  Future<void> delete(int id) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('DELETE FROM students WHERE student_id = @id'),
        parameters: {'id': id});
  }
}

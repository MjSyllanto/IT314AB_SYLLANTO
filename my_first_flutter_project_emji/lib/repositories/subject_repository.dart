import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/subject.dart';

class SubjectRepository {
  Future<List<Subject>> getAll() async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named(
        'SELECT subject_id, subject_code, subject_name, units, description FROM subject ORDER BY subject_code'));
    return result.map((r) => Subject.fromRow(r.toColumnMap())).toList();
  }

  Future<void> insert(Subject s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      INSERT INTO subject (subject_code, subject_name, units, description)
      VALUES (@subject_code, @subject_name, @units::int, @description)
    '''), parameters: s.toRow());
  }

  Future<void> update(Subject s) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('''
      UPDATE subject SET subject_code = @subject_code, subject_name = @subject_name,
        units = @units::int, description = @description
      WHERE subject_id = @id
    '''), parameters: {...s.toRow(), 'id': s.id});
  }

  Future<void> delete(int id) async {
    final c = await DbConnection.instance;
    await c.execute(Sql.named('DELETE FROM subject WHERE subject_id = @id'),
        parameters: {'id': id});
  }
}

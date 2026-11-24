import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/program.dart';

class ProgramRepository {
  Future<List<Program>> getAll() async {
    final c = await DbConnection.instance;
    final result = await c.execute(Sql.named(
        'SELECT program_id, program_code, program_name FROM programs ORDER BY program_code'));
    return result.map((r) => Program.fromRow(r.toColumnMap())).toList();
  }
}

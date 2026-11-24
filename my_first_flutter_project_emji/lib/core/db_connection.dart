import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart';

class DbConnection {
  DbConnection._();
  static Connection? _conn;

  static Future<Connection> get instance async {
    if (_conn != null && _conn!.isOpen) return _conn!;
    _conn = await Connection.open(
      Endpoint(
        host: dotenv.env['DB_HOST']!,
        database: dotenv.env['DB_NAME']!,
        username: dotenv.env['DB_USER']!,
        password: dotenv.env['DB_PASSWORD']!,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );
    return _conn!;
  }

  static Future<String?> testConnection() async {
    try {
      final c = await instance;
      await c.execute('SELECT 1');
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
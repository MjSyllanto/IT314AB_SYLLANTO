import 'package:postgres/postgres.dart';

/// Turns database errors into messages a user can understand.
String friendlyError(Object e, String action) {
  if (e is ServerException) {
    switch (e.code) {
      case '23505':
        return 'Duplicate value: that record already exists.';
      case '23503':
        return 'Cannot $action: other records depend on this one.';
      case '23514':
        return 'A value was rejected by the database rules.';
    }
    return 'Database error: ${e.message}';
  }
  return 'Could not $action. Check your connection.';
}
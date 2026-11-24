import 'package:flutter/foundation.dart';
import '../core/error_mapper.dart';
import '../models/program.dart';
import '../models/student.dart';
import '../repositories/program_repository.dart';
import '../repositories/student_repository.dart';

class StudentViewModel extends ChangeNotifier {
  final _repo = StudentRepository();
  final _programRepo = ProgramRepository();

  List<Student> students = [];
  List<Program> programs = [];
  bool isLoading = false;
  String? errorMessage;

  Student? byId(int id) {
    for (final s in students) {
      if (s.id == id) return s;
    }
    return null;
  }

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      students = await _repo.getAll();
      programs = await _programRepo.getAll();
    } catch (e) {
      errorMessage = friendlyError(e, 'load students');
    }
    isLoading = false;
    notifyListeners();
  }

  /// Returns null on success, or an error message.
  Future<String?> save(Student s) async {
    try {
      s.id == null ? await _repo.insert(s) : await _repo.update(s);
      await load();
      return null;
    } catch (e) {
      return friendlyError(e, 'save student');
    }
  }

  Future<String?> remove(int id) async {
    try {
      await _repo.delete(id);
      await load();
      return null;
    } catch (e) {
      return friendlyError(e, 'delete this student (they have enrollments)');
    }
  }
}

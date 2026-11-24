import 'package:flutter/foundation.dart';
import '../core/error_mapper.dart';
import '../models/grade.dart';
import '../repositories/grade_repository.dart';

class GradeViewModel extends ChangeNotifier {
  final _repo = GradeRepository();

  List<Grade> grades = [];
  bool isLoading = false;
  String? errorMessage;
  int? _studentId;

  Grade? gradeFor(int enrollmentId) {
    for (final g in grades) {
      if (g.enrollmentId == enrollmentId) return g;
    }
    return null;
  }

  Future<void> loadForStudent(int studentId) async {
    _studentId = studentId;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      grades = await _repo.getByStudent(studentId);
    } catch (e) {
      errorMessage = friendlyError(e, 'load grades');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<String?> save(Grade g) async {
    try {
      if (g.id == null) {
        final inserted = await _repo.insert(g);
        if (inserted == 0) return 'Grades can only be added to active enrollments.';
      } else {
        await _repo.update(g);
      }
      if (_studentId != null) await loadForStudent(_studentId!);
      return null;
    } catch (e) {
      return friendlyError(e, 'save grade');
    }
  }

  Future<String?> remove(int id) async {
    try {
      await _repo.delete(id);
      if (_studentId != null) await loadForStudent(_studentId!);
      return null;
    } catch (e) {
      return friendlyError(e, 'delete grade');
    }
  }
}

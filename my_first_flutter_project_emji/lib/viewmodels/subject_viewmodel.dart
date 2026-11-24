import 'package:flutter/foundation.dart';
import '../core/error_mapper.dart';
import '../models/subject.dart';
import '../repositories/subject_repository.dart';

class SubjectViewModel extends ChangeNotifier {
  final _repo = SubjectRepository();

  List<Subject> subjects = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      subjects = await _repo.getAll();
    } catch (e) {
      errorMessage = friendlyError(e, 'load subjects');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<String?> save(Subject s) async {
    try {
      s.id == null ? await _repo.insert(s) : await _repo.update(s);
      await load();
      return null;
    } catch (e) {
      return friendlyError(e, 'save subject');
    }
  }

  Future<String?> remove(int id) async {
    try {
      await _repo.delete(id);
      await load();
      return null;
    } catch (e) {
      return friendlyError(e, 'delete this subject (it has schedules or enrollments)');
    }
  }
}

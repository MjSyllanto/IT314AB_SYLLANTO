import 'package:flutter/foundation.dart';
import '../core/error_mapper.dart';
import '../models/schedule.dart';
import '../repositories/schedule_repository.dart';

class ScheduleViewModel extends ChangeNotifier {
  final _repo = ScheduleRepository();

  List<Schedule> schedules = [];
  bool isLoading = false;
  String? errorMessage;
  int? _subjectFilter; // null = all subjects

  Future<void> loadForSubject(int subjectId) {
    _subjectFilter = subjectId;
    return _reload();
  }

  Future<void> loadAll() {
    _subjectFilter = null;
    return _reload();
  }

  Future<void> reload() => _reload();

  Future<void> _reload() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      schedules = _subjectFilter == null
          ? await _repo.getAll()
          : await _repo.getBySubject(_subjectFilter!);
    } catch (e) {
      errorMessage = friendlyError(e, 'load schedules');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<String?> save(Schedule s) async {
    try {
      s.id == null ? await _repo.insert(s) : await _repo.update(s);
      await _reload();
      return null;
    } catch (e) {
      return friendlyError(e, 'save schedule');
    }
  }

  Future<String?> remove(int id) async {
    try {
      await _repo.delete(id);
      await _reload();
      return null;
    } catch (e) {
      return friendlyError(e, 'delete this schedule (students are enrolled in it)');
    }
  }
}

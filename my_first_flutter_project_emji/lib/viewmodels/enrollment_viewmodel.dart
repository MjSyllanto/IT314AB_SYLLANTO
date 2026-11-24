import 'package:flutter/foundation.dart';
import '../core/error_mapper.dart';
import '../models/enrollment.dart';
import '../repositories/enrollment_repository.dart';

class EnrollmentViewModel extends ChangeNotifier {
  final _repo = EnrollmentRepository();

  List<Enrollment> items = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadForStudent(int studentId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      items = await _repo.getByStudent(studentId);
    } catch (e) {
      errorMessage = friendlyError(e, 'load enrollments');
    }
    isLoading = false;
    notifyListeners();
  }

  /// Enrollment workflow. Returns null on success, or the reason it was rejected.
  Future<String?> enroll(int studentId, int scheduleId) async {
    try {
      final subjectId = await _repo.subjectIdOfSchedule(scheduleId);
      if (subjectId == null) return 'That schedule no longer exists.';

      // 3. schedule availability / remaining slots
      if (await _repo.remainingSlots(scheduleId) <= 0) {
        return 'This schedule is full. No slots remaining.';
      }
      // 4. duplicate enrollment
      final existing = await _repo.findExisting(studentId, subjectId);
      if (existing != null && existing.status == 'Enrolled') {
        return 'Student is already enrolled in this subject.';
      }
      // schedule conflict
      if (await _repo.hasConflict(studentId, scheduleId)) {
        return 'Schedule conflict: overlaps with another enrolled subject.';
      }
      // 6-7. create + save
      if (existing == null) {
        await _repo.insert(studentId, subjectId, scheduleId);
      } else {
        await _repo.reactivate(existing.id, scheduleId); // previously dropped
      }
      await loadForStudent(studentId);
      return null;
    } catch (e) {
      return friendlyError(e, 'enroll student');
    }
  }

  Future<String?> changeSchedule(Enrollment e, int newScheduleId) async {
    try {
      if (newScheduleId == e.scheduleId) return 'That is already the current schedule.';
      final subjectId = await _repo.subjectIdOfSchedule(newScheduleId);
      if (subjectId != e.subjectId) return 'Schedule must belong to the same subject.';
      if (await _repo.remainingSlots(newScheduleId) <= 0) {
        return 'This schedule is full. No slots remaining.';
      }
      if (await _repo.hasConflict(e.studentId, newScheduleId, excludeEnrollmentId: e.id)) {
        return 'Schedule conflict: overlaps with another enrolled subject.';
      }
      await _repo.changeSchedule(e.id, newScheduleId);
      await loadForStudent(e.studentId);
      return null;
    } catch (err) {
      return friendlyError(err, 'change schedule');
    }
  }

  Future<String?> drop(Enrollment e) async {
    try {
      await _repo.drop(e.id);
      await loadForStudent(e.studentId);
      return null;
    } catch (err) {
      return friendlyError(err, 'drop subject');
    }
  }
}

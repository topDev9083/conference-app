import '../utils/dio.dart';

class _UserNoteService {
  Future<void> updateUserNote({
    required final int userId,
    required final String note,
  }) {
    return dio.put(
      'user-notes/users/$userId',
      data: {
        'note': note,
      },
    );
  }
}

final userNoteService = _UserNoteService();

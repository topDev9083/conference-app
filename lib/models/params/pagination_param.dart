import 'package:flutter/foundation.dart';

@immutable
class PaginationParam {
  final int? _offset;
  final int? _limit;

  const PaginationParam({
    final int? offset,
    final int? limit,
  })  : _offset = offset,
        _limit = limit;

  int? get limit => _limit;

  int? get offset => _offset;
}

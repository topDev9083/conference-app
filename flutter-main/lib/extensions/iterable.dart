extension IterableExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;

  E? firstWhereOrNull(final bool Function(E) test) {
    final list = toList();
    final index = list.indexWhere(test);
    if (index == -1) {
      return null;
    }
    return list[index];
  }

  E? get lastOrNull => isEmpty ? null : last;
}

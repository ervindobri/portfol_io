extension ListExtensions<E> on Iterable<E> {
  Iterable<T> expandWithSeparator<T>(
    T Function(E element) toElements,
    T separator,
  ) sync* {
    bool first = true;

    for (final element in this) {
      if (first) {
        first = false;
      } else {
        yield separator;
      }
      yield toElements(element);
    }
  }
}

abstract class BaseRepository<T> {
  Future<T?> get(String id);
  Future<List<T>> getAll();
  Future<void> create(T item);
  Future<void> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
  Stream<List<T>> streamAll();
}

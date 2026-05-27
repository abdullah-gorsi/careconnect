import 'package:cloud_firestore/cloud_firestore.dart';
import 'base_repository.dart';

abstract class BaseFirestoreRepository<T> implements BaseRepository<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// The path to the Firestore collection.
  String get collectionPath;

  /// Converts a JSON map and document ID into an item of type [T].
  T fromJson(Map<String, dynamic> json, String id);

  /// Converts an item of type [T] into a JSON map.
  Map<String, dynamic> toJson(T item);

  /// Returns a reference to the Firestore collection.
  CollectionReference<Map<String, dynamic>> get collection => 
      _firestore.collection(collectionPath);

  /// Adds a new item to the collection.
  @override
  Future<void> create(T item) async {
    await collection.add(toJson(item));
  }
  
  /// Adds a new item to the collection with a specific ID.
  Future<void> createWithId(T item, String id) async {
    await collection.doc(id).set(toJson(item));
  }

  /// Retrieves an item by its ID.
  @override
  Future<T?> get(String id) async {
    final doc = await collection.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  /// Retrieves all items from the collection.
  @override
  Future<List<T>> getAll() async {
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) => fromJson(doc.data(), doc.id)).toList();
  }

  /// Updates an item in the collection by its ID.
  @override
  Future<void> update(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  /// Deletes an item from the collection by its ID.
  @override
  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  /// Streams all items from the collection.
  @override
  Stream<List<T>> streamAll() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => fromJson(doc.data(), doc.id)).toList();
    });
  }
}

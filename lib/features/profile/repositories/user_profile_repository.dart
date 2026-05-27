import '../../../core/base/base_firestore_repository.dart';
import '../models/user_profile.dart';

class UserProfileRepository extends BaseFirestoreRepository<UserProfile> {
  @override
  String get collectionPath => 'users';

  @override
  UserProfile fromJson(Map<String, dynamic> json, String id) {
    // Ensure the ID is injected into the model from the document ID
    final data = Map<String, dynamic>.from(json);
    data['id'] = id;
    return UserProfile.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson(UserProfile item) {
    return item.toJson();
  }
}

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/auth_service.dart';
import '../repositories/user_profile_repository.dart';
import '../models/user_profile.dart';
import '../services/cloudinary_service.dart';

class ProfileViewModel extends GetxController {
  final UserProfileRepository _profileRepository;
  final AuthService _authService;
  final CloudinaryService _cloudinaryService;

  ProfileViewModel({
    required UserProfileRepository profileRepository,
    required AuthService authService,
    required CloudinaryService cloudinaryService,
  })  : _profileRepository = profileRepository,
        _authService = authService,
        _cloudinaryService = cloudinaryService;

  static final _guestProfile = UserProfile(
    id: 'guest',
    name: 'Guest User',
    email: 'guest@careconnect.com',
    phone: '',
    role: 'Visitor',
    createdAt: DateTime.now(),
  );

  final Rx<UserProfile> userProfile = Rx<UserProfile>(_guestProfile);
  final RxBool isLoading = true.obs;
  final RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes to trigger profile load
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        loadUserProfile();
      } else {
        userProfile.value = _guestProfile;
        isLoading.value = false;
      }
    });
  }

  String get currentUserId => _authService.currentUser?.uid ?? '';

  Future<void> loadUserProfile() async {
    final uid = currentUserId;
    if (uid.isEmpty) { 
        Get.log('ProfileViewModel: No user logged in');
        return; 
    }

    isLoading.value = true;
    try {
        // Direct stream from collection via Repository
        _profileRepository.collection.doc(uid).snapshots().listen((doc) {
             if (doc.exists && doc.data() != null) {
                userProfile.value = _profileRepository.fromJson(doc.data()!, doc.id);
                isLoading.value = false;
             } else {
                Get.log('ProfileViewModel: Profile not found, creating default...');
                _createDefaultProfile().catchError((e) {
                   Get.log('ProfileViewModel: Failed to create default profile: $e');
                   isLoading.value = false;
                });
             }
        }, onError: (e) {
             Get.log('Error loading profile: $e');
             isLoading.value = false;
        });

    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile', snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    }
  }

  Future<void> _createDefaultProfile() async {
    final user = _authService.currentUser;
    if (user != null) {
      final newProfile = UserProfile(
        id: user.uid,
        name: user.displayName ?? 'New User',
        email: user.email ?? '',
        phone: '',
        role: 'Care Partner',
        createdAt: DateTime.now(),
      );
      // Use Repository Create
      await _profileRepository.createWithId(newProfile, user.uid);
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? role,
  }) async {
    if (userProfile.value.id == 'guest') return;

    try {
      final updatedProfile = userProfile.value.copyWith(
        name: name,
        phone: phone,
        role: role,
        updatedAt: DateTime.now(),
      );
      
      await _profileRepository.createWithId(updatedProfile, updatedProfile.id);
      
      Get.snackbar('Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteProfile() async {
      if (userProfile.value.id == 'guest') return;
      try {
          await _profileRepository.delete(userProfile.value.id);
          userProfile.value = _guestProfile;
          Get.snackbar('Success', 'Profile deleted', snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
          Get.snackbar('Error', 'Failed to delete profile', snackPosition: SnackPosition.BOTTOM);
      }
  }

  /// Uploads a profile picture to Cloudinary and updates the user profile
  /// 
  /// [imageFile] - The image file selected by the user
  Future<void> uploadProfilePicture(XFile imageFile) async {
    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      Get.snackbar('Error', 'Please login to upload profile picture',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    
    // Ensure we have a valid profile ID to update
    if (userProfile.value.id == 'guest') {
       // Try to use current user ID if profile isn't loaded yet
       userProfile.value = userProfile.value.copyWith(id: currentUser.uid);
    }

    isUploading.value = true;
    try {
      // Upload image to Cloudinary
      final imageUrl = await _cloudinaryService.uploadImage(imageFile);
      
      // Update profile with new photo URL
      final updatedProfile = userProfile.value.copyWith(
        photoUrl: imageUrl,
        updatedAt: DateTime.now(),
      );
      
      // Save to Firestore
      await _profileRepository.createWithId(updatedProfile, updatedProfile.id);
      
      Get.snackbar('Success', 'Profile picture updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload profile picture: $e',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4));
    } finally {
      isUploading.value = false;
    }
  }
}

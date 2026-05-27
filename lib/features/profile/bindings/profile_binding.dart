import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../repositories/user_profile_repository.dart';
import '../services/cloudinary_service.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Inject Repository
    Get.lazyPut(() => UserProfileRepository());
    
    // Inject CloudinaryService
    Get.lazyPut(() => CloudinaryService());
    
    Get.lazyPut<ProfileViewModel>(
      () => ProfileViewModel(
        profileRepository: Get.find<UserProfileRepository>(),
        authService: Get.find<AuthService>(),
        cloudinaryService: Get.find<CloudinaryService>(),
      ),
    );
  }
}

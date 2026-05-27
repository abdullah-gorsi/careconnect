import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../core/routes/app_routes.dart';

/// EmailVerificationViewModel
/// Handles resending verification emails and checking verification status.
class EmailVerificationViewModel extends GetxController {
  EmailVerificationViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? Get.find<AuthRepository>();

  final AuthRepository _authRepository;

  /// Observable for verification checking state.
  final RxBool _isChecking = false.obs;

  /// Returns true if currently checking verification status.
  bool get isChecking => _isChecking.value;

  /// Resends the verification email to the current user.
  Future<void> resendEmail() async {
    try {
      await _authRepository.sendEmailVerification();
      Get.snackbar(
        'Email sent',
        'Verification email has been sent.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Checks if the user's email has been verified.
  /// 
  /// Reloads user data and navigates to Home if verified.
  Future<void> checkVerification() async {
    try {
      _isChecking.value = true;
      await _authRepository.reloadUser();
      if (_authRepository.isEmailVerified) {
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Email Verified',
          'Your email has been verified successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isChecking.value = false;
    }
  }
}


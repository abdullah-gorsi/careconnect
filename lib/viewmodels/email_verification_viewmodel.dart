import 'package:get/get.dart';

import '../auth_repo/auth_repo.dart';
import '../core/routes/app_routes.dart';

/// EmailVerificationViewModel
/// Handles resending verification emails and checking verification status.
class EmailVerificationViewModel extends GetxController {
  EmailVerificationViewModel({AuthRepo? authRepo})
      : _authRepo = authRepo ?? Get.find<AuthRepo>();

  final AuthRepo _authRepo;

  final RxBool _isChecking = false.obs;

  bool get isChecking => _isChecking.value;

  Future<void> resendEmail() async {
    try {
      await _authRepo.sendEmailVerification();
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

  Future<void> checkVerification() async {
    try {
      _isChecking.value = true;
      await _authRepo.reloadUser();
      if (_authRepo.isEmailVerified) {
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



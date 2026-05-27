import 'package:get/get.dart';

import '../auth_repo/auth_repo.dart';

/// ForgotPasswordViewModel
/// Handles sending password reset email.
class ForgotPasswordViewModel extends GetxController {
  ForgotPasswordViewModel({AuthRepo? authRepo})
      : _authRepo = authRepo ?? Get.find<AuthRepo>();

  final AuthRepo _authRepo;

  final RxString _email = ''.obs;
  final RxBool _isLoading = false.obs;

  String get email => _email.value;
  bool get isLoading => _isLoading.value;

  void setEmail(String value) => _email.value = value.trim();

  Future<bool> sendResetEmail() async {
    if (email.isEmpty) {
      Get.snackbar(
        'Missing email',
        'Please enter your email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoading.value = true;
    try {
      await _authRepo.resetPassword(email: email);
      Get.back();
      Get.snackbar(
        'Email sent',
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}



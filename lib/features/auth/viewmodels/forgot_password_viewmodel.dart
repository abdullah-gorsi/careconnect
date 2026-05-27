import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';

/// ForgotPasswordViewModel
/// Handles sending password reset email.
class ForgotPasswordViewModel extends GetxController {
  ForgotPasswordViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? Get.find<AuthRepository>();

  final AuthRepository _authRepository;

  /// Observable for email input.
  final RxString _email = ''.obs;
  
  /// Loading state during email sending.
  final RxBool _isLoading = false.obs;

  /// Returns the current email value.
  String get email => _email.value;
  
  /// Returns the loading state.
  bool get isLoading => _isLoading.value;

  /// Updates the email value.
  void setEmail(String value) => _email.value = value.trim();

  /// Sends a password reset link to the entered email.
  /// 
  /// Validates email presence before sending.
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
      await _authRepository.resetPassword(email: email);
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


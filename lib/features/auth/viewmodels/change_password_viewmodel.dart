import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';

/// ChangePasswordViewModel
/// Handles change password flow.
class ChangePasswordViewModel extends GetxController {
  ChangePasswordViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? Get.find<AuthRepository>();

  final AuthRepository _authRepository;

  /// Observable for current password input.
  final RxString _currentPassword = ''.obs;
  
  /// Observable for new password input.
  final RxString _newPassword = ''.obs;

  /// Loading state during password change operation.
  final RxBool _isLoading = false.obs;

  /// Getter for current password value.
  String get currentPassword => _currentPassword.value;
  
  /// Getter for new password value.
  String get newPassword => _newPassword.value;
  
  /// Returns whether an operation is in progress.
  bool get isLoading => _isLoading.value;

  /// Updates the current password value.
  void setCurrentPassword(String value) => _currentPassword.value = value;
  
  /// Updates the new password value.
  void setNewPassword(String value) => _newPassword.value = value;

  /// Attempts to change the user's password.
  /// 
  /// Validates inputs and calls the repository.
  /// Returns `true` if successful, `false` otherwise.
  Future<bool> changePassword() async {
    if (currentPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please enter both current and new password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoading.value = true;
    try {
      await _authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Password changed successfully.',
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


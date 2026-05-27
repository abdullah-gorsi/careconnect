import 'package:get/get.dart';

import '../auth_repo/auth_repo.dart';

/// ChangePasswordViewModel
/// Handles change password flow.
class ChangePasswordViewModel extends GetxController {
  ChangePasswordViewModel({AuthRepo? authRepo})
      : _authRepo = authRepo ?? Get.find<AuthRepo>();

  final AuthRepo _authRepo;

  final RxString _currentPassword = ''.obs;
  final RxString _newPassword = ''.obs;

  final RxBool _isLoading = false.obs;

  String get currentPassword => _currentPassword.value;
  String get newPassword => _newPassword.value;
  bool get isLoading => _isLoading.value;

  void setCurrentPassword(String value) => _currentPassword.value = value;
  void setNewPassword(String value) => _newPassword.value = value;

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
      await _authRepo.changePassword(
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



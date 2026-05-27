import 'package:get/get.dart';

import '../auth_repo/auth_repo.dart';
import '../core/routes/app_routes.dart';

class LoginViewModel extends GetxController {
  LoginViewModel({AuthRepo? authRepo})
      : _authRepo = authRepo ?? Get.find<AuthRepo>();

  final AuthRepo _authRepo;

  // Reactive form fields
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;

  // UI state
  final RxBool _isLoading = false.obs;
  final RxBool _obscurePassword = true.obs;

  // Getters
  String get email => _email.value;
  String get password => _password.value;
  bool get isLoading => _isLoading.value;
  bool get obscurePassword => _obscurePassword.value;

  // Setters
  void setEmail(String value) {
    _email.value = value.trim();
  }

  void setPassword(String value) {
    _password.value = value;
  }

  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  Future<bool> signIn() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please enter both email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoading.value = true;
    try {
      await _authRepo.signIn(email: email, password: password);

      // Ensure email is verified before proceeding
      if (!_authRepo.isEmailVerified) {
        Get.snackbar(
          'Email Not Verified',
          'Please verify your email before logging in.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await _authRepo.signOut();
        return false;
      }

      Get.offAllNamed(AppRoutes.home);
      Get.snackbar(
        'Welcome back',
        'You have successfully signed in.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}



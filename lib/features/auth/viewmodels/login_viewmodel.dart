import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../core/routes/app_routes.dart';

/// View model for the Login Screen.
/// 
/// Handles:
/// - Email and password input management.
/// - Password visibility toggle.
/// - Sign-in logic via repository.
/// - Navigation upon successful login.
class LoginViewModel extends GetxController {
  LoginViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? Get.find<AuthRepository>();

  final AuthRepository _authRepository;

  // Reactive form fields
  /// Current value of the email field.
  final RxString _email = ''.obs;
  
  /// Current value of the password field.
  final RxString _password = ''.obs;

  // UI state
  /// Loading state during async login.
  final RxBool _isLoading = false.obs;
  
  /// Visibility state of the password field.
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

  /// Toggles the obscured state of the password field.
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  /// Perform login with current email & password values.
  /// Returns true on success, false otherwise.
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
      await _authRepository.signIn(email: email, password: password);

      // Ensure email is verified before proceeding
      if (!_authRepository.isEmailVerified) {
        Get.snackbar(
          'Email Not Verified',
          'Please verify your email before logging in.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await _authRepository.signOut();
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


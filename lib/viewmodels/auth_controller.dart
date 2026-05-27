import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../core/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final Rx<User?> _user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isEmailVerified = false.obs;

  User? get user => _user.value;
  bool get isLoggedIn => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
    ever(_user, _handleAuthStateChanged);
  }

  void _handleAuthStateChanged(User? user) {
    if (user != null) {
      isEmailVerified.value = user.emailVerified;
    } else {
      isEmailVerified.value = false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _authService.signIn(email: email, password: password);
      
      if (_authService.currentUser?.emailVerified == false) {
        Get.snackbar(
          'Email Not Verified',
          'Please verify your email before logging in.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await _authService.signOut();
        return;
      }

      Get.offAllNamed('/home');
      Get.snackbar(
        'Success',
        'Welcome back!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      await _authService.signUp(
        email: email,
        password: password,
        name: name,
      );

      // Send verification email
      await _authService.sendEmailVerification();

      Get.offAllNamed('/email-verification');
      Get.snackbar(
        'Account Created',
        'Please check your email to verify your account.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      Get.offAllNamed('/login');
      Get.snackbar(
        'Signed Out',
        'You have been signed out successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      isLoading.value = true;
      await _authService.resetPassword(email: email);
      Get.back();
      Get.snackbar(
        'Email Sent',
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      await _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Password changed successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _authService.sendEmailVerification();
      Get.snackbar(
        'Email Sent',
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

  /// Check email verification status
  Future<void> checkEmailVerification() async {
    try {
      await _authService.reloadUser();
      if (_authService.isEmailVerified) {
        isEmailVerified.value = true;
        Get.offAllNamed('/home');
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
    }
  }
}

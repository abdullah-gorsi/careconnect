import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../core/routes/app_routes.dart';

/// View model for the Sign-Up Screen.
/// 
/// Manages:
/// - User registration form fields.
/// - Validation logic (empty fields, terms acceptance).
/// - Account creation and navigation to verification.
class SignupViewModel extends GetxController {
  SignupViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? Get.find<AuthRepository>();

  final AuthRepository _authRepository;

  // Form fields
  final RxString _name = ''.obs;
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;
  final RxString _role = 'Patient'.obs;
  final RxString _phone = ''.obs; 
  final RxBool _receiveUpdates = true.obs;
  final RxBool _acceptedTerms = false.obs;

  // UI state
  /// Loading state during registration.
  final RxBool _isLoading = false.obs;

  // Getters
  String get name => _name.value;
  String get email => _email.value;
  String get password => _password.value;
  String get role => _role.value;
  String get phone => _phone.value;
  bool get receiveUpdates => _receiveUpdates.value;
  bool get acceptedTerms => _acceptedTerms.value;
  bool get isLoading => _isLoading.value;

  // Setters
  void setName(String value) => _name.value = value.trim();
  void setEmail(String value) => _email.value = value.trim();
  void setPassword(String value) => _password.value = value;
  void setRole(String value) => _role.value = value;
  void setPhone(String value) => _phone.value = value.trim();
  void setReceiveUpdates(bool value) => _receiveUpdates.value = value;
  void setAcceptedTerms(bool value) => _acceptedTerms.value = value;

  /// Perform signup and navigate to email verification on success.
  Future<bool> signUp() async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please fill in name, email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (!acceptedTerms) {
      Get.snackbar(
        'Terms Required',
        'Please accept the Privacy Policy and Terms & Conditions to continue.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoading.value = true;
    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
      );

      // Send verification email
      await _authRepository.sendEmailVerification();

      Get.offAllNamed(AppRoutes.emailVerification);
      Get.snackbar(
        'Account created',
        'Please check your email to verify your account.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}


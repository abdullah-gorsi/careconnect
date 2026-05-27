import 'package:get/get.dart';

import '../viewmodels/auth_controller.dart';
import '../viewmodels/login_viewmodel.dart';
import '../viewmodels/signup_viewmodel.dart';
import '../viewmodels/forgot_password_viewmodel.dart';
import '../viewmodels/change_password_viewmodel.dart';
import '../viewmodels/email_verification_viewmodel.dart';
import '../viewmodels/otp_viewmodel.dart';
import '../../../data/repositories/auth_repository.dart';

/// Binding for the main Auth flow.
/// 
/// Injects all necessary ViewModels for authentication features lazy-loaded.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
    Get.lazyPut<SignupViewModel>(() => SignupViewModel());
    Get.lazyPut<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
    Get.lazyPut<ChangePasswordViewModel>(() => ChangePasswordViewModel());
    Get.lazyPut<EmailVerificationViewModel>(() => EmailVerificationViewModel());
    Get.lazyPut<OtpViewModel>(() => OtpViewModel());
  }
}


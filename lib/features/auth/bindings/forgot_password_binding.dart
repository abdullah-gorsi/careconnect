import 'package:get/get.dart';

import '../viewmodels/forgot_password_viewmodel.dart';

/// Binding for the Forgot Password screen.
/// 
/// Injects [ForgotPasswordViewModel].
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  }
}


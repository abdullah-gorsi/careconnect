import 'package:get/get.dart';

import '../viewmodels/email_verification_viewmodel.dart';

/// Binding for the Email Verification screen.
/// 
/// Injects [EmailVerificationViewModel].
class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationViewModel>(() => EmailVerificationViewModel());
  }
}


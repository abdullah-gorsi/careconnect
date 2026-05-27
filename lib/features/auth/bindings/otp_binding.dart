import 'package:get/get.dart';

import '../viewmodels/otp_viewmodel.dart';

/// Binding for the OTP Verification screen.
/// 
/// Injects [OtpViewModel].
class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpViewModel>(() => OtpViewModel());
  }
}


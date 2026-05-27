import 'package:get/get.dart';

import '../viewmodels/signup_viewmodel.dart';

/// Binding for the Sign Up screen.
/// 
/// Injects [SignupViewModel].
class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupViewModel>(() => SignupViewModel());
  }
}


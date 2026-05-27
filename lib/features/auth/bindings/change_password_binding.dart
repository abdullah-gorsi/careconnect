import 'package:get/get.dart';

import '../viewmodels/change_password_viewmodel.dart';

/// Binding for the Change Password screen.
/// 
/// Injects [ChangePasswordViewModel].
class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordViewModel>(() => ChangePasswordViewModel());
  }
}


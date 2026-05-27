import 'package:get/get.dart';

import '../viewmodels/login_viewmodel.dart';

/// Binding for the Login screen.
/// 
/// Injects [LoginViewModel].
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}


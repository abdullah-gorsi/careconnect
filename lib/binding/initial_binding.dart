import 'package:get/get.dart';

import '../core/services/auth_service.dart';
import '../core/services/appointments_service.dart';
import '../data/repositories/auth_repository.dart';
import '../features/auth/viewmodels/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.lazyPut<AppointmentsService>(() => AppointmentsService());
    
    // Repositories
    Get.put<AuthRepository>(AuthRepository(), permanent: true);

    // ViewModels (Global/Shared)
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

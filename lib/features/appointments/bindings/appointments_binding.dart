import 'package:get/get.dart';

import '../viewmodels/appointments_viewmodel.dart';
import '../../../core/services/appointments_service.dart';

class AppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsViewModel>(
      () => AppointmentsViewModel(
        service: Get.find<AppointmentsService>(),
        authService: Get.find(),
      ),
    );
  }
}


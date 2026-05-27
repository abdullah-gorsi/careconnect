import 'package:get/get.dart';
import '../../profile/bindings/profile_binding.dart';
import '../../appointments/bindings/appointments_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register dependencies for the bottom navigation tabs
    ProfileBinding().dependencies();
    AppointmentsBinding().dependencies();
  }
}

import 'package:get/get.dart';

import '../core/services/appointments_service.dart';
import '../models/appointment.dart';

class AppointmentsViewModel extends GetxController {
  final AppointmentsService service;

  AppointmentsViewModel({required this.service});

  final RxList<AppointmentItem> _appointments = <AppointmentItem>[].obs;
  final RxBool _isLoading = false.obs;

  List<AppointmentItem> get appointments => _appointments;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    _isLoading.value = true;
    try {
      final data = service.fetchAppointments();
      _appointments.value = data as List<AppointmentItem>;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load appointments: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await loadAppointments();
  }
}

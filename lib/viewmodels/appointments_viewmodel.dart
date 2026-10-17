import 'dart:async';

import 'package:get/get.dart';

import '../core/services/appointments_service.dart';
import '../core/services/auth_service.dart';
import '../features/appointments/models/appointment.dart';

class AppointmentsViewModel extends GetxController {
  final AppointmentsService service;
  final AuthService authService;

  AppointmentsViewModel({required this.service, required this.authService});

  final RxList<AppointmentItem> _appointments = <AppointmentItem>[].obs;
  final RxBool _isLoading = false.obs;
  StreamSubscription<List<AppointmentItem>>? _appointmentsSubscription;

  List<AppointmentItem> get appointments => _appointments;
  bool get isLoading => _isLoading.value;

  String get _userId => authService.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    if (_userId.isEmpty) {
      Get.snackbar(
        'Error',
        'No user logged in',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isLoading.value = true;
    await _appointmentsSubscription?.cancel();
    _appointmentsSubscription = service
        .fetchAppointments(_userId)
        .listen(
          (data) {
            _appointments.value = data;
            _isLoading.value = false;
          },
          onError: (error) {
            _isLoading.value = false;
            Get.snackbar(
              'Error',
              'Failed to load appointments: $error',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        );
  }

  @override
  void onClose() {
    _appointmentsSubscription?.cancel();
    super.onClose();
  }
}

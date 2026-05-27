import 'dart:async';

import 'package:get/get.dart';

import '../../../core/services/appointments_service.dart';
import '../../../core/services/auth_service.dart';
import '../models/appointment.dart';

/// ViewModel for managing the state and logic of the Appointments feature.
/// 
/// This controller handles:
/// - Fetching and listening to real-time appointment data from Firestore.
/// - Creating, updating, deleting, and toggling appointment status.
/// - Filtering appointments based on search text.
class AppointmentsViewModel extends GetxController {
  final AppointmentsService service;
  final AuthService authService;

  AppointmentsViewModel({
    required this.service,
    required this.authService,
  });

  /// List of all appointments fetched from the service.
  final RxList<AppointmentItem> _appointments = <AppointmentItem>[].obs;

  /// Loading state observable.
  final RxBool _isLoading = false.obs;

  /// Observable for holding the current search query.
  final RxString searchText = ''.obs;

  /// Subscription to the appointment stream to handle real-time updates.
  StreamSubscription<List<AppointmentItem>>? _appointmentsSubscription;

  /// Returns the list of all appointments.
  List<AppointmentItem> get appointments => _appointments;
  
  /// Returns a filtered list of appointments based on [searchText].
  ///
  /// Filters by title, location, or mode (case-insensitive).
  List<AppointmentItem> get filteredAppointments {
    if (searchText.value.isEmpty) {
      return _appointments;
    }
    return _appointments.where((appointment) {
      final query = searchText.value.toLowerCase();
      return appointment.title.toLowerCase().contains(query) ||
             appointment.location.toLowerCase().contains(query) ||
             appointment.mode.toLowerCase().contains(query);
    }).toList();
  }

  /// Returns the current loading status.
  bool get isLoading => _isLoading.value;

  /// Helper to get the current user ID from AuthService.
  String get _userId => authService.currentUser?.uid ?? '';

  @override
  void onReady() {
    super.onReady();
    loadAppointments();
  }

  @override
  void onClose() {
    // Cancel the subscription to prevent memory leaks.
    _appointmentsSubscription?.cancel();
    super.onClose();
  }

  /// Load appointments with real-time updates
  void loadAppointments() {
    if (_userId.isEmpty) {
      Get.snackbar(
        'Error',
        'No user logged in',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isLoading.value = true;
    
    _appointmentsSubscription?.cancel();
    _appointmentsSubscription = service.fetchAppointments(_userId).listen(
      (appointments) {
        _appointments.value = appointments;
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

  /// CREATE: Add new appointment
  Future<void> createAppointment({
    required String title,
    required String date,
    required String location,
    required String mode,
  }) async {
    if (_userId.isEmpty) {
      Get.snackbar('Error', 'No user logged in', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final appointment = AppointmentItem(
        userId: _userId,
        title: title,
        date: date,
        location: location,
        mode: mode,
      );

      await service.createAppointment(appointment);
      
      Get.snackbar(
        'Success',
        'Appointment created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create appointment: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// UPDATE: Update appointment details
  Future<void> updateAppointment(
    String appointmentId,
    Map<String, dynamic> updates,
  ) async {
    if (_userId.isEmpty) return;

    try {
      await service.updateAppointment(_userId, appointmentId, updates);
      
      Get.snackbar(
        'Success',
        'Appointment updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update appointment: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// DELETE: Remove appointment
  Future<void> deleteAppointment(String appointmentId) async {
    if (_userId.isEmpty) return;

    try {
      await service.deleteAppointment(_userId, appointmentId);
      
      Get.snackbar(
        'Success',
        'Appointment deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete appointment: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// TOGGLE: Mark appointment as completed/incomplete
  Future<void> toggleCompleted(String appointmentId, bool currentStatus) async {
    if (_userId.isEmpty) return;

    try {
      await service.toggleCompleted(_userId, appointmentId, currentStatus);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update appointment status: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Future<void> refresh() async {
    // Reloads the appointments (can be used for pull-to-refresh)
    loadAppointments();
  }
}

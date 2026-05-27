import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/appointments/models/appointment.dart';

/// AppointmentsService with Firestore CRUD operations
class AppointmentsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getAppointmentsCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('appointments');
  }

  /// CREATE: Add new appointment to Firestore
  Future<String> createAppointment(AppointmentItem appointment) async {
    try {
      final docRef = await _getAppointmentsCollection(appointment.userId).add(appointment.toJson());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  /// READ: Stream appointments for a user (real-time updates)
  Stream<List<AppointmentItem>> fetchAppointments(String userId) {
    return _getAppointmentsCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppointmentItem.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  /// UPDATE: Update specific fields of an appointment
  Future<void> updateAppointment(
    String userId,
    String appointmentId,
    Map<String, dynamic> updates,
  ) async {
    try {
      // Always update the updatedAt timestamp
      updates['updatedAt'] = FieldValue.serverTimestamp();
      
      await _getAppointmentsCollection(userId)
          .doc(appointmentId)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  /// DELETE: Remove appointment from Firestore
  Future<void> deleteAppointment(String userId, String appointmentId) async {
    try {
      await _getAppointmentsCollection(userId).doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  /// TOGGLE COMPLETED: Mark appointment as completed/incomplete
  Future<void> toggleCompleted(
    String userId,
    String appointmentId,
    bool currentStatus,
  ) async {
    try {
      await updateAppointment(userId, appointmentId, {
        'completed': !currentStatus,
      });
    } catch (e) {
      throw Exception('Failed to toggle appointment status: $e');
    }
  }
}

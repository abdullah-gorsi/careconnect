import 'package:cloud_firestore/cloud_firestore.dart';

/// Appointment model with Firestore support
class AppointmentItem {
  const AppointmentItem({
    this.id,
    required this.userId,
    required this.title,
    required this.date,
    required this.location,
    required this.mode,
    this.completed = false,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String userId;
  final String title;
  final String date;
  final String location;
  final String mode;
  final bool completed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Convert model to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'date': date,
      'location': location,
      'mode': mode,
      'completed': completed,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  /// Create model from Firestore document
  factory AppointmentItem.fromJson(Map<String, dynamic> json, String id) {
    return AppointmentItem(
      id: id,
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      location: json['location'] as String? ?? '',
      mode: json['mode'] as String? ?? '',
      completed: json['completed'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Create a copy with updated fields
  AppointmentItem copyWith({
    String? id,
    String? userId,
    String? title,
    String? date,
    String? location,
    String? mode,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      date: date ?? this.date,
      location: location ?? this.location,
      mode: mode ?? this.mode,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

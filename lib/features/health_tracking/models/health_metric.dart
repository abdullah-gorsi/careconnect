import 'package:cloud_firestore/cloud_firestore.dart';

enum HealthMetricType { steps, heartRate, sleep, bloodPressure, calories }

class HealthMetric {
  final String id;
  final HealthMetricType type;
  final double value;
  final String unit;
  final DateTime date;
  final String source; // e.g., 'Health Connect', 'Manual'

  HealthMetric({
    required this.id,
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
    this.source = 'Health Connect',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'value': value,
      'unit': unit,
      'date': Timestamp.fromDate(date),
      'source': source,
    };
  }

  factory HealthMetric.fromJson(Map<String, dynamic> json) {
    return HealthMetric(
      id: json['id'] ?? '',
      type: HealthMetricType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => HealthMetricType.steps,
      ),
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      source: json['source'] ?? 'Health Connect',
    );
  }
}

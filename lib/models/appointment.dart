/// Appointment model used across the app.
class AppointmentItem {
  const AppointmentItem({
    required this.title,
    required this.date,
    required this.location,
    required this.mode,
    this.completed = false,
  });

  final String title;
  final String date;
  final String location;
  final String mode;
  final bool completed;
}
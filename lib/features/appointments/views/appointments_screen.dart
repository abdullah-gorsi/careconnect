import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/glass_card.dart';
import '../viewmodels/appointments_viewmodel.dart';

/// Screen for displaying and managing appointments.
///
/// This screen includes:
/// - A list of appointments with search and filter capabilities.
/// - Options to create, edit, delete, and complete appointments.
class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  static const routeName = '/appointments';

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {




/// Show create appointment dialog
  /// Displays a dialog to create a new appointment.
  ///
  /// Includes fields for title, date, location, and mode (In-person/Virtual).
  void _showCreateAppointmentDialog() {
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final locationController = TextEditingController();
    String selectedMode = 'In-person';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Appointment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date (e.g., Mon, Mar 18 • 9:00 AM)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedMode,
                  decoration: const InputDecoration(labelText: 'Mode'),
                  items: ['In-person', 'Virtual'].map((mode) {
                    return DropdownMenuItem(value: mode, child: Text(mode));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    dateController.text.trim().isEmpty ||
                    locationController.text.trim().isEmpty) {
                  Get.snackbar(
                    'Validation Error',
                    'Please fill all fields',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
                
                Get.find<AppointmentsViewModel>().createAppointment(
                  title: titleController.text.trim(),
                  date: dateController.text.trim(),
                  location: locationController.text.trim(),
                  mode: selectedMode,
                );
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a dialog to edit an existing appointment.
  ///
  /// Pre-fills the fields with the [appointment]'s current data.
  void _showEditAppointmentDialog(appointment) {
    final titleController = TextEditingController(text: appointment.title);
    final dateController = TextEditingController(text: appointment.date);
    final locationController = TextEditingController(text: appointment.location);
    String selectedMode = appointment.mode;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Appointment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedMode,
                  decoration: const InputDecoration(labelText: 'Mode'),
                  items: ['In-person', 'Virtual'].map((mode) {
                    return DropdownMenuItem(value: mode, child: Text(mode));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    dateController.text.trim().isEmpty ||
                    locationController.text.trim().isEmpty) {
                  Get.snackbar(
                    'Validation Error',
                    'Please fill all fields',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
                
                Get.find<AppointmentsViewModel>().updateAppointment(
                  appointment.id!,
                  {
                    'title': titleController.text.trim(),
                    'date': dateController.text.trim(),
                    'location': locationController.text.trim(),
                    'mode': selectedMode,
                  },
                );
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the AppointmentsViewModel via GetX
    final vm = Get.find<AppointmentsViewModel>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateAppointmentDialog,
        child: const Icon(Icons.add),
      ),
      // Use Obx to rebuild the UI when observable variables in the ViewModel change.
      body: Obx(() {
        final items = vm.filteredAppointments;
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Search Bar
            TextField(
              onChanged: (value) => vm.searchText.value = value,
              decoration: InputDecoration(
                hintText: 'Search appointments, providers...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 24),
            // Loading Indicator
            if (vm.isLoading) const Center(child: CircularProgressIndicator()),
            
            // List of Appointments
            if (!vm.isLoading)
              ...items.map(
                // Dismissible widget handles swipe-to-delete functionality
                (appointment) => Dismissible(
                  key: Key(appointment.id ?? ''),
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Appointment'),
                        content: const Text('Are you sure you want to delete this appointment?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) {
                    vm.deleteAppointment(appointment.id!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Toggle completion status
                                  vm.toggleCompleted(appointment.id!, appointment.completed);
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: appointment.completed
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: appointment.completed
                                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                                      : null,
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        appointment.title,
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          decoration: appointment.completed
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Chip(label: Text(appointment.mode)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 18),
                                    const SizedBox(width: 8),
                                    Text(appointment.date),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.place_outlined, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(appointment.location)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () => _showEditAppointmentDialog(appointment),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        foregroundColor: Theme.of(context).colorScheme.primary,
                                      ),
                                      child: const Text('Edit'),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Delete Appointment'),
                                            content: const Text('Are you sure you want to delete this appointment?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  vm.deleteAppointment(appointment.id!);
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}


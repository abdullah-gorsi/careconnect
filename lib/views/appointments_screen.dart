import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/glass_card.dart';
import '../viewmodels/appointments_viewmodel.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  static const routeName = '/appointments';

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _filters = ['All', 'In-person', 'Virtual', 'Completed'];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    // Load appointments when screen initializes
    final vm = Get.find<AppointmentsViewModel>();
    vm.loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<AppointmentsViewModel>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Obx(() {
        final items = vm.appointments;
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search appointments, providers...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: _filters
                  .map(
                    (filter) => ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (_) {
                        setState(() => _selectedFilter = filter);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            if (vm.isLoading) const Center(child: CircularProgressIndicator()),
            if (!vm.isLoading)
              ...items.map(
                (appointment) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 80,
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: .2),
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
                                    child: Text(appointment.title, style: Theme.of(context).textTheme.headlineSmall),
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
                                  Text(appointment.location),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      foregroundColor: Theme.of(context).colorScheme.primary,
                                    ),
                                    child: const Text('Details'),
                                  ),
                                  const SizedBox(width: 12),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.navigation_outlined),
                                    label: const Text('Directions'),
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
          ],
        );
      }),
    );
  }
}

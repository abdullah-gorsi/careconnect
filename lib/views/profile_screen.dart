import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contactDetails = [
      const _ProfileDetail(label: 'Email', value: 'abdullahgorsi149@gmail.com', icon: Icons.mail_outline),
      const _ProfileDetail(label: 'Phone', value: '+92 317 6268452', icon: Icons.phone_outlined),
      const _ProfileDetail(label: 'Primary provider', value: 'Dr. Abdullah', icon: Icons.medical_services_outlined),
      const _ProfileDetail(label: 'Care partner since', value: 'January 2022', icon: Icons.calendar_today_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          GlassCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: .1),
                  child: Icon(Icons.person, size: 36, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Abdullah Iftikhar', style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 4),
                      Text('Care Partner · Family', style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: const [
                          Chip(label: Text('Medication lead')),
                          Chip(label: Text('Emergency contact')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Care overview', actionLabel: 'View plan', onActionTap: () {}),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  label: 'Care tasks',
                  value: '12 active',
                  detail: '3 due today',
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  label: 'Support hours',
                  value: '18 hrs',
                  detail: 'This week',
                  icon: Icons.timer_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Contact info'),
          const SizedBox(height: 12),
          ...contactDetails.map(
            (detail) => Card(
              child: ListTile(
                leading: Icon(detail.icon),
                title: Text(detail.label),
                subtitle: Text(detail.value),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(title: 'Care circle'),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.secondary.withValues(alpha: .15),
                child: Icon(Icons.group_outlined, color: theme.colorScheme.secondary),
              ),
              title: const Text('Invite a caregiver'),
              subtitle: const Text('Share access and coordinate together'),
              trailing: const Icon(Icons.add),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.detail, required this.icon});

  final String label;
  final String value;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 2),
          Text(detail, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _ProfileDetail {
  const _ProfileDetail({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;
}

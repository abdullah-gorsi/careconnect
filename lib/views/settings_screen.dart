import 'package:flutter/material.dart';

import '../widgets/section_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _weeklySummary = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SectionHeader(title: 'Notifications'),
          const SizedBox(height: 12),
          _SettingCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: _notifications,
                  title: const Text('Care reminders'),
                  subtitle: const Text('Medication, appointments, and tasks'),
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                const Divider(),
                SwitchListTile(
                  value: _weeklySummary,
                  title: const Text('Weekly summary'),
                  subtitle: const Text('Progress email every Monday'),
                  onChanged: (value) => setState(() => _weeklySummary = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Display & accessibility'),
          const SizedBox(height: 12),
          _SettingCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: _darkMode,
                  title: const Text('Dark mode'),
                  subtitle: const Text('Coming soon'),
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.text_fields_outlined),
                  title: const Text('Text size'),
                  subtitle: const Text('Standard'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Privacy & support'),
          const SizedBox(height: 12),
          _SettingCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Privacy'),
                  subtitle: const Text('Manage permissions & shared data'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & support'),
                  subtitle: const Text('FAQ, chat, and contact info'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About CareConnect'),
                  subtitle: const Text('Version 1.0.0'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          TextButton.icon(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sign out'),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  const _SettingCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: child,
    );
  }
}

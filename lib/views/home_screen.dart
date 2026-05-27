import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodels/auth_controller.dart';

import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import 'appointments_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'health_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const _HomeContent(),

    HealthTrackingScreen(),

    ProfileScreen(),

    AppointmentsScreen(),

    MessagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            tooltip: 'Sign out',
            icon: Icon(Icons.logout, color: theme.colorScheme.error),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Health'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.event_available_outlined), label: 'Appointment'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quickActions = [
      _ActionCardData(
        title: 'Appointments',
        icon: Icons.event_available,
        color: theme.colorScheme.primary,
        route: AppointmentsScreen.routeName,
      ),
      _ActionCardData(
        title: 'Messages',
        icon: Icons.chat_bubble_outline,
        color: theme.colorScheme.secondary,
        route: MessagesScreen.routeName,
      ),
      _ActionCardData(
        title: 'Profile',
        icon: Icons.person_outline,
        color: Colors.orangeAccent,
        route: ProfileScreen.routeName,
      ),
      _ActionCardData(
        title: 'Settings',
        icon: Icons.settings_outlined,
        color: Colors.purpleAccent,
        route: SettingsScreen.routeName,
      ),
    ];

    final reminders = [
      const _ReminderItem(
        title: 'Afternoon medication',
        time: 'Today • 2:00 PM',
        instructions: 'Take with light snack',
      ),
      const _ReminderItem(
        title: 'Physical therapy stretches',
        time: 'Today • 5:30 PM',
        instructions: '3 sets of ankle rotations',
      ),
    ];

    final updates = [
      const _UpdateItem(
        source: 'Dr. Abdullah',
        message: 'Labs look good. Keep hydration up this week.',
        time: '2h ago',
      ),
      const _UpdateItem(source: 'Care team', message: 'New note added to your care plan.', time: 'Yesterday'),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi Abdullah', style: theme.textTheme.headlineSmall),
                Text('Here’s your care snapshot', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.favorite, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Health Index', style: theme.textTheme.bodyMedium),
                          Text('8.6 / 10', style: theme.textTheme.headlineLarge),
                        ],
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('View trends')),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      child: _StatTile(label: 'Sleep', value: '7h 45m', trend: '+35m vs avg'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatTile(label: 'Activity', value: '82%', trend: 'Goal on track'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(title: 'Quick actions', actionLabel: 'See all', onActionTap: () {}),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: quickActions
                .map(
                  (action) => _QuickActionCard(data: action, onTap: () => Navigator.pushNamed(context, action.route)),
                )
                .toList(),
          ),
          const SizedBox(height: 32),
          SectionHeader(title: 'Care reminders', actionLabel: 'Mark all done', onActionTap: () {}),
          const SizedBox(height: 12),
          ...reminders.map(
            (reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ReminderCard(reminder: reminder),
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(
            title: 'Updates from your team',
            actionLabel: 'Messages',
            onActionTap: () => Navigator.pushNamed(context, MessagesScreen.routeName),
          ),
          const SizedBox(height: 12),
          ...updates.map(
            (update) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(update.source.substring(0, 1))),
                title: Text(update.source),
                subtitle: Text(update.message),
                trailing: Text(update.time),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ActionCardData {
  const _ActionCardData({required this.title, required this.icon, required this.color, required this.route});
  final String title;
  final IconData icon;
  final Color color;
  final String route;
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.data, required this.onTap});
  final _ActionCardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 36,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: data.color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Icon(data.icon, color: data.color),
            ),
            const SizedBox(height: 16),
            Text(data.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            const Text('Tap to open'),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.trend});
  final String label;
  final String value;
  final String trend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(trend, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
        ],
      ),
    );
  }
}

class _ReminderItem {
  const _ReminderItem({required this.title, required this.time, required this.instructions});
  final String title;
  final String time;
  final String instructions;
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder});
  final _ReminderItem reminder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: const Icon(Icons.favorite),
        ),
        title: Text(reminder.title),
        subtitle: Text('${reminder.time} • ${reminder.instructions}'),
        trailing: IconButton(icon: const Icon(Icons.check_circle_outline), onPressed: () {}),
      ),
    );
  }
}

class _UpdateItem {
  const _UpdateItem({required this.source, required this.message, required this.time});
  final String source;
  final String message;
  final String time;
}

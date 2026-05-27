import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  static const routeName = '/messages';

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {


  @override
  Widget build(BuildContext context) {
    final threads = [
      const _Thread(
        name: 'Dr. Abdullah',
        preview: 'Vitals look great, keep up the routine!',
        time: '2m ago',
        role: 'Primary care',
        unread: true,
      ),
      const _Thread(
        name: 'Care Team',
        preview: 'Reminder: share your weekly check-in form.',
        time: '1h ago',
        role: 'Care coordinator',
        unread: false,
      ),
      const _Thread(
        name: 'Physical Therapy',
        preview: 'Can you confirm availability for next week?',
        time: 'Yesterday',
        role: 'Specialist',
        unread: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add_comment_outlined))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Search people, topics...', prefixIcon: const Icon(Icons.search)),
          ),

          const SizedBox(height: 24),
          ...threads.map(
            (thread) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _MessageCard(thread: thread),
            ),
          ),
        ],
      ),
    );
  }
}

class _Thread {
  const _Thread({
    required this.name,
    required this.preview,
    required this.time,
    required this.role,
    required this.unread,
  });

  final String name;
  final String preview;
  final String time;
  final String role;
  final bool unread;
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.thread});

  final _Thread thread;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: .15),
                child: Text(thread.name.substring(0, 1), style: theme.textTheme.headlineSmall),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(thread.name, style: theme.textTheme.headlineSmall)),
                        Text(thread.time, style: theme.textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(thread.role, style: theme.textTheme.bodySmall),
                    const SizedBox(height: 6),
                    Text(thread.preview, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (thread.unread)
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(14)),
                  child: const Text('New', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


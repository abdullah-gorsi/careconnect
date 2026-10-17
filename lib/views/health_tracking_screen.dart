import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class HealthTrackingScreen extends StatelessWidget {
  const HealthTrackingScreen({super.key});

  static const routeName = '/health-tracking';

  List<double> _sampleSteps() => [4200, 5600, 8000, 7500, 9200, 10200, 8800];
  List<double> _sampleSleep() => [7.2, 6.8, 8.0, 7.5, 7.7, 8.2, 7.6];
  List<double> _sampleCalories() => [2100, 1950, 2300, 2200, 2050, 2100, 2000];
  List<double> _sampleHydration() => [1.8, 2.0, 2.2, 1.6, 2.0, 2.1, 1.9];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final steps = _sampleSteps();
    final sleep = _sampleSleep();
    final calories = _sampleCalories();
    final hydration = _sampleHydration();

    return Scaffold(
      appBar: AppBar(title: const Text('Health Tracking')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const SectionHeader(title: 'Today'),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: 'Steps',
                    value: '${steps.last.toInt()}',
                    unit: 'steps',
                    icon: Icons.directions_walk,
                    color: theme.colorScheme.primary,
                    progress: (steps.last / 10000).clamp(0.0, 1.0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'Sleep',
                    value: '${sleep.last}h',
                    unit: 'hrs',
                    icon: Icons.bedtime_outlined,
                    color: theme.colorScheme.secondary,
                    progress: (sleep.last / 8.0).clamp(0.0, 1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: 'Calories',
                    value: '${calories.last.toInt()}',
                    unit: 'kcal',
                    icon: Icons.local_fire_department_outlined,
                    color: Colors.orangeAccent,
                    progress: (calories.last / 2500).clamp(0.0, 1.0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'Hydration',
                    value: '${hydration.last}L',
                    unit: 'L',
                    icon: Icons.local_drink_outlined,
                    color: Colors.lightBlue,
                    progress: (hydration.last / 2.5).clamp(0.0, 1.0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const SectionHeader(title: 'Vitals'),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood pressure',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '118/76 mmHg',
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Last measured: today • 07:20',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Heart rate', style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Text('72 bpm', style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 6),
                          Text('Resting', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Glucose', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text('95 mg/dL', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 6),
                    Text(
                      'Fasting • Today 06:50',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const SectionHeader(title: 'Progress & Analytics'),
            const SizedBox(height: 12),

            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps (last 7 days)',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: Sparkline(
                        data: steps,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Sleep (hrs)', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: Sparkline(
                        data: sleep,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Calories', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: Sparkline(
                        data: calories,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Hydration (L)', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: Sparkline(
                        data: hydration,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weekly summary', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _AnalyticsTile(
                            label: 'Avg steps',
                            value:
                                '${(steps.reduce((a, b) => a + b) / steps.length).toInt()}',
                            delta: '+8%',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _AnalyticsTile(
                            label: 'Avg sleep',
                            value:
                                '${(sleep.reduce((a, b) => a + b) / sleep.length).toStringAsFixed(1)}h',
                            delta: '+3%',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _AnalyticsTile(
                            label: 'Avg hydration',
                            value:
                                '${(hydration.reduce((a, b) => a + b) / hydration.length).toStringAsFixed(1)}L',
                            delta: '-1%',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.progress,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(.18),
              minHeight: 6,
            ),
            const SizedBox(height: 6),
            Text(
              '${(progress * 100).toInt()}% of goal',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsTile extends StatelessWidget {
  const _AnalyticsTile({
    required this.label,
    required this.value,
    required this.delta,
  });
  final String label;
  final String value;
  final String delta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            delta,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.data, required this.color});
  final List<double> data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return CustomPaint(
          size: size,
          painter: _SparklinePainter(data: data, color: color),
        );
      },
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.data, required this.color});
  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    final fill = Paint()
      ..color = color.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final min = data.reduce((a, b) => a < b ? a : b);
    final max = data.reduce((a, b) => a > b ? a : b);
    final range = (max - min) == 0 ? 1.0 : (max - min);

    final dx = size.width / (data.length - 1);
    final points = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      final x = i * dx;
      final normalized = (data[i] - min) / range;
      final y = size.height - (normalized * size.height);
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();
    canvas.drawPath(fillPath, fill);
    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = color;
    canvas.drawCircle(points.last, 3.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.color != color;
}

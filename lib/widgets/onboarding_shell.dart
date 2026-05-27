import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'gradient_background.dart';

class OnboardingShell extends StatelessWidget {
  const OnboardingShell({
    super.key,
    required this.illustration,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.onSkip,
    required this.step,
    required this.totalSteps,
  });

  final IconData illustration;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSkip;
  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = step / totalSteps;

    final screenSize = MediaQuery.of(context).size;

    final illustrationHeight = (screenSize.height * 0.22).clamp(110.0, 180.0);

    final iconSize = (illustrationHeight * 0.42).clamp(48.0, 88.0);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Step $step of $totalSteps',
                        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                    const Spacer(),
                    TextButton(onPressed: onSkip, child: const Text('Skip')),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: illustrationHeight,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: AppColors.heroGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: .25),
                          blurRadius: 20,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(illustration, size: iconSize, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.headlineLarge),
                      const SizedBox(height: 12),
                      Text(description, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: .12),
                        ),
                      ),
                      const SizedBox(height: 24),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onPrimaryPressed, child: Text(primaryLabel)),
        ),
      ),
    );
  }
}

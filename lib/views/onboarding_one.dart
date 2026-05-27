import 'package:flutter/material.dart';

import '../widgets/onboarding_shell.dart';
import 'login_screen.dart';
import 'onboarding_two.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  static const routeName = '/onboarding-1';

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      illustration: Icons.monitor_heart,
      title: 'Stay informed',
      description:
          'Track appointments, care plans, and updates from your care team in one place.',
      primaryLabel: 'Next',
      step: 1,
      totalSteps: 4,
      onPrimaryPressed: () {
        Navigator.pushReplacementNamed(context, OnboardingTwo.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }
}

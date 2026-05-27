import 'package:flutter/material.dart';

import '../widgets/onboarding_shell.dart';
import 'login_screen.dart';
import 'onboarding_four.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  static const routeName = '/onboarding-3';

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      illustration: Icons.medication_liquid,
      title: 'Never miss a dose',
      description:
          'Set gentle reminders for medications and exercises tailored to you.',
      primaryLabel: 'Next',
      step: 3,
      totalSteps: 4,
      onPrimaryPressed: () {
        Navigator.pushReplacementNamed(context, OnboardingFour.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }
}

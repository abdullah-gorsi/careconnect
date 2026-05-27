import 'package:flutter/material.dart';

import '../widgets/onboarding_shell.dart';
import 'login_screen.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

  static const routeName = '/onboarding-4';

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      illustration: Icons.favorite_outline,
      title: 'Support that feels human',
      description:
          'Empowering patients, families, and clinicians with tools that keep care personal.',
      primaryLabel: 'Get started',
      step: 4,
      totalSteps: 4,
      onPrimaryPressed: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }
}

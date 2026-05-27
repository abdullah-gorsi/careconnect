import 'package:flutter/material.dart';

import '../widgets/onboarding_shell.dart';
import 'login_screen.dart';
import 'onboarding_three.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  static const routeName = '/onboarding-2';

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      illustration: Icons.groups_2,
      title: 'Connect with care teams',
      description:
          'Message doctors, nurses, and caregivers securely to keep everyone aligned.',
      primaryLabel: 'Next',
      step: 2,
      totalSteps: 4,
      onPrimaryPressed: () {
        Navigator.pushReplacementNamed(context, OnboardingThree.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }
}

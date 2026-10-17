import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/onboarding_shell.dart';
import '../../../core/routes/app_routes.dart';

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
        Get.offNamed(AppRoutes.onboardingFour);
      },
      onSkip: () {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}

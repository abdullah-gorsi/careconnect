import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/onboarding_shell.dart';
import '../../../core/routes/app_routes.dart';

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
        Get.offNamed(AppRoutes.onboardingThree);
      },
      onSkip: () {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}

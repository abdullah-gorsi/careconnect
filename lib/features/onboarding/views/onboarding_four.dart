import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/onboarding_shell.dart';
import '../../../core/routes/app_routes.dart';

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
        Get.offAllNamed(AppRoutes.login);
      },
      onSkip: () {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}

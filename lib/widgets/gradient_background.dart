import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.showPattern = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool showPattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.softBackground),
      child: Stack(
        children: [
          if (showPattern) ...[
            Positioned(
              top: -80,
              right: -20,
              child: _blurBall(const Color(0xFFB4C6FF)),
            ),
            Positioned(
              bottom: -60,
              left: -40,
              child: _blurBall(const Color(0xFFFFCFC5)),
            ),
          ],
          SafeArea(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }

  Widget _blurBall(Color color) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: .4),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .4),
            blurRadius: 90,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}

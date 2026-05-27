import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/auth_controller.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../../../shared/widgets/glass_card.dart';

/// Screen that prompts the user to verify their email address.
///
/// Functionality:
/// - Automatically checks verification status periodically.
/// - Allows resending the verification email after a countdown.
/// - Displays the email address the link was sent to.
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const routeName = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final AuthController _authController = Get.find<AuthController>();
  Timer? _timer;
  int _countdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startAutoCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Starts a periodic timer to check if the user has verified their email.
  void _startAutoCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _authController.checkEmailVerification();
    });
  }

  /// Starts a countdown timer for the "Resend Email" button.
  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _countdown = 60;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _countdown--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GradientBackground(
        padding: EdgeInsets.zero,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mark_email_unread_outlined, size: 120, color: theme.colorScheme.primary),
                const SizedBox(height: 32),
                Text('Verify Your Email', style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Obx(() {
                  final user = _authController.user;
                  return Text(
                    'We sent a verification link to\n${user?.email ?? "your email"}',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  );
                }),
                const SizedBox(height: 32),
                GlassCard(
                  child: Column(
                    children: [
                      const Icon(Icons.info_outline, size: 48, color: Colors.blue),
                      const SizedBox(height: 16),
                      Text('Check your inbox', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(
                        'Click the verification link in the email to activate your account. This page will automatically update once verified.',
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _canResend
                        ? () {
                            _authController.sendEmailVerification();
                            _startResendCountdown();
                          }
                        : null,
                    icon: const Icon(Icons.send),
                    label: Text(_canResend ? 'Resend Email' : 'Resend in $_countdown seconds'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(onPressed: () => _authController.signOut(), child: const Text('Sign Out')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

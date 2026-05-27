import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../../../core/routes/app_routes.dart';

/// Screen for entering the details to verify OTP.
/// 
/// Displays the destination (email/phone) and a 4-digit code input field.
/// Currently mocks the verification process.
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, this.destination});

  // Optional destination (email or phone) shown to the user
  final String? destination;

  static const routeName = '/otp-verification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  /// Validates the OTP code and navigates on success.
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Verify code')),
      body: GradientBackground(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We sent a code to ${widget.destination ?? 'your device'}. Enter it below to continue.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.mail_lock_outlined, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Code sent to', style: theme.textTheme.bodySmall),
                          Text(widget.destination ?? 'you@careconnect.app', style: theme.textTheme.headlineSmall),
                        ],
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Resend (0:42)')),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _codeController,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(letterSpacing: 16),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Enter 4-digit code', counterText: ''),
                  validator: (value) {
                    if (value == null || value.length != 4) {
                      return 'Enter the 4-digit code';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: _submit, child: const Text('Verify & continue')),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Back to sign in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


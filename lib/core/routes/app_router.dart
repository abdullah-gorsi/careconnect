import 'package:flutter/material.dart';

import '../../views/appointments_screen.dart';
import '../../views/forgot_password_screen.dart';
import '../../views/home_screen.dart';
import '../../views/login_screen.dart';
import '../../views/messages_screen.dart';
import '../../views/onboarding_four.dart';
import '../../views/onboarding_one.dart';
import '../../views/onboarding_three.dart';
import '../../views/onboarding_two.dart';
import '../../views/otp_verification_screen.dart';
import '../../views/profile_screen.dart';
import '../../views/settings_screen.dart';
import '../../views/signup_screen.dart';
import '../../views/splash_screen.dart';
import '../../views/health_tracking_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
    SplashScreen.routeName: (_) => const SplashScreen(),
    OnboardingOne.routeName: (_) => const OnboardingOne(),
    OnboardingTwo.routeName: (_) => const OnboardingTwo(),
    OnboardingThree.routeName: (_) => const OnboardingThree(),
    OnboardingFour.routeName: (_) => const OnboardingFour(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    SignupScreen.routeName: (_) => const SignupScreen(),
    ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
    OtpVerificationScreen.routeName: (_) => const OtpVerificationScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    HealthTrackingScreen.routeName: (_) => const HealthTrackingScreen(),
    AppointmentsScreen.routeName: (_) => const AppointmentsScreen(),
    MessagesScreen.routeName: (_) => const MessagesScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    SettingsScreen.routeName: (_) => const SettingsScreen(),
  };
}

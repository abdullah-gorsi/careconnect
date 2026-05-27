import 'package:get/get.dart';
import '../../features/splash/views/splash_screen.dart';
import '../../features/onboarding/views/onboarding_one.dart';
import '../../features/onboarding/views/onboarding_two.dart';
import '../../features/onboarding/views/onboarding_three.dart';
import '../../features/onboarding/views/onboarding_four.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/signup_screen.dart';
import '../../features/auth/views/forgot_password_screen.dart';
import '../../features/auth/views/otp_verification_screen.dart';
import '../../features/auth/views/email_verification_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/appointments/views/appointments_screen.dart';
import '../../features/messages/views/messages_screen.dart';
import '../../features/profile/views/profile_screen.dart';
import '../../features/settings/views/settings_screen.dart';
import '../../features/health_tracking/views/health_tracking_screen.dart';
import '../../features/auth/views/change_password_screen.dart';
import '../../features/auth/bindings/login_binding.dart';
import '../../features/auth/bindings/signup_binding.dart';
import '../../features/auth/bindings/forgot_password_binding.dart';
import '../../features/auth/bindings/change_password_binding.dart';
import '../../features/auth/bindings/email_verification_binding.dart';
import '../../features/auth/bindings/otp_binding.dart';
import '../../features/appointments/bindings/appointments_binding.dart';
import '../../features/profile/bindings/profile_binding.dart';
import '../../features/home/bindings/home_binding.dart';

/// AppRoutes
/// GetX named routes configuration.
/// Defines all app routes and their corresponding pages.
class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboardingOne = '/onboarding-1';
  static const String onboardingTwo = '/onboarding-2';
  static const String onboardingThree = '/onboarding-3';
  static const String onboardingFour = '/onboarding-4';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String emailVerification = '/email-verification';
  static const String home = '/home';
  static const String appointments = '/appointments';
  static const String messages = '/messages';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String healthTracking = '/health-tracking';
  static const String changePassword = '/change-password';

  // Route pages
  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: onboardingOne,
      page: () => const OnboardingOne(),
    ),
    GetPage(
      name: onboardingTwo,
      page: () => const OnboardingTwo(),
    ),
    GetPage(
      name: onboardingThree,
      page: () => const OnboardingThree(),
    ),
    GetPage(
      name: onboardingFour,
      page: () => const OnboardingFour(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: otpVerification,
      page: () => const OtpVerificationScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: emailVerification,
      page: () => const EmailVerificationScreen(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: appointments,
      page: () => const AppointmentsScreen(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: messages,
      page: () => const MessagesScreen(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: healthTracking,
      page: () => const HealthTrackingScreen(),
    ),
  ];
}

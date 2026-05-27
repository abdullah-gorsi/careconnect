import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/services/auth_service.dart';

/// Repository class for handling authentication operations.
/// 
/// Interacts with [AuthService] to perform actions like sign-in, sign-up, and password management.
class AuthRepo {
  AuthRepo({AuthService? authService})
      : _authService = authService ?? Get.find<AuthService>();

  final AuthService _authService;

  /// Stream of authentication state changes (User object or null).
  Stream<User?> get authStateChanges => _authService.authStateChanges;
  
  /// Returns the current authenticated user, if any.
  User? get currentUser => _authService.currentUser;
  
  /// Checks if the current user's email is verified.
  bool get isEmailVerified => _authService.isEmailVerified;

  /// Signs in a user with email and password.
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _authService.signIn(email: email, password: password);
  }

  /// Creates a new user account.
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) {
    return _authService.signUp(
      email: email,
      password: password,
      name: name,
    );
  }

  /// Signs out the current user.
  Future<void> signOut() => _authService.signOut();

  /// Sends a password reset email to the specified address.
  Future<void> resetPassword({required String email}) {
    return _authService.resetPassword(email: email);
  }

  /// Changes the user's password.
  /// 
  /// Requires both current and new passwords for verification.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  /// Sends an email verification link to the current user.
  Future<void> sendEmailVerification() {
    return _authService.sendEmailVerification();
  }

  /// Reloads the user's data from Firebase.
  Future<void> reloadUser() => _authService.reloadUser();
}



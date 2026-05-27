import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';

class AuthRepository {
  AuthRepository({AuthService? authService})
      : _authService = authService ?? Get.find<AuthService>();

  final AuthService _authService;

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  User? get currentUser => _authService.currentUser;

  bool get isEmailVerified => _authService.isEmailVerified;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _authService.signIn(email: email, password: password);
  }

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

  Future<void> signOut() => _authService.signOut();

  Future<void> resetPassword({required String email}) {
    return _authService.resetPassword(email: email);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> sendEmailVerification() {
    return _authService.sendEmailVerification();
  }

  Future<void> reloadUser() => _authService.reloadUser();
}


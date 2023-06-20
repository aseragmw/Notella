import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> signUp({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> sendVerificationEmail();
  Future<void> sendPasswordResetEmail({required String email});
}

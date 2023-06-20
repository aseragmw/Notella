import 'package:notella/services/auth/auth_provider.dart';
import 'package:notella/services/auth/auth_user.dart';
import 'package:notella/services/auth/firebase_auth_provider.dart';

class AuthService extends AuthProvider{

   AuthProvider provider;
   AuthService(this.provider);
   factory AuthService.fromFirebase()=>AuthService(FirebaseAuthProvider());

  @override

  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() =>provider.initialize();

  @override
  Future<AuthUser> login({required String email, required String password}) => provider.login(email: email, password: password);

  @override
  Future<void> logout() =>provider.logout();

  @override
  Future<void> sendPasswordResetEmail({required String email}) =>provider.sendPasswordResetEmail(email: email);

  @override
  Future<void> sendVerificationEmail() => provider.sendVerificationEmail();

  @override
  Future<AuthUser> signUp({required String email, required String password}) => provider.signUp(email: email, password: password);

}
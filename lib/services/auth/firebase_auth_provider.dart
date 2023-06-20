import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notella/services/auth/auth_provider.dart';
import 'package:notella/services/auth/auth_user.dart';

import '../../firebase_options.dart';
import 'auth_exceptions.dart';

class FirebaseAuthProvider extends AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<AuthUser> signUp(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotCreatedException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw WeakPasswordException();
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email})async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
    on FirebaseAuthException catch(e){
      switch(e.code){
        case'firebase_auth/invalid-email':
          throw InvalidEmailException();
        case'firebase_auth/user-not-found':
          throw UserNotFoundException();
        default :
          throw GenericAuthException();
      }
    }
    catch(_){
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendVerificationEmail() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      user.sendEmailVerification();
    }
    else{
      throw UserNotLoggedInException();
    }
  }



}

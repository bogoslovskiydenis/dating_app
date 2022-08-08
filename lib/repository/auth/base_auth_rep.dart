import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepo {
  Stream<auth.User?> get user;

  Future<auth.User?> sighUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

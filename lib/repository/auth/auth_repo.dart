import 'package:dating_app/repository/auth/base_auth_rep.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepo extends BaseAuthRepo {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepo({
    auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> sighUp({
    required String email,
    required String password
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      return user;
    } catch (_) {}
    return null;
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out');
    }
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> logInWithEmailAndPassword({
  required String email,
    required String password,
}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch(_){}
  }
}

import 'package:dating_app/repository/base_auth_rep.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepo extends BaseAuthRepo{
  final  auth.FirebaseAuth _firebaseAuth;

  AuthRepo({ auth.FirebaseAuth? firebaseAuth, }) : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> sighUp({required String email,required String password})  async{
   try {
     final credential = await _firebaseAuth
         .createUserWithEmailAndPassword(email: email, password: password);
     final user = credential.user;
     return user;
   } catch(_){   }
  }

  @override
  // TODO: implement user
  Stream<auth.User?> get user => _firebaseAuth.userChanges();
  
}
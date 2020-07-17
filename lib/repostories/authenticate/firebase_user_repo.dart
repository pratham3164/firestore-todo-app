import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/repostories/authenticate/user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth auth})
      : _firebaseAuth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> authenticate() async {
    return await _firebaseAuth.signInAnonymously();
  }

  @override
  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }
}

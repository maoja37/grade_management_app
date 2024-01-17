import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_management_app/global/utils/extensions.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDisplayName(String username) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(username);
        'Username updated successfully'.log();
      }
    } catch (e) {
      'Error updating username: $e'.log();
    }
  }

  Future<String?> getUsername() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final username = currentUser.displayName;
        return username;
      }
    } catch (e) {
      'Error getting username: $e'.log();
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

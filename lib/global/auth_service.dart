import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Login credentials: $result');
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Register credentials: $result');
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create a method for updating  the  username using firebase
  Future<void> updateDisplayname(String username) async {
    try {
      await auth.currentUser!.updateDisplayName(username);
      print('Username updated successfully');
    } catch (e) {
      print(e.toString());
    }
  }

  //create a method for getting the  username using firebase
  Future<String?> getUsername() async {
    try {
      String username = auth.currentUser!.displayName!;
      print('Username: $username');
      return username;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    await auth.signOut();
  }
}

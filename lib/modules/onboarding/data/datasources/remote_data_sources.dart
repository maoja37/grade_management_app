import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_management_app/global/utils/extensions.dart';
import 'package:grade_management_app/modules/onboarding/data/models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserModel> registerWithEmailAndPassword(
      {required String email, required String password});
  Future<void> updateDisplayName(String username);
  Future<String?> getUsername();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel(
        id: result.user!.uid,
        name: result.user!.displayName,
        email: result.user!.email!,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return UserModel(
        id: result.user!.uid,
        name: result.user!.displayName,
        email: result.user!.email!,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDisplayName(String username) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(username);
        'Username updated successfully'.log();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getUsername() {
    // TODO: implement getUsername
    throw UnimplementedError();
  }
}

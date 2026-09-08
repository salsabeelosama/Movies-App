import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/services/firebase/firebase_auth_service.dart';
import '../model/user_model.dart';

class AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepository({FirebaseAuthService? authService})
      : _authService = authService ?? FirebaseAuthService();

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authService.login(email: email, password: password);
      if (user == null) {
        throw Exception('Login failed. Please try again.');
      }
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  Future<UserModel?> loginWithGoogle() async {
    try {
      final user = await _authService.loginWithGoogle();
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}
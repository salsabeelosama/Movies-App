import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/services/firebase/firebase_auth_service.dart';
import '../model/user_model.dart';

class AuthRepository {
  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
         case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }

    Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  }) async {
    try {
      final user = await _authService.register(
        email: email,
        password: password,
      );

      if (user == null) {
        throw Exception('Registration failed. Please try again.');
      }

      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
      });

      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
  final user = _authService.currentUser;

  if (user == null) {
    throw Exception('No user is logged in');
  }

  final doc = await _firestore
      .collection('users')
      .doc(user.uid)
      .get();

  if (!doc.exists) {
    throw Exception('User profile not found');
  }

  return doc.data()!;
}

Future<void> updateUserProfile({
  required String name,
  required String phone,
  required String avatar,
}) async {
  final user = _authService.currentUser;

  if (user == null) {
    throw Exception('No user is logged in');
  }

  await _firestore.collection('users').doc(user.uid).update({
    'name': name,
    'phone': phone,
    'avatar': avatar,
  });
}

Future<void> deleteAccount() async {
  final user = _authService.currentUser;

  if (user == null) {
    throw Exception('No user is logged in');
  }

  // Delete user data from Firestore
  await _firestore
      .collection('users')
      .doc(user.uid)
      .delete();

  // Delete Firebase Authentication account
  await _authService.deleteAccount();
}
}
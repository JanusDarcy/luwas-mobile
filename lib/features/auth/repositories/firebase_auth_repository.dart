import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw const Failure(
          code: 'user-null',
          message: 'An error occurred. Please try again later.',
        );
      }

      return user;
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'invalid-credential':
        case 'invalid-email':
        case 'user-not-found':
        case 'wrong-password':
          throw Failure(
            code: err.code,
            message: 'Incorrect username or password.',
          );
        case 'user-disabled':
          throw Failure(
            code: err.code,
            message: 'User disabled.',
          );
        case 'too-many-requests':
          throw Failure(
            code: err.code,
            message: 'Too many failed login attempts. Please try again later.',
          );
        default:
          throw Failure(
            code: err.code,
            message: 'An error occurred. Please try again later.',
          );
      }
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw const Failure(
          code: 'user-null',
          message: 'An error occurred during sign up. Please try again later.',
        );
      }

      return user;
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'email-already-in-use':
          throw Failure(
            code: err.code,
            message: 'The email address is already in use by another account.',
          );
        case 'invalid-email':
          throw Failure(
            code: err.code,
            message: 'The email address is not valid.',
          );
        case 'weak-password':
          throw Failure(
            code: err.code,
            message: 'The password is too weak.',
          );
        default:
          throw Failure(
            code: err.code,
            message: 'An error occurred during sign up. Please try again later.',
          );
      }
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null; // User cancelled
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        throw const Failure(
          code: 'user-credential-null',
          message: 'An error occurred. Please try again later.',
        );
      }

      return user;
    } on FirebaseAuthException catch (err) {
      throw Failure(
        code: err.code,
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // This implementation was already correct.
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (err) {
      // It's good that you're re-throwing a Failure here to be caught by AuthService
      throw Failure(
        code: err.code,
        message: 'Failed to send reset email. Please try again.',
      );
    }
  }
}

// Keep the Failure class here if it's not defined elsewhere globally
class Failure implements Exception {
  final String code;
  final String message;

  const Failure({required this.code, required this.message});
}
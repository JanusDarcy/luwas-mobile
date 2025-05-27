import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_password_login/features/auth/repositories/firebase_auth_repository.dart'; // Make sure this import is correct for your Failure class

abstract class AuthRepository {
  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> signInWithGoogle();

  Future<void> signOut();

  // FIXED: Declared as an abstract method without a body, with the correct return type
  Future<void> resetPassword(String email);
}

// Ensure the Failure class is accessible, usually it's in a common utility file
// or defined directly where it's needed like in firebase_auth_repository.dart.
// If it's only in firebase_auth_repository.dart, you might need to move it
// to a common place or import it here if it's meant to be used across
// different repository implementations.
// For now, assuming it's in firebase_auth_repository.dart as you provided,
// so ensure it's still there.
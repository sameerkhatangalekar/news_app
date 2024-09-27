import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/common/data/models/user_model.dart';
import 'package:news_app/core/error/server_exception.dart';

part 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const AuthRemoteDataSourceImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore fireStore})
      : _firebaseAuth = firebaseAuth,
        _firestore = fireStore;

  @override
  Future<bool> signin({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          password: password, email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw const ServerException(message: 'Invalid email');
      } else if (e.code == 'user-disabled') {
        throw const ServerException(message: 'User is disabled!');
      } else if (e.code == 'user-not-found') {
        throw const ServerException(message: 'User not found!');
      } else if (e.code == 'wrong-password') {
        throw const ServerException(message: 'Incorrect Password!');
      } else if (e.code == 'too-many-requests') {
        throw const ServerException(
            message: 'Too many request! Try again after some time!');
      } else if (e.code == 'user-token-expired') {
        throw const ServerException(message: 'Please re-authenticate');
      } else if (e.code == 'network-request-failed') {
        throw const ServerException(
            message: 'Network issue please connect to internet!');
      } else if (e.code == 'invalid-credential') {
        throw const ServerException(
            message: 'Password is invalid for the given email!');
      } else if (e.code == 'operation-not-allowed') {
        throw const ServerException(message: 'User is not enabled yet!');
      } else {
        throw const ServerException(message: 'Unknown Firebase error');
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        throw const ServerException(message: 'Network error');
      } else {
        throw const ServerException(message: 'Unknown platform error');
      }
    } catch (e) {
      throw const ServerException(message: 'Unknown error occurred');
    }
  }

  @override
  Future<bool> signup(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _createUserRecord(email: email, name: name, userCredentials: user);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw const ServerException(
            message: 'An account with this email already exists.');
      } else if (e.code == 'invalid-email') {
        throw const ServerException(message: 'The email address is not valid.');
      } else if (e.code == 'operation-not-allowed') {
        throw const ServerException(
            message:
                'Email/password accounts are not enabled. Please enable them in the Firebase Console.');
      } else if (e.code == 'weak-password') {
        throw const ServerException(
            message: 'The password is not strong enough.');
      } else if (e.code == 'too-many-requests') {
        throw const ServerException(
            message: 'Too many requests. Please wait a moment and try again.');
      } else if (e.code == 'user-token-expired') {
        throw const ServerException(
            message: 'User authentication has expired. Please log in again.');
      } else if (e.code == 'network-request-failed') {
        throw const ServerException(
            message:
                'Network request failed. Please check your internet connection.');
      } else {
        throw const ServerException(message: 'An unknown error occurred.');
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        throw const ServerException(message: 'Network error');
      } else {
        throw const ServerException(message: 'Unknown platform error');
      }
    } catch (e) {
      throw const ServerException(message: 'Unknown error occurred');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (_) {
      throw const ServerException(message: 'Unknown Firebase error');
    }
  }

  @override
  Stream<UserModel?> get userState {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final isAuthenticated = firebaseUser == null
          ? null
          : UserModel(id: firebaseUser.uid, email: firebaseUser.email!);
      return isAuthenticated;
    });
  }

  Future<void> _createUserRecord(
      {required String name,
      required String email,
      required UserCredential userCredentials}) async {
    await _firestore
        .collection('users')
        .doc(userCredentials.user!.uid)
        .set({"name": name, "email": email});
  }
}

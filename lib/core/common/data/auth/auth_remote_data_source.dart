part of 'auth_remote_data_source_impl.dart';
abstract interface class AuthRemoteDataSource {

  Future<bool> signin({required String email, required String password});
  Future<bool> signup({required String email, required String name ,required String password});
  Future<void> signOut();

  Stream<UserModel?> get userState;
}

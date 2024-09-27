import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/common/data/auth/auth_remote_data_source_impl.dart';
import 'package:news_app/core/common/domain/entity/user.dart';
import 'package:news_app/core/common/domain/repository/auth_repository.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/error/server_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, bool>> signin(
      {required String email, required String password}) async {
    try {
      final result =
          await _authRemoteDataSource.signin(email: email, password: password);
      return right(result);
    } on ServerException catch (error) {
      return left(
          error.message.isEmpty ? const Failure() : Failure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, bool>> signup(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final result = await _authRemoteDataSource.signup(
          email: email, password: password, name: name);
      return right(result);
    } on ServerException catch (error) {
      return left(
          error.message.isEmpty ? const Failure() : Failure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await _authRemoteDataSource.signOut();
      return right(result);
    } on ServerException catch (error) {
      return left(
          error.message.isEmpty ? const Failure() : Failure(message: error.message));
    }
  }

  @override
  Stream<UserEntity?> get userState => _authRemoteDataSource.userState;
}

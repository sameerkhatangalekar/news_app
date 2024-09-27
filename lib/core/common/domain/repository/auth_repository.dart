import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/common/domain/entity/user.dart';
import 'package:news_app/core/error/failure.dart';


abstract interface class AuthRepository {
  Future<Either<Failure, bool>> signin(
      {required String email, required String password});

  Future<Either<Failure, bool>> signup({required String email, required String name, required String password});

  Future<Either<Failure, void>> signOut();

  Stream<UserEntity?> get userState;
}

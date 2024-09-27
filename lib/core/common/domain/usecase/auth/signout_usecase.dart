import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';

import '../../repository/auth_repository.dart';


final class SignOutUsecase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams param) async {
    return await _authRepository.signOut();
  }
}

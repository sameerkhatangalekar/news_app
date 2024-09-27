import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';

import '../../repository/auth_repository.dart';

final class SigninUsecase implements UseCase<bool, SignInParams> {
  final AuthRepository _authRepository;

  const SigninUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;


  @override
  Future<Either<Failure, bool>> call(SignInParams param)  async {
    return await _authRepository.signin(email: param.email,   password: param.password);
  }
}

final class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
}

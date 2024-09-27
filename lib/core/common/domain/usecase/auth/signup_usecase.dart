import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/common/domain/repository/auth_repository.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecase/usecase.dart';




class SignupUsecase implements UseCase<bool, SignUpParams> {
  final AuthRepository _authRepository;

  const SignupUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(SignUpParams param) async {
    return await _authRepository.signup(
        email: param.email, name: param.name, password: param.password);
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  const SignUpParams(
      {required this.email, required this.name, required this.password});
}

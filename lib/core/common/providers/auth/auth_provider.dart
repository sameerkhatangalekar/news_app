import 'package:flutter/widgets.dart';
import 'package:news_app/core/common/domain/entity/user.dart';
import 'package:news_app/core/common/domain/repository/auth_repository.dart';
import 'package:news_app/core/common/domain/usecase/auth/signin_usecase.dart';
import 'package:news_app/core/common/domain/usecase/auth/signout_usecase.dart';
import 'package:news_app/core/common/domain/usecase/auth/signup_usecase.dart';
import 'package:news_app/core/constants/enums.dart';
import 'package:news_app/core/usecase/usecase.dart';

final class AuthStatusProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  final SigninUsecase _signinUsecase;
  final SignupUsecase _signupUsecase;
  final SignOutUsecase _signOutUsecase;
  AuthStatus _status = AuthStatus.uninitialized;
  UserEntity? _user;
  String? _error;

  AuthStatusProvider({
    required AuthRepository authRepository,
    required SigninUsecase signinUsecase,
    required SignupUsecase signupUsecase,
    required SignOutUsecase signOutUsecase,
  })  : _signinUsecase = signinUsecase,
        _authRepository = authRepository,
        _signupUsecase = signupUsecase,
        _signOutUsecase = signOutUsecase {
    _authRepository.userState.listen(_onAuthStateChanged);
  }

  AuthStatus get status => _status;

  set setError(_) {
    _error = null;
    notifyListeners();
  }

  String? get error => _error;

  UserEntity? get user => _user;

  Future<void> signIn({required String email, required String password}) async {
    _status = AuthStatus.loading;
    notifyListeners();
    final result = await _signinUsecase(
      SignInParams(email: email, password: password),
    );
    result.fold(
      (l) {
        _status = AuthStatus.failed;
        _error = l.message;
        notifyListeners();
      },
      (r) {
        _status = AuthStatus.authenticated;
        notifyListeners();
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    final result = await _signupUsecase(
      SignUpParams(email: email, password: password, name: name),
    );
    result.fold(
      (l) {
        _status = AuthStatus.failed;
        _error = l.message;
        notifyListeners();
      },
      (r) {
        _status = AuthStatus.authenticated;
        notifyListeners();
      },
    );
  }

  Future signOut() async {
    _status = AuthStatus.loading;
    notifyListeners();
    final result = await _signOutUsecase(const NoParams());
    result.fold(
      (l) {
        _status = AuthStatus.failed;
        _error = l.message;
        notifyListeners();
      },
      (r) {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
      },
    );
  }

  void _onAuthStateChanged(UserEntity? userEntity) {
    if (userEntity == null) {
      _status = AuthStatus.unauthenticated;
    } else {
      _user = userEntity;
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }
}




import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/error/failure.dart';

abstract interface class UseCase<Success,Param> {
  Future<Either<Failure,Success>> call(Param p);
}

final class NoParams {
  const NoParams();
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/common/data/auth/auth_remote_data_source_impl.dart';
import 'package:news_app/core/common/data/repository/auth_repository_impl.dart';
import 'package:news_app/core/common/domain/repository/auth_repository.dart';
import 'package:news_app/core/common/domain/usecase/auth/signin_usecase.dart';
import 'package:news_app/core/common/domain/usecase/auth/signout_usecase.dart';
import 'package:news_app/core/common/domain/usecase/auth/signup_usecase.dart';
import 'package:news_app/core/common/providers/auth/auth_provider.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/repository/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';
import 'package:news_app/features/news/domain/usecase/fetch_news_usecase.dart';
import 'package:news_app/features/news/presentation/provider/news_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initAuth();
  await initNews();
}

void initAuth() {
  serviceLocator
    ..registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator(),
        fireStore: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SigninUsecase>(
      () => SigninUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SignupUsecase>(
      () => SignupUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthStatusProvider>(
      () => AuthStatusProvider(
        signinUsecase: serviceLocator(),
        signupUsecase: serviceLocator(),
        authRepository: serviceLocator(),
        signOutUsecase: serviceLocator(),
      ),
    );
}

Future<void> initNews() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.setDefaults({'countryCode': 'us'});

  serviceLocator
    ..registerLazySingleton<FirebaseRemoteConfig>(
      () => remoteConfig,
    )
    ..registerLazySingleton<NewsRemoteDatasource>(
      () => NewsRemoteDatasourceImpl(dio: Dio()),
    )
    ..registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(
        newsRemoteDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<FetchNewsUsecase>(
      () => FetchNewsUsecase(
        newsRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<NewsProvider>(
      () => NewsProvider(
        remoteConfig: serviceLocator(),
        fetchNewsUsecase: serviceLocator(),
      ),
    );
}

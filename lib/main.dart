import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/common/providers/auth/auth_provider.dart';
import 'package:news_app/core/router/router.dart';
import 'package:news_app/core/theme/theme.dart';
import 'package:news_app/features/news/presentation/provider/news_provider.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/init_dependencies.main.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => serviceLocator<AuthStatusProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => serviceLocator<NewsProvider>(),
        )
      ],
      child: Consumer<AuthStatusProvider>(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'News App',
            theme: AppThemeData.theme,
            debugShowCheckedModeBanner: false,
          ),
          builder: (context, provider, child) {
            AppRouter.router.refresh();
            return child!;
          }),
    ),
  );
  
}






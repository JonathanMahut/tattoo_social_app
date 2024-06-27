import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tattoo_social_app/app/config/routes.dart';
import 'package:tattoo_social_app/app/theme/theme.dart';
import 'package:tattoo_social_app/core/utils/constants.dart';
import 'package:tattoo_social_app/presentation/blocs/auth_bloc.dart';
import 'package:tattoo_social_app/presentation/blocs/feed_bloc.dart';
import 'package:tattoo_social_app/presentation/screens/main_navigation.dart';
import 'package:tattoo_social_app/services/auth_service.dart';
import 'package:tattoo_social_app/services/post_service.dart';
import 'package:tattoo_social_app/services/tatoo_service.dart';

class MyApp extends StatelessWidget {
  final AuthService authService;
  final PostService postService;
  final TattooService tattooService;

  const MyApp({
    super.key,
    required this.authService,
    required this.postService,
    required this.tattooService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authService),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(postService),
        ),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: AppThemeConfig.lightTheme,
        darkTheme: AppThemeConfig.darkTheme,
        themeMode: ThemeMode.system,
        home: const MainNavigation(),
        initialRoute: '/',
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

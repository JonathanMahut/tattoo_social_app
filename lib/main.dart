import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/blocs/auth_bloc.dart';
import 'package:tattoo_social_app/blocs/feed_bloc.dart';
import 'package:tattoo_social_app/config/routes.dart';
import 'package:tattoo_social_app/config/theme.dart';
import 'package:tattoo_social_app/firebase_options.dart';
import 'package:tattoo_social_app/providers/current_user_data_provider.dart';
import 'package:tattoo_social_app/providers/user_provider.dart';
import 'package:tattoo_social_app/services/auth_service.dart';
import 'package:tattoo_social_app/services/post_service.dart';
import 'package:tattoo_social_app/services/tatoo_service.dart';
import 'package:tattoo_social_app/services/user_service.dart';
import 'package:tattoo_social_app/utils/constants.dart';
import 'package:tattoo_social_app/utils/firebase.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseUtil = FirebaseUtil(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
    uuid: const Uuid(),
  );

  final authService = AuthService();
  final postService = PostService(firebaseUtil);
  final tattooService = TattooService(firebaseUtil);

  // Create UserService instance with firebaseUtil
  final userService = UserService(firebaseUtil);

  final userProvider =
      UserProvider(userService, firebaseUtil); // Pass both arguments

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => userProvider,
        ),
        ChangeNotifierProvider(create: (_) => CurrentUserDataProvider()),
        Provider<AuthService>(create: (_) => authService),
        Provider<PostService>(create: (_) => postService),
        Provider<TattooService>(create: (_) => tattooService),
        Provider<FirebaseUtil>(create: (_) => firebaseUtil),
      ],
      child: MyApp(
        authService: authService,
        postService: postService,
        tattooService: tattooService,
      ),
    ),
  );
}

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
        initialRoute: '/',
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

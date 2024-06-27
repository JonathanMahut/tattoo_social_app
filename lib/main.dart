import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/app/app.dart';
import 'package:tattoo_social_app/core/utils/firebase.dart';
import 'package:tattoo_social_app/data/providers/current_user_data_provider.dart';
import 'package:tattoo_social_app/data/providers/user_provider.dart';
import 'package:tattoo_social_app/firebase_options.dart';
import 'package:tattoo_social_app/services/auth_service.dart';
import 'package:tattoo_social_app/services/post_service.dart';
import 'package:tattoo_social_app/services/tatoo_service.dart';
import 'package:tattoo_social_app/services/user_service.dart';
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

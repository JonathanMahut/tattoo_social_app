import 'package:flutter/material.dart';

class AppConfig {
  // Configurations générales de l'application
  // static const String appName = "Tatoo Connect";
  // static const String appVersion = "1.0.0";
  // static const String environment = "development"; // ou "production"

  // // Configurations Firebase
  // static const String firebaseProjectId = "votre-projet-firebase-id";
  // static const String firebaseApiKey = "votre-api-key-firebase";
  // static const String firebaseAppId = "votre-app-id-firebase";
  // static const String firebaseMessagingSenderId = "votre-sender-id";
  // static const String firebaseStorageBucket =
  //     "votre-storage-bucket.appspot.com";

  // Configurations Facebook
  static const String facebookAppId = "votre-facebook-app-id";
  static const String facebookClientToken = "votre-facebook-client-token";

  // Configurations d'authentification
  static const List<String> supportedAuthMethods = [
    'email',
    'google',
    'facebook'
  ];

  // Configurations Firestore
  static const String userCollectionName = "users";
  static const String postsCollectionName = "posts";
  static const String commentsCollectionName = "comments";

  // Configurations Firebase Storage
  static const String userProfileImagesPath = "profile_images";
  static const String postImagesPath = "post_images";

  // Configurations Firebase Cloud Messaging
  static const String fcmTopic = "all_users";

  // Paramètres de l'application
  static const int maxUploadableImages = 10;
  // static const List<String> supportedTattooStyles = [
  //   'Traditional',
  //   'Realism',
  //   'Watercolor',
  //   'Tribal',
  //   'Japanese',
  //   "Manga",
  //   "Modern",
  //   "Abstract",
  //   "Retro",
  //   "Minimalism",
  //   "Neo-traditional",
  //   "Trash Polka",
  //   "Black",
  //   "Floral",
  //   "New School",
  //   "Traditional US",
  //   "Horror",
  //   "Ornemental",
  //   "Dot",
  //   "Animal",
  //   "Portrait",
  //   "Biomecanical",
  //   "Lettring",
  //   "Polynesian",
  //   "Geometric",
  //   "Symbolism",
  //   "Esoteric"
  // ];
  // static const int maxBioLength = 500;

  // Paramètres de pagination pour Firestore
  static const int firestorePageSize = 20;

  // Paramètres de cache
  static const Duration firebaseCacheDuration = Duration(hours: 1);

  // Paramètres de thème
  static const bool useDarkThemeByDefault = false;

  // Paramètres de localisation
  static const Locale defaultLocale = Locale('fr', 'FR');
  static const List<Locale> supportedLocales = [
    Locale('fr', 'FR'),
    Locale('en', 'US'),
  ];

/*
  // URLs importantes
  static const String termsOfServiceUrl = "https://votreapp.com/terms";
  static const String privacyPolicyUrl = "https://votreapp.com/privacy";

  // Paramètres sociaux
  static const String twitterHandle = "@votreapp";
  static const String instagramHandle = "votreapp";
  */
}

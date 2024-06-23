# tattoo_social_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Implementation :


Explications des ajouts spécifiques à Firebase :

1. **Configurations Firebase** : Ces constantes sont nécessaires pour initialiser Firebase dans votre application. Vous les trouverez dans votre console Firebase.
2. **Configurations Firestore** : Noms des collections que vous utiliserez dans Firestore.
3. **Configurations Firebase Storage** : Chemins pour le stockage des images.
4. **Configurations Firebase Authentication** : Méthodes d'authentification que vous prévoyez d'utiliser.
5. **Configurations Firebase Cloud Messaging** : Utile si vous prévoyez d'utiliser les notifications push.
6. **Paramètres de pagination pour Firestore** : Utile pour la pagination des requêtes Firestore.
7. **Paramètres de cache** : Durée de mise en cache des données Firebase.

N'oubliez pas de remplacer les valeurs comme "votre-projet-firebase-id" par vos véritables identifiants Firebase.

* N'oubliez pas de configurer Firebase dans votre projet :

  * Pour Android : Mettez à jour votre fichier `android/app/build.gradle` avec votre `applicationId` de Firebase.
  * Pour iOS : Mettez à jour votre fichier `ios/Runner/Info.plist` avec les configurations nécessaires pour Google et Facebook Sign-In.
* Pour Facebook Sign-In, vous devrez également configurer votre application Facebook dans le Facebook Developer Console et ajouter les configurations nécessaires à votre projet Flutter.

  https://pub.dev/packages/flutter_facebook_auth/install

  Pour Google SignIn

  https://pub.dev/packages/google_sign_in
* Dans app_config.dart : Assurez-vous de remplacer "votre-facebook-app-id" et "votre-facebook-client-token" par les valeurs réelles de votre application Facebook.
* De plus, vous devrez probablement mettre à jour vos fichiers de configuration natifs :
* Pour Android, dans `android/app/src/main/res/values/strings.xml` :

  <resources>
      <string name="facebook_app_id">votre-facebook-app-id</string>
      <string name="fb_login_protocol_scheme">fbvotre-facebook-app-id</string>
      <string name="facebook_client_token">votre-facebook-client-token</string>
  </resources>

  ```
  <key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>fbvotre-facebook-app-id</string>
      </array>
    </dict>
  </array>
  <key>FacebookAppID</key>
  <string>votre-facebook-app-id</string>
  <key>FacebookClientToken</key>
  <string>votre-facebook-client-token</string>
  <key>FacebookDisplayName</key>
  <string>Votre Nom d'App</string>
  ```

# Architecture :

 lib/
├── config/
├── models/
├── screens/
├── widgets/
├── services/
├── utils/
├── blocs/
└── main.dart

* Créez les fichiers de base dans chaque dossier :
  * Dans `config/` :
    `app_config.dart theme.dart routes.dart`
  * Dans `models/` :
    `user_model.dart tattoo_model.dart event_model.dart product_model.dart`
  * Dans `screens/` :
    `home_screen.dart auth_screen.dart profile_screen.dart tattoo_swipe_screen.dart`
  * Dans `widgets/` :
    `custom_app_bar.dart tattoo_card.dart`
  * Dans `services/` :
    `auth_service.dart database_service.dart storage_service.dart`
  * Dans `utils/` :
    `constants.dart helpers.dart`
  * Dans `blocs/` :
    `auth_bloc.dart tattoo_swipe_bloc.dart`

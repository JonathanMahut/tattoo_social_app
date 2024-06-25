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

# Géolocalisation


N'oubliez pas d'ajouter les permissions nécessaires dans vos fichiers de configuration Android et iOS :

Pour Android, ajoutez ces lignes dans `android/app/src/main/AndroidManifest.xml` :

<pre><div class="relative flex flex-col rounded-lg"><div class="text-text-300 absolute pl-3 pt-2.5 text-xs">xml</div><div class="pointer-events-none sticky z-20 my-0.5 ml-0.5 flex items-center justify-end px-1.5 py-1 mix-blend-luminosity top-12"><div class="from-bg-300/90 to-bg-300/70 pointer-events-auto rounded-md bg-gradient-to-b p-0.5 backdrop-blur-md"><button class="flex flex-row items-center gap-1 rounded-md p-1 py-0.5 text-xs transition-opacity delay-100 hover:bg-bg-200"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" viewBox="0 0 256 256" class="text-text-500 mr-px -translate-y-[0.5px]"><path d="M200,32H163.74a47.92,47.92,0,0,0-71.48,0H56A16,16,0,0,0,40,48V216a16,16,0,0,0,16,16H200a16,16,0,0,0,16-16V48A16,16,0,0,0,200,32Zm-72,0a32,32,0,0,1,32,32H96A32,32,0,0,1,128,32Zm72,184H56V48H82.75A47.93,47.93,0,0,0,80,64v8a8,8,0,0,0,8,8h80a8,8,0,0,0,8-8V64a47.93,47.93,0,0,0-2.75-16H200Z"></path></svg><span class="text-text-200 pr-0.5">Copy</span></button></div></div><div><div class="code-block__code !my-0 !rounded-lg !text-sm !leading-relaxed"><code class="language-xml"><span><span class="token"><</span><span class="token">uses-permission</span><span class="token"></span><span class="token">android:</span><span class="token">name</span><span class="token">=</span><span class="token">"</span><span class="token">android.permission.ACCESS_FINE_LOCATION</span><span class="token">"</span><span class="token"></span><span class="token">/></span><span>
</span></span><span><span></span><span class="token"><</span><span class="token">uses-permission</span><span class="token"></span><span class="token">android:</span><span class="token">name</span><span class="token">=</span><span class="token">"</span><span class="token">android.permission.ACCESS_COARSE_LOCATION</span><span class="token">"</span><span class="token"></span><span class="token">/></span></span></code></div></div></div></pre>

Pour iOS, ajoutez ces lignes dans `ios/Runner/Info.plist` :

**<**key**>**NSLocationWhenInUseUsageDescription**</**key**>**
**<**string**>**This app needs access to location when open.**</**string**>**
**<**key**>**NSLocationAlwaysUsageDescription**</**key**>**
**<**string**>**This app needs access to location when in the background.**</**string**>**



# Image Picker


N'oubliez pas d'ajouter les permissions nécessaires dans vos fichiers de configuration Android et iOS :

Pour Android, ajoutez ces lignes dans `android/app/src/main/AndroidManifest.xml` :

<pre><div class="relative flex flex-col rounded-lg"><div class="text-text-300 absolute pl-3 pt-2.5 text-xs">xml</div><div class="pointer-events-none sticky z-20 my-0.5 ml-0.5 flex items-center justify-end px-1.5 py-1 mix-blend-luminosity top-12"><div class="from-bg-300/90 to-bg-300/70 pointer-events-auto rounded-md bg-gradient-to-b p-0.5 backdrop-blur-md"><button class="flex flex-row items-center gap-1 rounded-md p-1 py-0.5 text-xs transition-opacity delay-100 hover:bg-bg-200"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" viewBox="0 0 256 256" class="text-text-500 mr-px -translate-y-[0.5px]"><path d="M200,32H163.74a47.92,47.92,0,0,0-71.48,0H56A16,16,0,0,0,40,48V216a16,16,0,0,0,16,16H200a16,16,0,0,0,16-16V48A16,16,0,0,0,200,32Zm-72,0a32,32,0,0,1,32,32H96A32,32,0,0,1,128,32Zm72,184H56V48H82.75A47.93,47.93,0,0,0,80,64v8a8,8,0,0,0,8,8h80a8,8,0,0,0,8-8V64a47.93,47.93,0,0,0-2.75-16H200Z"></path></svg><span class="text-text-200 pr-0.5">Copy</span></button></div></div><div><div class="code-block__code !my-0 !rounded-lg !text-sm !leading-relaxed"><code class="language-xml"><span><span class="token"><</span><span class="token">uses-permission</span><span class="token"></span><span class="token">android:</span><span class="token">name</span><span class="token">=</span><span class="token">"</span><span class="token">android.permission.READ_EXTERNAL_STORAGE</span><span class="token">"</span><span class="token"></span><span class="token">/></span><span>
</span></span><span><span></span><span class="token"><</span><span class="token">uses-permission</span><span class="token"></span><span class="token">android:</span><span class="token">name</span><span class="token">=</span><span class="token">"</span><span class="token">android.permission.CAMERA</span><span class="token">"</span><span class="token"></span><span class="token">/></span></span></code></div></div></div></pre>


Pour iOS, ajoutez ces lignes dans `ios/Runner/Info.plist` :

<pre><div class="relative flex flex-col rounded-lg"><div class="text-text-300 absolute pl-3 pt-2.5 text-xs">xml</div><div class="pointer-events-none sticky z-20 my-0.5 ml-0.5 flex items-center justify-end px-1.5 py-1 mix-blend-luminosity top-12"><div class="from-bg-300/90 to-bg-300/70 pointer-events-auto rounded-md bg-gradient-to-b p-0.5 backdrop-blur-md"><button class="flex flex-row items-center gap-1 rounded-md p-1 py-0.5 text-xs transition-opacity delay-100 hover:bg-bg-200"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" viewBox="0 0 256 256" class="text-text-500 mr-px -translate-y-[0.5px]"><path d="M200,32H163.74a47.92,47.92,0,0,0-71.48,0H56A16,16,0,0,0,40,48V216a16,16,0,0,0,16,16H200a16,16,0,0,0,16-16V48A16,16,0,0,0,200,32Zm-72,0a32,32,0,0,1,32,32H96A32,32,0,0,1,128,32Zm72,184H56V48H82.75A47.93,47.93,0,0,0,80,64v8a8,8,0,0,0,8,8h80a8,8,0,0,0,8-8V64a47.93,47.93,0,0,0-2.75-16H200Z"></path></svg><span class="text-text-200 pr-0.5">Copy</span></button></div></div><div><div class="code-block__code !my-0 !rounded-lg !text-sm !leading-relaxed"><code class="language-xml"><span><span class="token"><</span><span class="token">key</span><span class="token">></span><span>NSPhotoLibraryUsageDescription</span><span class="token"></</span><span class="token">key</span><span class="token">></span><span>
</span></span><span><span></span><span class="token"><</span><span class="token">string</span><span class="token">></span><span>This app needs access to photos for profile picture selection.</span><span class="token"></</span><span class="token">string</span><span class="token">></span><span>
</span></span><span><span></span><span class="token"><</span><span class="token">key</span><span class="token">></span><span>NSCameraUsageDescription</span><span class="token"></</span><span class="token">key</span><span class="token">></span><span>
</span></span><span><span></span><span class="token"><</span><span class="token">string</span><span class="token">></span><span>This app needs access to camera for profile picture capture.</span><span class="token"></</span><span class="token">string</span><span class="token">></span></span></code></div></div></div></pre>

Pour le cropping d'image :


Pour que cela fonctionne correctement sur Android, vous devez également ajouter l'activité de recadrage dans votre fichier `android/app/src/main/AndroidManifest.xml` :

<pre><div class="relative flex flex-col rounded-lg"><div class="text-text-300 absolute pl-3 pt-2.5 text-xs">xml</div><div class="pointer-events-none sticky z-20 my-0.5 ml-0.5 flex items-center justify-end px-1.5 py-1 mix-blend-luminosity top-12"><div class="from-bg-300/90 to-bg-300/70 pointer-events-auto rounded-md bg-gradient-to-b p-0.5 backdrop-blur-md"><button class="flex flex-row items-center gap-1 rounded-md p-1 py-0.5 text-xs transition-opacity delay-100 hover:bg-bg-200"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" viewBox="0 0 256 256" class="text-text-500 mr-px -translate-y-[0.5px]"><path d="M200,32H163.74a47.92,47.92,0,0,0-71.48,0H56A16,16,0,0,0,40,48V216a16,16,0,0,0,16,16H200a16,16,0,0,0,16-16V48A16,16,0,0,0,200,32Zm-72,0a32,32,0,0,1,32,32H96A32,32,0,0,1,128,32Zm72,184H56V48H82.75A47.93,47.93,0,0,0,80,64v8a8,8,0,0,0,8,8h80a8,8,0,0,0,8-8V64a47.93,47.93,0,0,0-2.75-16H200Z"></path></svg><span class="text-text-200 pr-0.5">Copy</span></button></div></div><div><div class="code-block__code !my-0 !rounded-lg !text-sm !leading-relaxed"><code class="language-xml"><span><span class="token"><</span><span class="token">activity</span><span class="token">
</span></span><span><span class="token"></span><span class="token">android:</span><span class="token">name</span><span class="token">=</span><span class="token">"</span><span class="token">com.yalantis.ucrop.UCropActivity</span><span class="token">"</span><span class="token">
</span></span><span><span class="token"></span><span class="token">android:</span><span class="token">screenOrientation</span><span class="token">=</span><span class="token">"</span><span class="token">portrait</span><span class="token">"</span><span class="token">
</span></span><span><span class="token"></span><span class="token">android:</span><span class="token">theme</span><span class="token">=</span><span class="token">"</span><span class="token">@style/Theme.AppCompat.Light.NoActionBar</span><span class="token">"</span><span class="token">/></span></span></code></div></div></div></pre>

Et pour iOS, assurez-vous d'avoir ajouté les permissions nécessaires dans votre fichier `ios/Runner/Info.plist` comme mentionné précédemment.

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

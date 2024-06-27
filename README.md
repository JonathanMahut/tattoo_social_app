# tattoo_social_app

A new Flutter project.

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
      ├── enums/
    ├── screens/
    ├── widgets/
    ├── services/
    ├── utils/
    ├── blocs/
    ├── data/
    ├── providers/
    └── main.dart
    ├── firebase_options.dart

* Créez les fichiers de base dans chaque dossier :
  * Dans `config/` :
    `app_config.dart theme.dart routes.dart`
  * Dans `models/` :
    `user_model.dart tattoo_model.dart event_model.dart product_model.dart post_model.dart social_media_link_model.dart`
    * Enums/app_the.dart event_type.dart gender_type.dart subscription_type.dart supplier_type.dart tatoo_style.dart user_type.dart
  * Dans `screens/` :
    `home_screen.dart auth_screen.dart profile_screen.dart tattoo_swipe_screen.dart home_screen.dart edit_profile_screen.dart feed_screen.dart`
  * Dans `widgets/` :
    `custom_app_bar.dart tattoo_card.dart post_card.dart indicators.dart cached_image.dart tatoo_card.dart`
  * Dans `services/` :
    `auth_service.dart database_service.dart storage_service.dart post_service.dart tatoo_service.dart user_service.dart`
  * Dans `utils/` :
    `constants.dart helpers.dart file_utils.dart firebase.dart permissions.dart validation.dart`
  * Dans `blocs/` :
    `auth_bloc.dart tattoo_swipe_bloc.dart feed_bloc.dart`
  * Dans data/:
    current_user_data.dart current_user_data.freezed.dart
  * Dans providers/:current_user_data_provider.dart user_provider.dart


## 1.

Présentation générale

"Tatoo
Connect" est une application Flutter dans sa dernière version, utilisant
Firebase comme backend. C'est un réseau social destiné aux tatoueurs, leurs
clients, aux organisateurs d'événements autour du tatouage, et aux fournisseurs
de matériels de tatouages.

## 2.

Modèle économique

- Gratuit pour les
  Clients
- Payant pour les
  Tatoueurs, les organisateurs d'événements et les fournisseurs
- Système
  d'abonnement annuel avec différents niveaux de prix :

  * Abonnement Tatoueur : le plus cher, accès à
    toutes les fonctionnalités
  * Abonnement Organisateur d'événement : prix
    intermédiaire, création d'événements et de posts
  * Abonnement Fournisseur : le moins cher,
    possibilité de créer des posts pour présenter leurs produits
- Période d'essai
  gratuite d'un mois ou 5 posts sans paiement pour les comptes payants

## 3.

Fonctionnalités principales

### 3.1

Page de Feed

- Similaire à
  Instagram
- Affichage de Posts
  créés par les Tatoueurs, organisateurs d'événements et fournisseurs
- Tous les
  utilisateurs peuvent accéder au Feed, liker un Post, commenter un post, suivre
  un autre Utilisateur
- Présentation des
  Posts sous forme de Card avec :

  * Photo de profil miniature et nom
    d'utilisateur en haut (cliquable pour accéder au profil)
  * Zone d'images/vidéos avec carrousel si
    multiple
  * Fonctionnalités de like (icône cœur),
    commentaire et partage
  * Compteur de likes
  * Possibilité d'afficher les commentaires
    dans un nouvel écran
- Infinite scroll
  pour le chargement des posts

### 3.2

Swipe de Modèles de Tatouage

- Interface
  similaire à Tinder
- Swipe gauche pour
  Disliker, droite pour Liker, bas pour voir les détails, haut pour Super Like
- Seuls les
  Tatoueurs peuvent ajouter des Modèles de tatouage
- Super Like ajoute
  le modèle aux favoris et notifie le Tatoueur
- Possibilité
  d'envoyer un message privé au tatoueur après un Super Like

### 3.3

Système de Chat interne

- Messagerie écrite,
  vocale et vidéo
- Interface
  similaire à WhatsApp/Instagram/Messenger
- Annuaire de
  contacts personnalisable, classé par types (Client, Tatoueur, Organisateur
  d'événement, Fournisseur)
- Recherche de
  contacts, appels vocaux/vidéo, envoi de pièces jointes

### 3.4

Moteur de recherche

- Recherche de
  posts, utilisateurs, modèles de tatouage, produits
- Filtres multiples
  et utilisation de la géolocalisation
- Sauvegarde des
  recherches pour une utilisation ultérieure
- Fonctionnalité
  proche de celle de l'application SeLoger

### 3.5

Profil utilisateur

- Affichage et
  modification des informations personnelles (nom d'utilisateur, photo de profil,
  bio, localisation, genre, type)
- Statistiques
  (nombre de followers, posts, likes)
- Gestion des
  abonnements et blocages
- Fonctionnalités
  spécifiques selon le type d'utilisateur (ex: ajout de modèles pour les
  tatoueurs)
- Liste des posts
  créés avec statistiques (likes, commentaires)
- Option de
  suppression de compte

### 3.6

Gestion des événements

- Création et
  gestion d'événements par les organisateurs
- Participation des
  tatoueurs et fournisseurs aux événements
- Publication
  automatique des événements dans le Feed

### 3.7

Système de paiement

- Création et
  gestion d'événements par les organisateurs
- Informations de
  l'événement : image de présentation, description, lieu (avec carte
  géolocalisée), dates de début et fin, coordonnées de contact
- Possibilité
  d'inviter directement des tatoueurs et fournisseurs via l'application
- Publication
  automatique des événements dans le Feed (republication périodique paramétrable)
- Notification aux
  organisateurs lorsque tatoueurs ou fournisseurs souhaitent participer
- Intégration d'un
  système de paiement pour les abonnements
- Période d'essai
  gratuite pour les comptes payants (1 mois ou 5 posts)
- Gestion des
  changements de type d'utilisateur (ex: passage de Client à Tatoueur)

### 3.8

Gamification

- Système de points
  ou de badges pour encourager l'engagement
- Récompenses pour
  les publications régulières, interactions positives, participation aux
  événements

### 3.9

Réalité augmentée

- Fonctionnalité
  permettant aux clients d'essayer virtuellement un tatouage sur leur peau
- Intégration avec
  la caméra du dispositif

### 3.10

Portfolios pour tatoueurs

- Section dédiée aux
  portfolios des tatoueurs dans leur profil
- Mise en valeur des
  meilleures réalisations
- Galerie
  photo/vidéo personnalisable
- Descriptions
  détaillées des œuvres

### 3.11

Système de réservation

- Prise de
  rendez-vous directe avec les tatoueurs via l'application
- Calendrier intégré
  pour la gestion des disponibilités
- Système de
  confirmation et de rappel automatique

### 3.12

Marketplace

- Section permettant
  aux fournisseurs de vendre leurs produits
- Catalogue de
  produits avec descriptions, prix et disponibilités
- Système de panier
  et de paiement sécurisé
- Suivi des
  commandes et des livraisons

### 3.13

Conseils et tutoriels

- Section éducative
  avec articles et vidéos
- Contenu sur les
  soins post-tatouage, les tendances, les techniques
- Possibilité pour
  les professionnels de contribuer au contenu

### 3.14

Notifications personnalisées

- Système de
  notifications amélioré
- Alertes pour
  nouveaux modèles, événements ou promotions selon les préférences
- Paramètres de
  personnalisation des notifications

### 3.15

Intégration de l'IA

- Suggestion de
  modèles de tatouage basée sur les préférences de l'utilisateur
- Analyse des
  tendances et recommandations personnalisées
- Assistance
  virtuelle pour répondre aux questions fréquentes

### 3.16

Mode hors ligne

- Accès à certaines
  fonctionnalités en mode hors ligne
- Synchronisation
  automatique lors de la reconnexion
- Mise en cache
  intelligente des données fréquemment utilisées

### 3.17

Accessibilité

- Conformité aux
  normes d'accessibilité (WCAG)
- Support pour les
  lecteurs d'écran
- Options de
  contraste élevé et de taille de texte ajustable

### 3.18

Statistiques pour les professionnels

- Tableaux de bord
  détaillés pour tatoueurs et organisateurs d'événements
- Analyses des
  performances (vues, likes, réservations, ventes)
- Rapports
  personnalisables et exportables

### 3.19

Système de parrainage

- Programme de
  parrainage pour encourager les invitations
- Récompenses pour
  le parrain et le filleul
- Suivi des
  parrainages et des récompenses dans le profil utilisateur

### 3.20

Intégration des réseaux sociaux

- Partage facile des
  contenus sur d'autres plateformes sociales (Instagram, Facebook, Twitter, etc.)
- Boutons de partage
  intégrés pour les posts, modèles de tatouage, événements et portfolios
- Option de
  cross-posting automatique pour les professionnels
- Importation de
  contacts depuis les réseaux sociaux

### 3.21

Version légère de l'application

- Version allégée
  pour les appareils avec moins de ressources
- Fonctionnalités de
  base maintenues avec une interface simplifiée
- Optimisation de la
  taille de l'application et de l'utilisation des ressources
- Option de basculer
  entre la version complète et la version légère

## 4.

Interface utilisateur

- TabScreen
  principal avec :

  * AppBar en haut contenant le logo et le nom
    "Tatoo Connect" (cliquable pour accéder à l'écran About)
  * Zone centrale pour le contenu principal
  * TabBar en bas avec icônes pour les
    principales fonctionnalités :

    - Icône Home pour le Feed (visible pour
      tous les utilisateurs)
    - Icône Flash pour la fonctionnalité
      "Tinder" de modèles de tatouage (sauf pour les fournisseurs)
    - Icône "+" pour créer un nouveau
      Post/Story/Événement (selon le type d'utilisateur)
    - Icône Recherche (pour tous les
      utilisateurs)
    - Icône Message pour le chat (pour tous les
      utilisateurs)
    - Icône Profile pour accéder au profil de
      l'utilisateur courant
- Design adaptatif
  pour différentes tailles d'écran
- Thèmes
  personnalisables (clair, sombre, système, personnalisé)
- Intégration fluide
  des nouvelles fonctionnalités dans l'interface existante
- Nouvelle section
  "Marketplace" dans la navigation principale
- Onglet
  "Éducation" pour accéder aux conseils et tutoriels
- Intégration des
  boutons de partage social de manière non intrusive
- Design adaptatif
  pour la version légère, privilégiant la fonctionnalité sur l'esthétique
  complexe

## 5.

Authentification et gestion des comptes

- Page de Login avec
  options Email/Password, Google Sign In, Facebook Sign In
- Création de compte
  avec choix du type d'utilisateur
- Gestion du profil
  (modification, suppression)
- Niveaux d'accès
  différenciés selon le type d'utilisateur (client, tatoueur, fournisseur,
  organisateur)
- Option de
  connexion via les comptes de réseaux sociaux
- Synchronisation
  des profils avec les réseaux sociaux (si l'utilisateur le souhaite)

## 6.

Aspects techniques

- Développement en
  Flutter pour Android, iOS, PWA et web
- Backend Firebase
  (Authentication, Firestore, Storage)
- Architecture
  suivant le pattern Bloc
- 

Internationalisation (possibilité de changer de langue sans redémarrer
l'application)

- Mode hors ligne
  partiel
- Intégration d'un
  système de paiement sécurisé pour la marketplace
- Mise en place d'un
  système de cache pour le mode hors ligne
- Développement
  d'API pour l'intégration de l'IA et des analyses statistiques
- Développement
  d'APIs pour l'intégration avec les principales plateformes de réseaux sociaux
- Optimisation du
  code et des ressources pour la version légère de l'application
- Mise en place d'un
  système de détection automatique des capacités de l'appareil

## 7.

Sécurité et confidentialité

- Gestion sécurisée
  des données utilisateurs
- Options de
  confidentialité pour les profils et les publications
- Conformité au RGPD
  pour la collecte et l'utilisation des données personnelles
- Chiffrement des
  données sensibles, notamment pour les transactions de la marketplace
- Paramètres de
  confidentialité granulaires pour contrôler ce qui est partagé sur les réseaux
  sociaux
- Politique de
  confidentialité mise à jour pour couvrir l'intégration des réseaux sociaux

## 8.

Déploiement et maintenance

- Disponibilité sur
  Google Play Store et Apple App Store
- Mises à jour
  régulières et support utilisateur
- Plan de mise à
  jour régulier pour intégrer progressivement les nouvelles fonctionnalités
- Support technique
  dédié pour les utilisateurs professionnels (tatoueurs, fournisseurs,
  organisateurs)
- Déploiement séparé
  de la version légère sur les stores d'applications
- Stratégie de mise
  à jour pour maintenir la cohérence entre la version complète et la version
  légère

## 9.

Évolutivité et scalabilité

- Architecture
  conçue pour supporter une croissance importante du nombre d'utilisateurs
- Possibilité
  d'ajouter de nouvelles fonctionnalités sans perturber l'existant
- Optimisation
  continue des performances de l'application
- Conception
  modulaire permettant l'activation/désactivation facile des fonctionnalités dans
  la version légère
- Surveillance des
  métriques d'utilisation pour optimiser continuellement les deux versions de
  l'application

## 10.

Marketing et promotion

- Utilisation des
  fonctionnalités de partage social pour augmenter la visibilité de l'application
- Campagnes ciblées
  pour promouvoir la version légère dans les marchés où les appareils à faibles
  ressources sont prédominants
- Programme de
  récompenses pour encourager le partage et l'engagement sur les réseaux sociaux

# Architecture

de base :

Certainement. Voici
une proposition d'architecture idéale pour le projet "Tatoo Connect",
basée sur les dernières versions de Dart et Flutter, ainsi que les meilleures
pratiques de développement :

## 1.

Architecture globale : Clean Architecture + BLoC Pattern

La Clean
Architecture sera utilisée pour séparer les préoccupations et maintenir une
base de code modulaire et testable. Elle sera combinée avec le pattern BLoC
(Business Logic Component) pour la gestion de l'état.

| Couches principales |
| :-----------------: |

a) Presentation
Layer

b) Domain Layer

c) Data Layer

## 2.

Structure des dossiers

```



lib/



├── app/



│   ├── app.dart



│   └── theme/



├── core/



│   ├── error/



│   ├── network/



│   ├── usecases/



│   └── util/



├── data/



│   ├── datasources/



│   ├── models/



│   └── repositories/



├── domain/



│   ├── entities/



│   ├── repositories/



│   └── usecases/



├── presentation/



│   ├── blocs/



│   ├── pages/



│   └── widgets/



└── main.dart



```

## 3.

Gestion des dépendances : GetIt

Utiliser GetIt pour
l'injection de dépendances, facilitant la gestion des instances et améliorant
la testabilité.

## 4.

Navigation : GoRouter

Implémenter GoRouter
pour une gestion efficace de la navigation et des routes nommées.

## 5.

Gestion de l'état : flutter_bloc

Utiliser le package
flutter_bloc pour implémenter le pattern BLoC de manière cohérente dans toute
l'application.

## 6.

Gestion des API : Dio + Retrofit

Combiner Dio pour
les requêtes HTTP avec Retrofit pour générer automatiquement les clients API.

## 7.

Persistence locale : Hive

Utiliser Hive pour
le stockage local, offrant de bonnes performances et une API simple.

## 8.

Internationalisation : easy_localization

Implémenter
easy_localization pour gérer facilement les traductions et le changement de
langue à la volée.

## 9.

Tests

- Unit tests :
  utiliser mockito pour les mocks
- Widget tests :
  tester les widgets isolément
- Integration tests
  : tester les flux complets de l'application

## 10.

CI/CD : Codemagic ou Fastlane

Mettre en place un
pipeline CI/CD pour automatiser les tests, le build et le déploiement.

## 11.

Gestion des assets : flutter_gen

Utiliser flutter_gen
pour générer des classes type-safe pour les assets, réduisant les erreurs liées
aux chemins de fichiers.

## 12.

Logging : logger

Implémenter logger
pour un logging structuré et facile à filtrer.

## 13.

Analytics : Firebase Analytics

Intégrer Firebase
Analytics pour suivre l'utilisation de l'application et les comportements des
utilisateurs.

## 14.

Performance Monitoring : Firebase Performance

Utiliser Firebase
Performance pour surveiller les performances de l'application en production.

## 15.

Gestion des formulaires : reactive_forms

Implémenter
reactive_forms pour une gestion efficace et réactive des formulaires complexes.

## 16.

Animations : rive

Utiliser rive pour
des animations fluides et légères, particulièrement utiles pour la gamification
et l'engagement utilisateur.

## 17.

Réalité augmentée : arkit_plugin (iOS) et arcore_flutter_plugin (Android)

Intégrer ces plugins
pour la fonctionnalité d'essai virtuel de tatouages.

## 18.

Paiements : stripe_flutter

Utiliser
stripe_flutter pour gérer les paiements de manière sécurisée.

Cette architecture
fournit une base solide, modulaire et évolutive pour le projet "Tatoo
Connect". Elle favorise la séparation des préoccupations, la testabilité
et la maintenabilité du code. L'utilisation de packages modernes et bien
maintenus garantit que l'application reste à jour avec les meilleures pratiques
de développement Flutter.

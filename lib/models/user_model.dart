import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/models/enums/app_theme.dart';
import 'package:tattoo_social_app/models/enums/gender_type.dart';
import 'package:tattoo_social_app/models/enums/user_type.dart';
import 'package:tattoo_social_app/models/event_model.dart';
import 'package:tattoo_social_app/models/product_model.dart';
import 'package:tattoo_social_app/models/social_media_link_model.dart';
import 'package:tattoo_social_app/providers/user_provider.dart';

import 'enums/subscription_type.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final UserType userType;
  final String? profileImageUrl;
  final String? bio;
  final List<String>? specialties;
  final Map<String, dynamic>? additionalInfo;
  final Gender? gender;
  final String? phoneNumber;
  final String? postalAddress;
  final String? city;
  final String? country;
  final String language;
  final AppTheme theme;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime signedUpAt;
  final SubscriptionType subscriptionType;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final bool isTrialPeriod;
  final List<String> postIds; // Ajoutez cette ligne

  final String? portfolioUrl; // For TattooArtist

  final List<EventModel>? organizedEvents; // For EventOrganizer
  final String? companyName; // For EventOrganizer or Supplier

  final List<ProductModel>? products; // For Supplier
  final String? websiteUrl; // For Supplier

  final String? instagramUrl;
  final String? facebookUrl;
  final String? tiktokUrl;

  final List<SocialMediaLink>? socialMediaLinks;

  final List<String> following; // List of user IDs the user follows
  final List<String> followers; // List of user IDs the user is following

  // final UserProvider userProvider; // Injected UserProvider

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.userType,
    this.profileImageUrl,
    this.bio,
    this.specialties,
    this.additionalInfo,
    this.gender,
    this.phoneNumber,
    this.postalAddress,
    this.city,
    this.country,
    this.language = 'en',
    this.theme = AppTheme.system,
    this.isOnline = false,
    DateTime? lastSeen,
    DateTime? signedUpAt,
    SubscriptionType? subscriptionType,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.isTrialPeriod = false,
    this.postIds = const [],
    this.portfolioUrl,
    this.organizedEvents,
    this.companyName,
    this.products,
    this.websiteUrl,
    this.instagramUrl,
    this.facebookUrl,
    this.tiktokUrl,
    this.socialMediaLinks,
    this.following = const [],
    this.followers = const [],
    //required this.userProvider, // Inject UserProvider
  })  : lastSeen = lastSeen ?? DateTime.now(),
        signedUpAt = signedUpAt ?? DateTime.now(),
        subscriptionType = subscriptionType ??
            (userType == UserType.client
                ? SubscriptionType.free
                : SubscriptionType.basic);

  // String get currentUserId => CurrentUserData.initial()!.

  // bool get isCurrentUser => id == currentUserId;

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      userType: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${data['userType']}',
        orElse: () => UserType.client,
      ),
      profileImageUrl: data['profileImageUrl'],
      bio: data['bio'],
      specialties: List<String>.from(data['specialties'] ?? []),
      additionalInfo: data['additionalInfo'],
      gender: data['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.toString() == 'Gender.${data['gender']}',
              orElse: () => Gender.preferNotToSay,
            )
          : null,
      phoneNumber: data['phoneNumber'],
      postalAddress: data['postalAddress'],
      city: data['city'],
      country: data['country'],
      language: data['language'] ?? 'en',
      theme: AppTheme.values.firstWhere(
        (e) => e.toString() == 'AppTheme.${data['theme']}',
        orElse: () => AppTheme.system,
      ),
      isOnline: data['isOnline'] ?? false,
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
      signedUpAt:
          (data['signedUpAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      subscriptionType: SubscriptionType.values.firstWhere(
        (e) => e.toString() == 'SubscriptionType.${data['subscriptionType']}',
        orElse: () => SubscriptionType.free,
      ),
      subscriptionStartDate:
          (data['subscriptionStartDate'] as Timestamp?)?.toDate(),
      subscriptionEndDate:
          (data['subscriptionEndDate'] as Timestamp?)?.toDate(),
      isTrialPeriod: data['isTrialPeriod'] ?? false,
      postIds: List<String>.from(data['postIds'] ?? []),
      portfolioUrl: data['portfolioUrl'],
      organizedEvents: List<EventModel>.from(data['organizedEvents'] ?? []),
      companyName: data['companyName'],
      products: List<ProductModel>.from(data['products'] ?? []),
      websiteUrl: data['websiteUrl'],
      instagramUrl: data['instagramUrl'],
      facebookUrl: data['facebookUrl'],
      tiktokUrl: data['tiktokUrl'],
      socialMediaLinks: data['socialMediaLinks'],
      following: List<String>.from(data['following'] ?? []),
      followers: List<String>.from(data['followers'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'username': username,
      'userType': userType.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'specialties': specialties,
      'additionalInfo': additionalInfo,
      'gender': gender?.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'postalAddress': postalAddress,
      'city': city,
      'country': country,
      'language': language,
      'theme': theme.toString().split('.').last,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'signedUpAt': Timestamp.fromDate(signedUpAt),
      'subscriptionType': subscriptionType.toString().split('.').last,
      'subscriptionStartDate': subscriptionStartDate != null
          ? Timestamp.fromDate(subscriptionStartDate!)
          : null,
      'subscriptionEndDate': subscriptionEndDate != null
          ? Timestamp.fromDate(subscriptionEndDate!)
          : null,
      'isTrialPeriod': isTrialPeriod,
      'postIds': postIds,
      'portfolioUrl': portfolioUrl,
      'organizedEvents': organizedEvents,
      'companyName': companyName,
      'products': products,
      'websiteUrl': websiteUrl,
      'instagramUrl': instagramUrl,
      'facebookUrl': facebookUrl,
      'tiktokUrl': tiktokUrl,
      'socialMediaLinks': socialMediaLinks,
      'following': following,
      'followers': followers,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'userType': userType.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'specialties': specialties,
      'additionalInfo': additionalInfo,
      'gender': gender?.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'postalAddress': postalAddress,
      'city': city,
      'country': country,
      'language': language,
      'theme': theme.toString().split('.').last,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'signedUpAt': Timestamp.fromDate(signedUpAt),
      'subscriptionType': subscriptionType.toString().split('.').last,
      'subscriptionStartDate': subscriptionStartDate != null
          ? Timestamp.fromDate(subscriptionStartDate!)
          : null,
      'subscriptionEndDate': subscriptionEndDate != null
          ? Timestamp.fromDate(subscriptionEndDate!)
          : null,
      'isTrialPeriod': isTrialPeriod,
      'postIds': postIds,
      'portfolioUrl': portfolioUrl,
      'organizedEvents': organizedEvents,
      'companyName': companyName,
      'products': products,
      'websiteUrl': websiteUrl,
      'instagramUrl': instagramUrl,
      'facebookUrl': facebookUrl,
      'tiktokUrl': tiktokUrl,
      'socialMediaLinks': socialMediaLinks,
      'following': following,
      'followers': followers,
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
    UserProvider userProvider,
  ) {
    List<SocialMediaLink>? socialMediaLinks;
    if (map['socialMediaLinks'] is List) {
      socialMediaLinks = (map['socialMediaLinks'] as List)
          .map((linkData) => SocialMediaLink(
                platform: linkData['platform'] as String,
                url: linkData['url'] as String,
              ))
          .toList();
    }

    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.toString().split('.').last == map['userType'],
        orElse: () => UserType.client,
      ),
      profileImageUrl: map['profileImageUrl'] as String?,
      bio: map['bio'] as String?,
      specialties: List<String>.from(map['specialties'] ?? []),
      additionalInfo: map['additionalInfo'] as Map<String, dynamic>?,
      gender: Gender.values.firstWhere(
        (e) => e.toString().split('.').last == map['gender'],
        orElse: () => Gender.preferNotToSay,
      ),
      phoneNumber: map['phoneNumber'] as String?,
      postalAddress: map['postalAddress'] as String?,
      city: map['city'] as String?,
      country: map['country'] as String?,
      language: map['language'] as String ?? 'en',
      theme: AppTheme.values.firstWhere(
        (e) => e.toString().split('.').last == map['theme'],
        orElse: () => AppTheme.system,
      ),
      isOnline: map['isOnline'] as bool,
      lastSeen: (map['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
      signedUpAt: (map['signedUpAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      subscriptionType: SubscriptionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['subscriptionType'],
        orElse: () => SubscriptionType.free,
      ),
      subscriptionStartDate:
          (map['subscriptionStartDate'] as Timestamp?)?.toDate(),
      subscriptionEndDate: (map['subscriptionEndDate'] as Timestamp?)?.toDate(),
      isTrialPeriod: map['isTrialPeriod'] as bool,
      postIds: List<String>.from(map['postIds'] ?? []),
      portfolioUrl: map['portfolioUrl'] as String?,
      organizedEvents: List<EventModel>.from(map['organizedEvents'] ?? []),
      companyName: map['companyName'] as String?,
      products: List<ProductModel>.from(map['products'] ?? []),
      websiteUrl: map['websiteUrl'] as String?,
      socialMediaLinks: socialMediaLinks,
      following: List<String>.from(map['following'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
      //   userProvider: userProvider,
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    UserType? userType,
    String? profileImageUrl,
    String? bio,
    List<String>? specialties,
    Map<String, dynamic>? additionalInfo,
    Gender? gender,
    String? phoneNumber,
    String? postalAddress,
    String? city,
    String? country,
    String? language,
    AppTheme? theme,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? signedUpAt,
    SubscriptionType? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    bool? isTrialPeriod,
    List<String>? postIds,
    String? portfolioUrl,
    List<EventModel>? organizedEvents,
    String? companyName,
    List<ProductModel>? products,
    String? websiteUrl,
    Map<String, String>? socialMediaLinks, // Update the parameter
    List<String>? following,
    List<String>? followers,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      userType: userType ?? this.userType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      specialties: specialties ?? this.specialties,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalAddress: postalAddress ?? this.postalAddress,
      city: city ?? this.city,
      country: country ?? this.country,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      signedUpAt: signedUpAt ?? this.signedUpAt,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      isTrialPeriod: isTrialPeriod ?? this.isTrialPeriod,
      postIds: postIds ?? this.postIds,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      organizedEvents: organizedEvents ?? this.organizedEvents,
      companyName: companyName ?? this.companyName,
      products: products ?? this.products,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      socialMediaLinks: socialMediaLinks != null
          ? socialMediaLinks
              .cast<String, String>() // Cast to the desired types
              .entries // Use entries instead of toList()
              .map((entry) => SocialMediaLink.fromMapEntry(MapEntry(
                  entry.key, entry.value))) // Convert to SocialMediaLink
              .toList()
          : this.socialMediaLinks,
      following: following ?? this.following, // Update the assignment
      followers: followers ?? this.followers, // Update the assignment
      //   userProvider: userProvider,
    );
  }

  bool get isPremium => subscriptionType != SubscriptionType.free;

  bool get isSubscriptionActive {
    if (subscriptionType == SubscriptionType.free) return true;
    final now = DateTime.now();
    return subscriptionEndDate != null && subscriptionEndDate!.isAfter(now);
  }

  bool canAccessFeature(String featureName) {
    switch (featureName) {
      case 'basicFeature':
        return isPremium;
      case 'advancedFeature':
        return subscriptionType == SubscriptionType.premium ||
            subscriptionType == SubscriptionType.professional;
      default:
        return false;
    }
  }

  int getRemainingDays() {
    if (subscriptionType == SubscriptionType.free) return -1;
    final now = DateTime.now();
    return subscriptionEndDate != null
        ? subscriptionEndDate!.difference(now).inDays
        : 0;
  }

//   // Follow a user
//   void followUser(String currentUserId, String userIdToFollow) {
//     final userIndex = users.indexWhere((user) => user.id == currentUserId);
//     if (userIndex != -1) {
//       users[userIndex] = users[userIndex]
//           .copyWith(following: [...users[userIndex].following, userIdToFollow]);
//     }
//     // Update UI and potentially update data source (e.g., database)
//   }

// // Unfollow a user
//   void unfollowUser(String currentUserId, String userIdToUnfollow) {
//     final userIndex = users.indexWhere((user) => user.id == currentUserId);
//     if (userIndex != -1) {
//       users[userIndex] = users[userIndex].copyWith(
//           following: users[userIndex]
//               .following
//               .where((id) => id != userIdToUnfollow)
//               .toList());
//     }
//     // Update UI and potentially update data source (e.g., database)
//   }
}

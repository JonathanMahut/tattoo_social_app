import 'package:cloud_firestore/cloud_firestore.dart';

import 'subscription_type.dart';

enum UserType { tattooArtist, client, eventOrganizer, supplier }

enum Gender { male, female, other, preferNotToSay }

enum AppTheme { light, dark, system }

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
  })  : this.lastSeen = lastSeen ?? DateTime.now(),
        this.signedUpAt = signedUpAt ?? DateTime.now(),
        this.subscriptionType = subscriptionType ??
            (userType == UserType.client
                ? SubscriptionType.free
                : SubscriptionType.basic);

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
    };
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
}

import 'package:flutter/foundation.dart';
import 'package:tattoo_social_app/data/current_user_data.dart';
import 'package:tattoo_social_app/models/enums/app_theme.dart';
import 'package:tattoo_social_app/models/enums/gender_type.dart';
import 'package:tattoo_social_app/models/enums/subscription_type.dart';
import 'package:tattoo_social_app/models/event_model.dart';
import 'package:tattoo_social_app/models/product_model.dart';

class CurrentUserDataProvider extends ChangeNotifier {
  CurrentUserData? _currentUser;

  CurrentUserData? get currentUser => _currentUser;

  set currentUser(CurrentUserData? value) {
    _currentUser = value;
    notifyListeners(); // Notify listeners when current user changes
  }

  void updateUserData({
    String? email,
    String? username,
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
    Map<String, String>? socialMediaLinks, // Explicit type definition
    List<String>? following,
    List<String>? followers,
  }) {
    _currentUser = _currentUser?.copyWith(
      email: email ?? _currentUser?.email,
      username: username ?? _currentUser?.username,
      profileImageUrl: profileImageUrl ?? _currentUser?.profileImageUrl,
      bio: bio ?? _currentUser?.bio,
      specialties: specialties ?? _currentUser?.specialties,
      additionalInfo: additionalInfo ?? _currentUser?.additionalInfo,
      gender: gender ?? _currentUser?.gender,
      phoneNumber: phoneNumber ?? _currentUser?.phoneNumber,
      postalAddress: postalAddress ?? _currentUser?.postalAddress,
      city: city ?? _currentUser?.city,
      country: country ?? _currentUser?.country,
      language: language ?? _currentUser?.language,
      theme: theme ?? _currentUser?.theme,
      isOnline: isOnline ?? _currentUser?.isOnline,
      lastSeen: lastSeen ?? _currentUser?.lastSeen,
      signedUpAt: signedUpAt ?? _currentUser?.signedUpAt,
      subscriptionType: subscriptionType ?? _currentUser?.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? _currentUser?.subscriptionStartDate,
      subscriptionEndDate:
          subscriptionEndDate ?? _currentUser?.subscriptionEndDate,
      isTrialPeriod: isTrialPeriod ?? _currentUser?.isTrialPeriod,
      postIds: postIds ?? _currentUser?.postIds,
      portfolioUrl: portfolioUrl ?? _currentUser?.portfolioUrl,
      organizedEvents: organizedEvents ?? _currentUser?.organizedEvents,
      companyName: companyName ?? _currentUser?.companyName,
      products: products ?? _currentUser?.products,
      websiteUrl: websiteUrl ?? _currentUser?.websiteUrl,
      socialMediaLinks: socialMediaLinks != null // Null check before casting
          ? socialMediaLinks.cast<String, String>() // Explicit casting
          : _currentUser?.socialMediaLinks,
      following: following ?? _currentUser?.following,
      followers: followers ?? _currentUser?.followers,
    );
    notifyListeners(); // Notify listeners when user data is updated
  }

  // ... other methods (optional)
}

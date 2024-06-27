import 'package:flutter/material.dart';
import 'package:tattoo_social_app/core/utils/firebase.dart';
import 'package:tattoo_social_app/data/models/user_model.dart';
import 'package:tattoo_social_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  final UserService _userService;
  final FirebaseUtil firebaseUtil; // Inject FirebaseUtil

  UserProvider(
      this._userService, this.firebaseUtil); // Add firebaseUtil parameter

  UserService get userService {
    return _userService; // No need to create UserService here, it's injected
  }

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> refreshUser() async {
    if (_currentUser != null) {
      try {
        final updatedUser = await userService
            .getCurrentUser(); // Access UserService through getter
        if (updatedUser != null) {
          setUser(updatedUser);
        }
      } catch (e) {
        print('Error refreshing user: $e');
        // You might want to handle this error, perhaps by showing a message to the user
      }
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await userService
          .updateUser(updatedUser); // Access UserService through getter
      setUser(updatedUser);
    } catch (e) {
      print('Error updating user: $e');
      // Handle the error appropriately
    }
  }

  // ... other methods that might use userService (if any)
}

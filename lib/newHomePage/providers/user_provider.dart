// A StateNotifier to handle User's state
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freiightflow/newHomePage/models/user_model.dart';
import 'package:freiightflow/newHomePage/services/api_service.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<void> loadUser(String token) async {
    try {
      final user = await ApiService.fetchUserInfo(token);
      state = user;
    } catch (e) {
      // Handle error if needed
      state = null;
    }
  }

  void logout() {
    state = null;
  }
}

// Provider for accessing user across the app
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
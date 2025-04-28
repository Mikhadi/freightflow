import 'package:freiightflow/newHomePage/models/user_model.dart';

class ApiService {

  static Future<User> fetchUserInfo(String token) async {
    await Future.delayed(const Duration(seconds: 1));

    // Return fake user based on token (or just fixed user)
    return User(
      name: 'Mikhail Diyachkov',
      email: 'john.doe@example.com',
      authToken: token,
      isAdmin: true, // or false
    );

  }
}
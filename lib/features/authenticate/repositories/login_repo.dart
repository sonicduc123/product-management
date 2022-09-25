import 'package:firebase_auth/firebase_auth.dart';
import 'package:management_product/features/authenticate/services/login_service.dart';

class LoginRepository {
  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) =>
      LoginService.loginUsingEmailPassword(email: email, password: password);
}

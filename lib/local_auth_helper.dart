import 'local_auth_enum.dart';

class LocalAuthHelper {
  static AuthStatus select(String status) {
    return AuthStatus.values.firstWhere((element) => element.name == status);
  }
}

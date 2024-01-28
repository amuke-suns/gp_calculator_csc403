import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {

  Future<String> getCGPAPassword();

  Future<void> setCGPAPassword(String password);
}

// this is the implementation
class StorageServiceImpl extends StorageService {

  final String keyPassword = 'cgpa_password';

  @override
  Future<String> getCGPAPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPassword) ?? 'password';
  }

  @override
  Future<void> setCGPAPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPassword, password);
  }
}
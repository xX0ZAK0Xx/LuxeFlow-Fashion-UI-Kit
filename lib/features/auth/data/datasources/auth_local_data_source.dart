import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getLastUser();
  Future<void> cacheUser(UserModel user);
  Future<UserModel> login(String email, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUser(UserModel user) async {
    // Mock caching
  }

  @override
  Future<UserModel> getLastUser() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    // Mock login with hardcoded user
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    if (email == 'user@luxeflow.com' && password == 'password') {
      return const UserModel(
        id: '1',
        email: 'user@luxeflow.com',
        name: 'Luxe User',
      );
    } else {
      throw Exception('Invalid Credentials');
    }
  }
}

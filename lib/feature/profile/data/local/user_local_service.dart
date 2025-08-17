import '../../../../core/Hive/hive_service.dart';
import '../model/user_response.dart';

class UserLocalService extends HiveService<UserModel> {
  UserLocalService();

  @override
  String get boxName => 'userBox';

  Future<void> saveUser(UserModel user) async {
    await put('user', user);
  }

  UserModel? getUser() {
    return get('user');
  }

  Future<void> deleteUser() async {
    await clear();
  }
}

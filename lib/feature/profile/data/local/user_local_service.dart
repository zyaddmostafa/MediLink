import '../../../../core/hive/hive_service.dart';
import '../model/user_response.dart';

class UserLocalService extends HiveService<UserInformation> {
  UserLocalService();

  @override
  String get boxName => 'userBox';

  Future<void> saveUser(UserInformation user) async {
    await put('user', user);
  }

  Stream<UserInformation?> getUser() async* {
    yield get('user');
  }

  Future<void> deleteUser() async {
    await clear();
  }
}

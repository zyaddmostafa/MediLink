import '../../../../core/hive/hive_service.dart';
import '../model/notification_model.dart';

class NotificationLocalService extends HiveService<NotificationModel> {
  @override
  String get boxName => 'notifications';

  Future<void> addNotification(NotificationModel notification) async {
    await add(notification);
  }

  Future<void> clearNotifications() async {
    await clear();
  }

  Stream<List<NotificationModel>> getNotifications() async* {
    yield* getAllStream();
  }

  int getListCount() {
    return length;
  }
}

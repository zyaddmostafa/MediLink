import 'package:flutter/material.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/no_result_widget.dart';
import '../../data/local/notification_local_service.dart';
import '../../data/model/notification_model.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomAppBar(
                appBarwidget: Text(
                  'Notifications',
                  style: AppTextStyles.font16Bold,
                ),
              ),
            ),
            verticalSpacing(32),
            _notificationStreamBuilder(),
          ],
        ),
      ),
    );
  }

  Expanded _notificationStreamBuilder() {
    return Expanded(
      child: StreamBuilder<List<NotificationModel>>(
        stream: getIt<NotificationLocalService>().getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching notifications'));
          }
          final notifications = snapshot.data?.reversed.toList() ?? [];
          if (notifications.isEmpty) {
            return const NoResultWidget(message: 'No notifications Found');
          } else {
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NotificationItem(notification: notification),
                );
              },
            );
          }
        },
      ),
    );
  }
}

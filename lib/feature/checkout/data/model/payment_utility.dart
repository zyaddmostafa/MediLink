import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_dioalog.dart';

class PaymentUtility {
  /// Execute an action with loading dialog and error handling
  static Future<void> executeWithLoading({
    required BuildContext context,
    required String loadingMessage,
    required Future<void> Function() action,
    required String errorTitle,
    required String errorMessage,
  }) async {
    bool loadingShown = false;

    try {
      CustomDialog.showLoadingDialog(context: context, message: loadingMessage);
      loadingShown = true;

      await action();

      if (context.mounted && loadingShown) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted && loadingShown) {
        Navigator.pop(context);
      }

      if (context.mounted) {
        await CustomDialog.showErrorDialog(
          context: context,
          title: errorTitle,
          message: '$errorMessage: ${e.toString()}',
          buttonText: 'Try Again',
        );
      }
      rethrow;
    }
  }

  /// Show a generic payment error dialog
  static Future<void> showPaymentError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) async {
    await CustomDialog.showErrorDialog(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
    );
  }
}

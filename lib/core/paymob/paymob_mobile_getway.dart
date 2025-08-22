import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/booking/data/model/store_appointment_request.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import '../helpers/doctors_helper.dart';

class PaymobMobileGetway extends StatefulWidget {
  final String webUri;
  final String walletType;
  final AppointmentDetailsModel appointmentDetails;

  const PaymobMobileGetway({
    super.key,
    required this.webUri,
    required this.walletType,
    required this.appointmentDetails,
  });

  @override
  State<PaymobMobileGetway> createState() => _PaymobMobileGetwayState();
}

class _PaymobMobileGetwayState extends State<PaymobMobileGetway> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getWalletDisplayName()} Payment'),
        backgroundColor: _getWalletColor(),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [_buildWebView(), if (_isLoading) _buildLoadingOverlay()],
      ),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.webUri)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          clearCache: true,
          cacheEnabled: false,
        ),
      ),

      onLoadStart: _onLoadStart,
      onLoadStop: _onLoadStop,
      onLoadError: _onLoadError,
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(_getWalletColor()),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading ${_getWalletDisplayName()} Payment...',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoadStart(InAppWebViewController controller, WebUri? url) {
    setState(() => _isLoading = true);
    log('Loading: ${url.toString()}');
  }

  void _onLoadStop(InAppWebViewController controller, WebUri? url) {
    setState(() => _isLoading = false);
    if (url != null) {
      _checkPaymentResult(url.toString());
    }
  }

  void _onLoadError(
    InAppWebViewController controller,
    Uri? url,
    int code,
    String message,
  ) {
    setState(() => _isLoading = false);
    log('Error: $code - $message');
    _returnResult('error', 'Payment failed to load');
  }

  void _checkPaymentResult(String url) {
    log('Checking URL: $url');

    if (url.contains('success') || url.contains('approved')) {
      log('Payment successful, storing appointment...');
      _storeAppointmentAndReturn(context);
      _returnResult('success', 'Payment successful');
    } else if (url.contains('failed') || url.contains('cancelled')) {
      _returnResult('failed', 'Payment failed or cancelled');
    } else if (url.contains('post_pay')) {
      final uri = Uri.parse(url);
      final success = uri.queryParameters['success'] == 'true';
      if (success) {
        log('Payment successful, storing appointment...');
        _storeAppointmentAndReturn(context);
        _returnResult('success', 'Payment successful');
      } else {
        _returnResult('failed', 'Payment failed');
      }
    }
  }

  void _storeAppointmentAndReturn(BuildContext context) {
    try {
      final cubit = context.read<BookingAppointmentCubit>();
      final request = StoreAppointmentRequest(
        doctorId: widget.appointmentDetails.doctorId.toString(),
        appointmentDateAndTime: DoctorsHelpers.storeAppointmentStartDate(
          widget.appointmentDetails.appointmentDate,
          widget.appointmentDetails.appointmentTime,
        ),
        message: widget.appointmentDetails.message ?? '',
      );

      log('PaymobMobileGetway - Storing appointment...');
      // Store the appointment - BlocListener will handle the result and pop
      cubit.storeAppointment(request);
    } catch (e) {
      log('Error storing appointment: $e');
      if (mounted) {
        _returnResult('error', 'Failed to book appointment');
      }
    }
  }

  void _returnResult(String status, String message) {
    if (mounted) {
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pop(context, {
          'status': status,
          'message': message,
          'walletType': widget.walletType,
        });
      });
    }
  }

  String _getWalletDisplayName() {
    switch (widget.walletType.toLowerCase()) {
      case 'vodafone':
        return 'Vodafone Cash';
      case 'etisalat':
        return 'Etisalat Cash';
      case 'orange':
        return 'Orange Cash';
      default:
        return 'Mobile Wallet';
    }
  }

  Color _getWalletColor() {
    switch (widget.walletType.toLowerCase()) {
      case 'vodafone':
        return const Color(0xFFE60000);
      case 'etisalat':
        return const Color(0xFF00B140);
      case 'orange':
        return const Color(0xFFFF6600);
      default:
        return Colors.blue;
    }
  }
}

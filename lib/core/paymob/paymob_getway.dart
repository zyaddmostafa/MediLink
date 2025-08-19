import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/booking/data/model/store_appointment_request.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import 'paymob_constants.dart';

class PaymobGetway extends StatefulWidget {
  final String paymentToken;
  final AppointmentDetailsModel appointmentDetails;

  const PaymobGetway({
    super.key,
    required this.paymentToken,
    required this.appointmentDetails,
  });

  @override
  State<PaymobGetway> createState() => _PaymobGetwayState();
}

class _PaymobGetwayState extends State<PaymobGetway> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Stack(
        children: [
          InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                clearCache: true,
                cacheEnabled: false,
              ),
            ),
            initialUrlRequest: URLRequest(
              url: WebUri(
                '${Constants.baseUrl}/api/acceptance/iframes/918185?payment_token=${widget.paymentToken}',
              ),
            ),
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });

              if (url != null) {
                final urlString = url.toString();

                if (urlString.contains('post_pay')) {
                  final uri = Uri.parse(urlString);
                  final success = uri.queryParameters['success'];

                  if (success == 'true') {
                    log('Payment successful, storing appointment...');
                    _storeAppointment(context);
                  } else {
                    log('Payment failed');
                    _returnResult('failed', 'Payment failed');
                  }
                }
              }
            },
            onRenderProcessGone: (controller, detail) {
              log('WebView crashed');
              Navigator.pop(context, {
                'status': 'error',
                'message': 'Payment page crashed',
              });
            },
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  void _storeAppointment(BuildContext context) {
    final cubit = context.read<BookingAppointmentCubit>();
    final request = StoreAppointmentRequest(
      doctorId: widget.appointmentDetails.doctorId.toString(),
      appointmentDateAndTime:
          '${widget.appointmentDetails.appointmentDate} ${widget.appointmentDetails.appointmentTime}',
      message: widget.appointmentDetails.message ?? '',
    );

    cubit.storeAppointment(request);
  }

  void _returnResult(String status, String message) {
    if (mounted) {
      Navigator.pop(context, {'status': status, 'message': message});
    }
  }
}

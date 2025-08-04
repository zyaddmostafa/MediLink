import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'paymob_constants.dart';

class PaymobGetway extends StatefulWidget {
  final String paymentToken;
  const PaymobGetway({super.key, required this.paymentToken});

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
                    Navigator.pop(context, {'status': 'success'});
                    log('Payment successful');
                  } else {
                    Navigator.pop(context, {'status': 'failed'});
                    log('Payment failed');
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
}

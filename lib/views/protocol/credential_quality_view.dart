import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CredentialQualityView extends StatelessWidget {
  const CredentialQualityView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '证照资质',
      content: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(
            Uri.parse('https://cdn.icaiwa.com/protocols/credential.html'),
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                EasyLoading.show();
              },
              onPageFinished: (url) {
                Future.delayed(const Duration(milliseconds: 250), () {
                  EasyLoading.dismiss();
                });
              },
            ),
          ),
      ),
    );
  }
}

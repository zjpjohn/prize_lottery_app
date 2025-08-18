import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BeiAnMiitView extends StatelessWidget {
  const BeiAnMiitView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: 'ICP/域名备案',
      content: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://beian.miit.gov.cn'))
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

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManualBookView extends StatelessWidget {
  const ManualBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '使用手册',
      content: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
              Uri.parse('https://cdn.icaiwa.com/app/manual/manual_book.html'))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                EasyLoading.show();
              },
              onPageFinished: (url) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  EasyLoading.dismiss();
                });
              },
            ),
          ),
      ),
    );
  }
}

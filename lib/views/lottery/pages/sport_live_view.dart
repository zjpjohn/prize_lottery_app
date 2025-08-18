import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/utils/open_video_utils.dart';
import 'package:prize_lottery_app/views/lottery/widgets/rotate_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SportLiveView extends StatefulWidget {
  const SportLiveView({super.key});

  @override
  State<SportLiveView> createState() => _SportLiveViewState();
}

class _SportLiveViewState extends State<SportLiveView> {
  ///
  ///
  late WebViewController _controller;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '开奖直播',
      border: false,
      right: GestureDetector(
        onTap: () {
          _controller.reload();
          (_key.currentState as RotateWidgetState).rotate();
        },
        child: Container(
          width: 46.w,
          height: 32.w,
          alignment: Alignment.centerRight,
          child: RotateWidget(
            key: _key,
            duration: const Duration(milliseconds: 1000),
            child: Icon(
              const IconData(0xe67a, fontFamily: 'iconfont'),
              size: 20.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
      content: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(OpenVideoUtils.sportLiveUri))
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
      );
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }
}

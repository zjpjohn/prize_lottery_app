import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/views/user/model/sign_info.dart';
import 'package:prize_lottery_app/views/user/repository/checkin_repository.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';
import 'package:prize_lottery_app/widgets/flip_card.dart';

class UserSignController extends AbsRequestController {
  ///
  ///
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  ///
  /// 签到信息
  late SignInfo signInfo;

  ///分页页码
  int page = 1;

  ///每页数据量
  int limit = 12;

  ///签到日志集合
  List<SignLog> logs = [];

  ///是否正在签到
  bool signing = false;

  ///
  /// 兑换积分
  void exchangeCoupon() {
    ExchangeRule rule = signInfo.rule;
    if (!BalanceInstance().balance!.canExchange(rule.throttle)) {
      EasyLoading.showToast('积分余额不足');
      return;
    }
    UserInfoRepository.couponExchange().then((value) {
      signInfo.coupon = value.remain;
      BalanceInstance().exchangeCoupon(
        surplus: value.surplus,
        coupon: value.coupon,
      );
      EasyLoading.show(
        dismissOnTap: true,
        indicator: Column(
          children: [
            Text(
              '赚取${value.surplus}金币',
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: Text(
                '消耗${-1 * value.coupon}积分',
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
              ),
            ),
          ],
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), () {
        EasyLoading.dismiss();
      });
      update();
    }).catchError((error) {
      EasyLoading.showToast(error.error.message);
    });
  }

  ///
  /// 签到操作
  void signAction({required Function success}) {
    if (signing) {
      EasyLoading.showToast('正在签到...');
      return;
    }
    signing = true;
    update();
    CheckInRepository.userSign().then((value) {
      ///签到信息更新
      signInfo.current = value.current;
      signInfo.lastDate = value.lastDate;
      signInfo.times = value.times;
      signInfo.hasSeries = value.series;
      signInfo.hasSigned = 1;

      ///增减余额账户的签到积分
      BalanceInstance().incrCoupon = value.log.award;

      ///签到日志追加
      logs = [value.log, ...logs];

      ///截取前10条日志
      logs = logs.sublist(0, logs.length > limit ? limit : logs.length);

      ///签到成功回调
      success();
    }).catchError((error) {
      EasyLoading.showToast('签到失败');
    }).whenComplete(() {
      signing = false;
      update();
    });
  }

  @override
  Future<void> request() async {
    Future<void> balanceAsync = BalanceInstance().refreshIfNull();
    Future<void> signAsync = CheckInRepository.querySignInfo().then((value) {
      signInfo = value;
    });
    Future<void> logsAsync =
        CheckInRepository.querySignLogs({'page': page, 'limit': limit})
            .then((value) {
      logs
        ..clear()
        ..addAll(value.records);
    });
    Future.wait([balanceAsync, signAsync, logsAsync]).then((values) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(signInfo);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

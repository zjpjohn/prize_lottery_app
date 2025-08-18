import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';
import 'package:prize_lottery_app/views/user/repository/voucher_repository.dart';

class DrawVoucherController extends AbsRequestController {
  ///
  /// 可领取代金券集合
  List<VoucherInfo> vouchers = [];

  ///
  /// 最新用户领券信息
  List<UserDraw> drawList = [
    UserDraw.fromJson({
      'name': '幸运星DvhwS',
      'avatar': '',
      'bizNo': '',
      'voucher': 5,
      'timestamp': '',
    }),
    UserDraw.fromJson({
      'name': '幸运星XLWaN',
      'avatar': '',
      'bizNo': '',
      'voucher': 15,
      'timestamp': '',
    }),
    UserDraw.fromJson({
      'name': '幸运星MTm77',
      'avatar': '',
      'bizNo': '',
      'voucher': 10,
      'timestamp': '',
    }),
    UserDraw.fromJson({
      'name': '幸运星vAdUR',
      'avatar': '',
      'bizNo': '',
      'voucher': 8,
      'timestamp': '',
    }),
  ];

  ///
  /// 是否正在领取
  bool drawing = false;

  ///
  /// 领取单张代金券
  void drawVoucher(VoucherInfo voucher) {
    if (!voucher.canDraw) {
      EasyLoading.showToast('代金券不可领取');
      return;
    }
    if (drawing) {
      EasyLoading.showToast('正在领取...');
      return;
    }
    drawing = true;
    EasyLoading.show(status: '正在领取');
    VoucherRepository.drawVoucher(voucher.seqNo).then((value) {
      EasyLoading.showToast('领取成功');
      if (value.disposable == 1) {
        //一次性代金券领取成功后删除
        vouchers.removeWhere((e) => e.seqNo == value.seqNo);
      } else {
        //可重复领取代金券领取成功后更新下一次领取时间
        voucher.canDraw = false;
        voucher.nextDraw = value.nextTime;
      }
      update();
    }).catchError((error) {
      EasyLoading.showToast('领取失败');
    }).whenComplete(() {
      drawing = false;
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 批量领取代金券
  void drawBatchVoucher() {
    List<String> seqNos =
        vouchers.where((e) => e.canDraw).map((e) => e.seqNo).toList();
    if (seqNos.isEmpty) {
      EasyLoading.showToast('无可领取代金券');
      return;
    }
    if (drawing) {
      EasyLoading.showToast('正在领取');
      return;
    }
    drawing = true;
    EasyLoading.show(status: '正在领取');
    VoucherRepository.drawBatch(seqNos).then((value) {
      EasyLoading.showToast('领取成功');
      var map = {for (var e in vouchers) e.seqNo: e};
      for (var e in value) {
        VoucherInfo? voucher = map[e.seqNo];
        if (voucher?.disposable == 0) {
          voucher?.canDraw = false;
          voucher?.nextDraw = e.nextTime;
        } else {
          vouchers.removeWhere((v) => v.seqNo == e.seqNo);
        }
      }
      update();
    }).catchError((error) {
      EasyLoading.showToast('领取失败');
    }).whenComplete(() {
      drawing = false;
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  bool isCanBatch() {
    for (var voucher in vouchers) {
      if (voucher.canDraw) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait([
      VoucherRepository.voucherList().then((value) => vouchers.addAll(value)),
      VoucherRepository.userDrawList().then((value) {
        if (value.length <= 5) {
          drawList.addAll(value);
          return;
        }
        drawList
          ..clear()
          ..addAll(value);
      }),
    ]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

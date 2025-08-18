import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';
import 'package:prize_lottery_app/views/user/repository/member_repository.dart';

class UserMemberController extends AbsRequestController {
  /// 会员套餐集合
  List<MemberPackage> packList = [];

  /// 会员特权集合
  List<MemberPrivilege> privileges = [];

  /// 当前选择会员套餐
  MemberPackage? _memberPack;

  /// 是否同意会员协议
  bool _agree = true;

  MemberPackage? get memberPack => _memberPack;

  set memberPack(MemberPackage? value) {
    _memberPack = value;
    update();
  }

  bool get agree => _agree;

  set agree(bool value) {
    _agree = value;
    update();
  }

  ///
  /// 显示支付页面
  void showPayChannel({required Function showDialog}) {
    if (!agree) {
      EasyLoading.showToast('请同意服务协议');
      return;
    }

    ///显示支付渠道
    showDialog();
  }

  @override
  Future<void> request() async {
    showLoading();

    /// 会员套餐集合
    Future<void> packageAsync = MemberRepository.memberPackage().then((value) {
      packList = value;

      ///设置默认
      setDefaultPackage();
    });

    /// 会员特权集合
    Future<void> privilegeAsync =
        MemberRepository.memberPrivileges().then((value) {
      privileges = value;
    });

    ///刷新会员信息
    MemberStore().refreshMember();

    ///请求加载套餐信息
    Future.wait([packageAsync, privilegeAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(packList);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  void setDefaultPackage() {
    if (packList.isEmpty) {
      return;
    }
    _memberPack =
        packList.firstWhere((e) => e.priority == 1, orElse: () => packList[0]);
  }
}

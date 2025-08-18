import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/store/resource.dart';

///
/// 常量工具类
///
class Constants {
  ///
  ///
  static shareBottomSheet({
    required Widget content,
    Function? save,
    Function? shareWechat,
    Function? shareMoments,
    Function? copyLink,
  }) {
    Get.bottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          content,
          Container(
            height: 166.w,
            margin: EdgeInsets.only(top: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.w),
                topRight: Radius.circular(8.w),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () {
                          if (save != null) {
                            save();
                          }
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.downloadIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '保存图片',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (shareWechat == null) {
                            EasyLoading.showToast('暂未开通，请耐心等待');
                            return;
                          }
                          shareWechat();
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.wechatIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '微  信',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (shareMoments == null) {
                            EasyLoading.showToast('暂未开通，请耐心等待');
                            return;
                          }
                          shareMoments();
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.momentsIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '朋友圈',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (copyLink != null)
                        GestureDetector(
                          onTap: () {
                            copyLink();
                          },
                          child: SizedBox(
                            width: 66.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.w),
                                  margin: EdgeInsets.only(bottom: 6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: Image.asset(
                                    R.linkIcon,
                                    height: 34.w,
                                  ),
                                ),
                                Text(
                                  '复制链接',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 52.w,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      '取 消',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 350),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
    );
  }

  ///
  ///bottom sheet
  static bottomSheet(
    Widget child, {
    bool isDismissible = true,
    bool isScrollControlled = false,
    bool enableDrag = true,
  }) {
    Get.bottomSheet(
      child,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enterBottomSheetDuration: const Duration(milliseconds: 400),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
    );
  }

  ///
  /// 竖线
  static Widget verticalLine({
    required double width,
    required double height,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget line = SizedBox(
    height: 0.4.w,
    width: double.infinity,
    child: const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
      ),
    ),
  );

  static String publishTxt({int modified = 0, required String period}) {
    if (modified == 0) {
      return '暂时未发布预测方案';
    }
    return '最新$period期预测方案';
  }

  ///
  /// 彩种中文名称
  static String lottery(String lotto) {
    return lotteryZhCns[lotto]!;
  }

  static String dayWeek(DateTime dateTime) {
    return weeks[dateTime.weekday]!;
  }

  static int lotterySort(String type) {
    return lotterySorts[type] ?? 7;
  }

  ///
  /// 指定日期开奖彩种
  static List<String> dayLotteries(DateTime dateTime) {
    List<String> lotteries = [];
    int week = dateTime.weekday;
    lotteryCalendars.forEach((key, value) {
      if (value.contains(0) || value.contains(week)) {
        lotteries.add(key);
      }
    });
    return lotteries;
  }

  ///
  /// 是否今日开奖
  static bool todayOpen({required String type, required DateTime dateTime}) {
    List<int> calendars = lotteryCalendars[type]!;
    return calendars.contains(0) || calendars.contains(dateTime.weekday);
  }

  static String level(String type, int level) {
    switch (type) {
      case 'fc3d':
        return fc3dLevels[level]!;
      case 'pl3':
        return pl3Levels[level]!;
      case 'ssq':
        return ssqLevels[level]!;
      case 'dlt':
        return dltLevels[level]!;
      case 'qlc':
        return qlcLevels[level]!;
      case 'kl8':
        return kl8Levels[level]!;
    }
    return '';
  }
}

Map<int, String> ranks = {
  1: R.rank1,
  2: R.rank2,
  3: R.rank3,
};

Map<int, String> crowns = {
  1: R.crown1,
  2: R.crown2,
  3: R.crown3,
};

///
/// 彩票开奖日历
Map<String, List<int>> lotteryCalendars = {
  'fc3d': [0],
  'ssq': [2, 4, 7],
  'pl3': [0],
  'pl5': [0],
  'dlt': [1, 3, 6],
  'qlc': [1, 3, 5],
  'kl8': [0],
};

Map<int, String> weeks = {
  1: '周一',
  2: '周二',
  3: '周三',
  4: '周四',
  5: '周五',
  6: '周六',
  7: '周日',
};

Map<String, String> lotteryZhCns = {
  'fc3d': '福彩3D',
  'ssq': '双色球',
  'pl3': '排列三',
  'dlt': '大乐透',
  'qlc': '七乐彩',
  'kl8': '快乐8',
  'pl5': '排列五',
};

Map<String, int> lotterySorts = {
  'fc3d': 1,
  'pl3': 2,
  'ssq': 3,
  'dlt': 4,
  'qlc': 5,
  'kl8': 6,
};

Map<String, String> lotteryIcons = {
  'fc3d': ResourceStore().resource(R.fc3dIcon),
  'ssq': ResourceStore().resource(R.ssqIcon),
  'pl3': ResourceStore().resource(R.pl3Icon),
  'dlt': ResourceStore().resource(R.dltIcon),
  'qlc': ResourceStore().resource(R.qlcIcon),
  'kl8': ResourceStore().resource(R.kl8Icon),
};

Map<String, String> lotteryOutlineIcons = {
  'fc3d': ResourceStore().resource(R.fc3dOutlineIcon),
  'ssq': ResourceStore().resource(R.ssqOutlineIcon),
  'pl3': ResourceStore().resource(R.pl3OutlineIcon),
  'dlt': ResourceStore().resource(R.dltOutlineIcon),
  'qlc': ResourceStore().resource(R.qlcOutlineIcon),
  'kl8': ResourceStore().resource(R.kl8OutlineIcon),
};

Map<int, Color> feedTagColors = {
  1: Colors.deepOrange,
  2: Colors.deepPurpleAccent,
  3: Colors.purple,
  4: Colors.blueAccent,
};

Map<String, List<String>> lotteryTimes = {
  'fc3d': ['21:15', '每天开奖，开奖日20:30停止投注'],
  'ssq': ['21:15', '每周二、四、日开奖，开奖日20:00停止投注'],
  'pl3': ['21:25', '每天开奖，开奖日21:00停止投注'],
  'dlt': ['21:25', '每周一、三、六开奖，开奖日21:00停止投注'],
  'qlc': ['21:15', '每周一、三、五开奖，开奖日20:00停止投注'],
  'kl8': ['21:30', '每天开奖，开奖日21:00停止投注'],
};

Map<int, String> fc3dLevels = {
  1: '直选',
  2: '组三',
  3: '组六',
};

Map<int, String> pl3Levels = {
  10: '直选',
  20: '组三',
  30: '组六',
};

Map<int, String> ssqLevels = {
  1: '一等奖',
  2: '二等奖',
  3: '三等奖',
  4: '四等奖',
  5: '五等奖',
  6: '六等奖',
};

Map<int, String> qlcLevels = {
  1: '一等奖',
  2: '二等奖',
  3: '三等奖',
  4: '四等奖',
  5: '五等奖',
  6: '六等奖',
  7: '七等奖',
};

Map<int, String> dltLevels = {
  101: '一等奖',
  201: '一等奖追加',
  301: '二等奖',
  401: '二等奖追加',
  501: '三等奖',
  601: '四等奖',
  701: '五等奖',
  801: '六等奖',
  901: '七等奖',
  1001: '八等奖',
  1101: '九等奖',
};

Map<int, String> kl8Levels = {
  11: '1中1',
  22: '2中2',
  32: '3中2',
  33: '3中3',
  42: '4中2',
  43: '4中3',
  44: '4中4',
  53: '5中3',
  54: '5中4',
  55: '5中5',
  63: '6中3',
  64: '6中4',
  65: '6中5',
  66: '6中6',
  70: '7中0',
  74: '7中4',
  75: '7中5',
  76: '7中6',
  77: '7中7',
  80: '8中0',
  84: '8中4',
  85: '8中5',
  86: '8中6',
  87: '8中7',
  88: '8中8',
  90: '9中0',
  94: '9中4',
  95: '9中5',
  96: '9中6',
  97: '9中7',
  98: '9中8',
  99: '9中9',
  100: '10中0',
  105: '10中5',
  106: '10中6',
  107: '10中7',
  108: '10中8',
  109: '10中9',
  1010: '10中10',
};

///
///
Map<String, String> fc3dChannels = {
  'd1': '独 胆',
  'd2': '双 胆',
  'd3': '三 胆',
  'c5': '组选五',
  'c6': '组选六',
  'c7': '组选七',
  'k1': '杀一码',
  'k2': '杀二码',
};

///
///
Map<String, String> pl3Channels = {
  'd1': '独 胆',
  'd2': '双 胆',
  'd3': '三 胆',
  'c5': '组选五',
  'c6': '组选六',
  'c7': '组选七',
  'k1': '杀一码',
  'k2': '杀二码',
};

///
///
Map<String, String> ssqChannels = {
  'r1': '红独胆',
  'r2': '红双胆',
  'r3': '红三胆',
  'r12': '红12码',
  'r20': '红20码',
  'r25': '红25码',
  'rk3': '红杀三',
  'rk6': '红杀六',
  'b3': '蓝三码',
  'b5': '蓝五码',
  'bk': '蓝杀码',
};

///
///
Map<String, String> dltChannels = {
  'r1': '红独胆',
  'r2': '红双胆',
  'r3': '红三胆',
  'r10': '红10码',
  'r20': '红20码',
  'rk3': '红杀三',
  'rk6': '红杀六',
  'b1': '蓝独胆',
  'b2': '蓝双胆',
  'b6': '蓝六码',
  'bk': '蓝杀码',
};

///
///
Map<String, String> qlcChannels = {
  'r1': '独 胆',
  'r2': '双 胆',
  'r3': '三 胆',
  'r12': '荐12码',
  'r18': '荐18码',
  'r22': '荐22码',
  'k3': '杀三码',
  'k6': '杀六码',
};

///
/// 浏览类型路径后缀
Map<int, String> browsePath = {
  2: 'compare',
  3: 'full/census',
  4: 'vip/census',
  5: 'hot/census',
  6: 'rate/census',
  7: 'intellect',
  8: 'warn',
  10: 'pivot',
  11: 'num3/warn',
  12: 'num3/lotto/index',
  13: 'num3/layer',
};

Map<String, String> lottoRankMaps = {
  'fc3d': '/fc3d/mul_rank',
  'pl3': '/pl3/mul_rank',
  'ssq': '/ssq/mul_rank/0',
  'dlt': '/dlt/mul_rank/0',
  'qlc': '/qlc/mul_rank',
};

///
/// 浮动奖金标识
Map<int, String> levelAwards = {
  1: 'A',
  2: 'B',
  3: 'C',
};

///
/// 选3号码形态
Map<int, String> n3Patterns = {
  1: '豹子',
  2: '组三',
  3: '组六',
};

///
/// 连号形态
Map<int, String> seriesPatterns = {
  0: '无连号',
  2: '二连号',
  3: '三连号',
  4: '四连号',
  5: '五连号',
  6: '六连号',
  7: '七连号',
};

///0-9数字集合
///
List<int> ball09 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

List<String> ballStr09 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

List<String> ssqRedStr = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33'
];

List<String> ssqBlueStr = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
];

///
/// 双色球红球集合
List<int> ssq = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
];

List<String> dltRedStr = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35'
];

List<String> dltBlueStr = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12'
];

///
/// 双色球红球集合
List<int> dlt = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
];

///
/// 双色球红球集合
List<int> qlc = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
];

List<String> qlcStr = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
];

const Map<int, String> fourCodes = {
  1: "0126",
  2: "0134",
  3: "0159",
  4: "0178",
  5: "0239",
  6: "0247",
  7: "0258",
  8: "0357",
  9: "0368",
  10: "0456",
  11: "0489",
  12: "0679",
  13: "1237",
  14: "1245",
  15: "1289",
  16: "1358",
  17: "1369",
  18: "1468",
  19: "1479",
  20: "1567",
  21: "2348",
  22: "2356",
  23: "2469",
  24: "2579",
  25: "2678",
  26: "3459",
  27: "3467",
  28: "3789",
  29: "4578",
  30: "5689"
};

const Map<int, String> fiveCodes = {
  1: "01249",
  2: "01268",
  3: "01346",
  4: "01467",
  5: "01569",
  6: "02357",
  7: "02458",
  8: "03789",
  9: "12359",
  10: "12378",
  11: "12589",
  12: "13478",
  13: "14579",
  14: "23456",
  15: "24679",
  16: "34689",
  17: "35678"
};

import 'package:prize_lottery_app/utils/date_util.dart';

///
/// 开奖直播视频工具类
class OpenVideoUtils {
  ///
  /// 福彩直播地址
  static String fucaiLiveUri = 'https://www.cwl.gov.cn/ygkj/kjzb/';

  ///福彩历史开奖视频
  static String fucaiHistoryUri = 'https://www.cwl.gov.cn/html5/ygkj/wqkjsp/';

  ///体彩直播地址
  static String sportLiveUri =
      'https://appstatic.sporttery.cn/dl/h5/live/index/index.html';

  ///
  /// 体彩开奖往期直播地址
  static String sportHistoryUri(DateTime date) {
    String videoPath = sportVideo(date);
    return 'https://appstatic.sporttery.cn/dl/h5/live/videoList/videoList.html?needReload=1&videoPath=$videoPath';
  }

  static String sportVideo(DateTime date) {
    String dateText = DateUtil.formatDate(date, format: 'yyyy.MM.dd');
    return 'https://v.sporttery.cn/KJSP/$dateText.f4v.mp4';
  }

  static String ssqOrQlcVideo(DateTime date) {
    String dateText = DateUtil.formatDate(date, format: 'yyyyMMdd');
    String month = DateUtil.formatDate(date, format: 'MM');
    String day = DateUtil.formatDate(date, format: 'dd');
    return 'https://video.cwl.gov.cn/vod_storage/vol1/${date.year}/$month/$day/${dateText}0921t/${dateText}0921t.mp4';
  }

  static String fc3dVideo(DateTime date) {
    String dateText = DateUtil.formatDate(date, format: 'yyyyMMdd');
    String month = DateUtil.formatDate(date, format: 'MM');
    String day = DateUtil.formatDate(date, format: 'dd');
    return 'https://video.cwl.gov.cn/vod_storage/vol1/${date.year}/$month/$day/${dateText}0918t/${dateText}0918t.mp4';
  }

  static String kl8Video(DateTime date) {
    String dateText = DateUtil.formatDate(date, format: 'yyyyMMdd');
    String month = DateUtil.formatDate(date, format: 'MM');
    String day = DateUtil.formatDate(date, format: 'dd');
    return 'https://video.cwl.gov.cn/vod_storage/vol1/${date.year}/$month/$day/${dateText}0935t/${dateText}0935t.mp4';
  }
}

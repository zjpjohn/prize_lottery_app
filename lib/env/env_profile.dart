///
///属性配置
class Props {
  final String env;
  final String appName;
  final String appNo;
  final String baseUri;
  final String shareUri;
  final bool debug;

  Props({
    required this.env,
    required this.appName,
    required this.appNo,
    required this.baseUri,
    required this.shareUri,
    required this.debug,
  });
}

///
/// 环境profile
class Profile {
  ///
  ///获取当前环境值
  static const String envProfile = String.fromEnvironment(EnvName.envKey);

  ///debug环境
  static final Props _dev = Props(
    debug: true,
    env: EnvName.dev,
    appName: '哇彩推荐',
    appNo: 'h6hBvBeA3hK',
    baseUri: 'https://beta.api.icaiwa.com',
    shareUri: 'https://beta.mobile.icaiwa.com/app/h6hBvBeA3hK',
  );

  ///测试环境
  static final Props _beta = Props(
    debug: true,
    env: EnvName.beta,
    appName: '哇彩推荐',
    appNo: 'h6hBvBeA3hK',
    baseUri: 'https://beta.api.icaiwa.com',
    shareUri: 'https://beta.mobile.icaiwa.com/app/h6hBvBeA3hK',
  );

  ///正式环境
  static final Props _release = Props(
    debug: false,
    env: EnvName.release,
    appName: '哇彩推荐',
    appNo: 'x5K7sFhmFr4',
    baseUri: 'https://api.icaiwa.com',
    shareUri: 'https://mobile.icaiwa.com/app/x5K7sFhmFr4',
  );

  ///获取环境配置属性
  static Props get props => _getEnvProps();

  ///
  /// 不同环境对应的配置
  static Props _getEnvProps() {
    switch (envProfile) {
      case EnvName.dev:
        return _dev;
      case EnvName.beta:
        return _beta;
      case EnvName.release:
        return _release;
      default:
        return _dev;
    }
  }
}

abstract class EnvName {
  ///
  ///环境变量key
  static const String envKey = 'APP_PROFILE';

  ///debug环境
  static const String dev = 'dev';

  ///测试环境
  static const String beta = 'beta';

  ///正式环境
  static const String release = 'release';
}

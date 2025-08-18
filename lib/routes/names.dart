///
/// 路由集合
///
class AppRoutes {
  ///
  /// 授权登录
  ///
  static const login = '/login';

  ///
  /// 错误页面
  ///
  static const page404 = '/404';
  static const page500 = '/500';

  ///
  ///业务页面
  ///
  static const main = '/main';
  static const splash = '/splash';
  static const user = '/user';
  static const reset = '/reset';
  static const usage = '/usage';
  static const privacy = '/privacy';
  static const beian = '/beian';
  static const permission = '/permission';
  static const credential = '/credential';
  static const browse = '/browse';
  static const account = '/account';
  static const balance = '/balance/:index';
  static const subscribe = '/subscribe';
  static const hintMessage = '/hint';
  static const channelMessage = '/channel/message';
  static const channelSetting = '/channel/setting';
  static const settings = '/settings';
  static const appInfo = '/app';
  static const feedback = '/feedback';
  static const invite = '/invite';
  static const inviteHistory = '/invite/history';
  static const agentApply = '/agent/apply';
  static const sign = '/sign';
  static const voucher = '/voucher';
  static const voucherDraw = '/voucher/draw';
  static const consume = '/consume';
  static const exchange = '/exchange';
  static const order = '/order';
  static const member = '/member';
  static const memberLog = '/member/log';
  static const withdraw = '/withdraw';
  static const aboutAcct = '/about_acct';
  static const assistant = '/assistant';
  static const agentAccount = '/agent/account';
  static const agentIncome = '/agent/income';
  static const assistantDetail = '/assistant/detail/:id';

  static const fastTable = '/qtable/:type';
  static const huntTable = '/htable/:type';
  static const diagramsTable = '/dtable/:type';
  static const wuXingTable = '/wtable/:type';
  static const palaceTable = '/palace/:type';
  static const palaceNewTable = '/palace/new/:type';
  static const honeyTable = '/honey/:type';
  static const aroundTable = '/around/:type';
  static const lotteryHistory = '/lotto/history/:type';
  static const lotteryDetail = '/lotto/detail/:type/:period';
  static const lotteryDan = '/lotto/dan/:type';

  static const fc3dMulRank = '/fc3d/mul_rank';
  static const fc3dItemRank = '/fc3d/item_rank/:type';

  static const pl3MulRank = '/pl3/mul_rank';
  static const pl3ItemRank = '/pl3/item_rank/:type';

  static const ssqMulRank = '/ssq/mul_rank/:type';
  static const ssqItemRank = '/ssq/item_rank/:type';

  static const dltMulRank = '/dlt/mul_rank/:type';
  static const dltItemRank = '/dlt/item_rank/:type';

  static const qlcMulRank = '/qlc/mul_rank';
  static const qlcItemRank = '/qlc/item_rank/:type';

  static const searchMaster = '/search';
  static const searchDetail = '/search/detail/:masterId';

  static const fc3dMaster = '/fc3d/master/:masterId';
  static const pl3Master = '/pl3/master/:masterId';
  static const ssqMaster = '/ssq/master/:masterId';
  static const dltMaster = '/dlt/master/:masterId';
  static const qlcMaster = '/qlc/master/:masterId';

  static const fc3dMasterFeature = '/fc3d/master/feature/:masterId';
  static const pl3MasterFeature = '/pl3/master/feature/:masterId';
  static const ssqMasterFeature = '/ssq/master/feature/:masterId';
  static const dltMasterFeature = '/dlt/master/feature/:masterId';
  static const qlcMasterFeature = '/qlc/master/feature/:masterId';

  static const fc3dForecast = '/fc3d/forecast/:masterId';
  static const pl3Forecast = '/pl3/forecast/:masterId';
  static const ssqForecast = '/ssq/forecast/:masterId';
  static const dltForecast = '/dlt/forecast/:masterId';
  static const qlcForecast = '/qlc/forecast/:masterId';

  static const fc3dGladList = '/fc3d/glad';
  static const pl3GladList = '/pl3/glad';
  static const ssqGladList = '/ssq/glad';
  static const dltGladList = '/dlt/glad';
  static const qlcGladList = '/qlc/glad';

  static const fc3dWarn = '/fc3d/warn';
  static const pl3Warn = '/pl3/warn';

  static const fc3dBattle = '/fc3d/battle';
  static const fc3dBattleRank = '/fc3d/battle/rank';
  static const ssqBattle = '/ssq/battle';
  static const ssqBattleRank = '/ssq/battle/rank';
  static const pl3Battle = '/pl3/battle';
  static const pl3BattleRank = '/pl3/battle/rank';
  static const dltBattle = '/dlt/battle';
  static const dltBattleRank = '/dlt/battle/rank';
  static const qlcBattle = '/qlc/battle';
  static const qlcBattleRank = '/qlc/battle/rank';

  static const fc3dFullCensus = '/fc3d/full/census';
  static const fc3dVipCensus = '/fc3d/vip/census';
  static const fc3dRateCensus = '/fc3d/rate/census';
  static const fc3dHotCensus = '/fc3d/hot/census';
  static const fc3dAnaCensus = '/fc3d/ana/census';

  static const pl3FullCensus = '/pl3/full/census';
  static const pl3VipCensus = '/pl3/vip/census';
  static const pl3RateCensus = '/pl3/rate/census';
  static const pl3HotCensus = '/pl3/hot/census';
  static const pl3AlertCensus = '/pl3/alert/census';
  static const pl3AnaCensus = '/pl3/ana/census';

  static const ssqFullCensus = '/ssq/full/census';
  static const ssqVipCensus = '/ssq/vip/census';
  static const ssqRateCensus = '/ssq/rate/census';
  static const ssqHotCensus = '/ssq/hot/census';
  static const ssqAnaCensus = '/ssq/ana/census';

  static const dltFullCensus = '/dlt/full/census';
  static const dltVipCensus = '/dlt/vip/census';
  static const dltRateCensus = '/dlt/rate/census';
  static const dltHotCensus = '/dlt/hot/census';
  static const dltAnaCensus = '/dlt/ana/census';

  static const qlcFullCensus = '/qlc/full/census';
  static const qlcVipCensus = '/qlc/vip/census';
  static const qlcRateCensus = '/qlc/rate/census';
  static const qlcHotCensus = '/qlc/hot/census';
  static const qlcAnaCensus = '/qlc/ana/census';

  static const fc3dTrend = '/fc3d/trend/:type';
  static const fc3dItemOmit = '/fc3d/item/omit';
  static const fc3dShrink = '/fc3d/shrink';
  static const fc3dRealTime = '/fc3d/live';
  static const fc3dIntellect = '/fc3d/intellect';

  static const pl3Trend = '/pl3/trend/:type';
  static const pl3ItemOmit = '/pl3/item/omit';
  static const pl3Shrink = '/pl3/shrink';
  static const pl3RealTime = '/pl3/live';
  static const pl3Intellect = '/pl3/intellect';

  static const num3LottoIndex = '/:type/num3/lotto/index';

  static const ssqCalculator = '/ssq/calculator';
  static const ssqTrend = '/ssq/trend/:type';
  static const ssqShrink = '/ssq/shrink';
  static const ssqRealTime = '/ssq/live';
  static const ssqIntellect = '/ssq/intellect';

  static const dltCalculator = '/dlt/calculator';
  static const dltTrend = '/dlt/trend/:type';
  static const dltShrink = '/dlt/shrink';
  static const dltRealTime = '/dlt/live';
  static const dltIntellect = '/dlt/intellect';

  static const qlcCalculator = '/qlc/calculator';
  static const qlcTrend = '/qlc/trend/:type';
  static const qlcShrink = '/qlc/shrink';
  static const qlcRealTime = '/qlc/live';
  static const qlcIntellect = '/qlc/intellect';

  static const kl8Calculator = '/kl8/calculator';
  static const kl8Trend = '/kl8/trend/:type';
  static const kl8RealTime = '/kl8/live';

  static const newsDetail = '/news/detail/:seq';
  static const newsList = '/news/list';

  static const skillDetail = '/skill/detail/:seq';
  static const skillList = '/skill/list';

  static const manualBook = '/manual_book';

  static const expertCenter = '/expert';

  static const rewardVideo = '/rewardAd';

  static const fc3dPivot = '/fc3d/pivot';
  static const pl3Pivot = '/pl3/pivot';

  static const fucaiLive = '/fucai/live';
  static const fucaiHistory = '/fucai/history';
  static const sportLive = '/sport/live';
  static const sportHistory = '/sport/history';

  /// 万能选号
  static const universalCode = '/universal/code/:lotto';

  ///选三预警分析
  static const num3Warn = '/:type/num3/warn';
  static const num3Layer = '/:type/num3/layer';
  static const wensFilter = '/wens/filter/:type';

  ///偏态路由
  static const lottoPian = '/omit/pian/:type';

  ///快乐8尾数统计矩阵
  static const kl8Matrix = '/kl8/matrix';

  ///选三出号统计
  static const num3ComCount = '/num3/com/count/:type';

  ///选三号码跟随
  static const num3Follow = '/num3/follow/list/:type';
  static const comFollow = '/num3/com/follow/:type';

  ///
  static const pl5Item = '/pl5/item/:type';
  static const pl5Omit = '/pl5/omit/:type';
}

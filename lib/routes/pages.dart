import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/intercepts/route_auth.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/app/app_info_view.dart';
import 'package:prize_lottery_app/views/app/app_setting_view.dart';
import 'package:prize_lottery_app/views/battle/pages/dlt_battle_rank_view.dart';
import 'package:prize_lottery_app/views/battle/pages/dlt_battle_view.dart';
import 'package:prize_lottery_app/views/battle/pages/fc3d_battle_rank_view.dart';
import 'package:prize_lottery_app/views/battle/pages/fc3d_battle_view.dart';
import 'package:prize_lottery_app/views/battle/pages/pl3_battle_rank_view.dart';
import 'package:prize_lottery_app/views/battle/pages/pl3_battle_view.dart';
import 'package:prize_lottery_app/views/battle/pages/qlc_battle_rank_view.dart';
import 'package:prize_lottery_app/views/battle/pages/qlc_battle_view.dart';
import 'package:prize_lottery_app/views/battle/pages/ssq_battle_rank_view.dart';
import 'package:prize_lottery_app/views/battle/pages/ssq_battle_view.dart';
import 'package:prize_lottery_app/views/census/bindings/dlt_census_bindings.dart';
import 'package:prize_lottery_app/views/census/bindings/fc3d_census_bindings.dart';
import 'package:prize_lottery_app/views/census/bindings/pl3_census_bindings.dart';
import 'package:prize_lottery_app/views/census/bindings/qlc_census_bindings.dart';
import 'package:prize_lottery_app/views/census/bindings/ssq_census_bindings.dart';
import 'package:prize_lottery_app/views/census/pages/dlt/dlt_full_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/dlt/dlt_hot_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/dlt/dlt_lotto_ana_view.dart';
import 'package:prize_lottery_app/views/census/pages/dlt/dlt_rate_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/dlt/dlt_vip_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/fc3d/fc3d_full_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/fc3d/fc3d_hot_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/fc3d/fc3d_lotto_ana_view.dart';
import 'package:prize_lottery_app/views/census/pages/fc3d/fc3d_rate_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/fc3d/fc3d_vip_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/pl3/pl3_full_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/pl3/pl3_hot_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/pl3/pl3_lotto_ana_view.dart';
import 'package:prize_lottery_app/views/census/pages/pl3/pl3_rate_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/pl3/pl3_vip_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/qlc/qlc_full_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/qlc/qlc_hot_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/qlc/qlc_lotto_ana_view.dart';
import 'package:prize_lottery_app/views/census/pages/qlc/qlc_rate_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/qlc/qlc_vip_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/ssq/ssq_full_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/ssq/ssq_hot_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/ssq/ssq_lotto_ana_view.dart';
import 'package:prize_lottery_app/views/census/pages/ssq/ssq_rate_census_view.dart';
import 'package:prize_lottery_app/views/census/pages/ssq/ssq_vip_census_view.dart';
import 'package:prize_lottery_app/views/expert/bindings/expert_center_bindings.dart';
import 'package:prize_lottery_app/views/expert/pages/expert_center_view.dart';
import 'package:prize_lottery_app/views/forecast/pages/dlt_forecast_view.dart';
import 'package:prize_lottery_app/views/forecast/pages/fc3d_forecast_view.dart';
import 'package:prize_lottery_app/views/forecast/pages/pl3_forecast_view.dart';
import 'package:prize_lottery_app/views/forecast/pages/qlc_forecast_view.dart';
import 'package:prize_lottery_app/views/forecast/pages/ssq_forecast_view.dart';
import 'package:prize_lottery_app/views/glad/bindings/dlt_glad_bindings.dart';
import 'package:prize_lottery_app/views/glad/bindings/fc3d_glad_bindings.dart';
import 'package:prize_lottery_app/views/glad/bindings/pl3_glad_bindings.dart';
import 'package:prize_lottery_app/views/glad/bindings/qlc_glad_bindings.dart';
import 'package:prize_lottery_app/views/glad/bindings/ssq_glad_bindings.dart';
import 'package:prize_lottery_app/views/glad/page/dlt_glad_list_view.dart';
import 'package:prize_lottery_app/views/glad/page/fc3d_glad_list_view.dart';
import 'package:prize_lottery_app/views/glad/page/pl3_glad_list_view.dart';
import 'package:prize_lottery_app/views/glad/page/qlc_glad_list_view.dart';
import 'package:prize_lottery_app/views/glad/page/ssq_glad_list_view.dart';
import 'package:prize_lottery_app/views/lottery/bindings/dlt_calculator_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/dlt_intellect_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/dlt_number_trend_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/dlt_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/fast_table_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/fc3d_intellect_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/fc3d_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/kl8_calculator_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/kl8_number_trend_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/kl8_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_assistant_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_dan_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_detail_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_history_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_omit_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/lottery_palace_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/num3_count_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/num3_lotto_index_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/pl3_intellect_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/pl3_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/qlc_calculator_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/qlc_intellect_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/qlc_number_trend_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/qlc_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/ssq_calculator_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/ssq_intellect_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/ssq_number_trend_bindings.dart';
import 'package:prize_lottery_app/views/lottery/bindings/ssq_real_time_bindings.dart';
import 'package:prize_lottery_app/views/lottery/pages/assistant_detail_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/code/universal_code_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/dlt/dlt_calculator_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/dlt/dlt_intellect_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/dlt/dlt_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/dlt/dlt_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fast_table_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_intellect_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_item_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fucai_history_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/fucai_live_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/hunt_table_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/kl8_calculator_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/kl8_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/kl8_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/kl8/kl8_tail_matrix_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_around_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_assistant_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_dan_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_detail_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_diagrams_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_history_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_honey_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_palace_new_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_palace_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_pian_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/num3_com_count_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/num3_com_follow_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/num3_lotto_follow_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/num3_lotto_index_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl3/pl3_intellect_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl3/pl3_item_trend_widget.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl3/pl3_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl3/pl3_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/pl5_item_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/pl5/pl5_omit_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/qlc/qlc_caculator_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/qlc/qlc_intellect_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/qlc/qlc_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/qlc/qlc_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/sport_history_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/sport_live_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/ssq_caculator_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/ssq_intellect_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/ssq_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/ssq/ssq_real_time_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/wuxing_table_view.dart';
import 'package:prize_lottery_app/views/main/main_bindings.dart';
import 'package:prize_lottery_app/views/main/main_view.dart';
import 'package:prize_lottery_app/views/master/bindings/master_feature_bindings.dart';
import 'package:prize_lottery_app/views/master/bindings/search_master_bindings.dart';
import 'package:prize_lottery_app/views/master/pages/detail/dlt_master_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/detail/fc3d_master_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/detail/pl3_master_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/detail/qlc_master_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/detail/ssq_master_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/feature/dlt_master_feature_view.dart';
import 'package:prize_lottery_app/views/master/pages/feature/fc3d_master_feature_view.dart';
import 'package:prize_lottery_app/views/master/pages/feature/pl3_master_feature_view.dart';
import 'package:prize_lottery_app/views/master/pages/feature/qlc_master_feature_view.dart';
import 'package:prize_lottery_app/views/master/pages/feature/ssq_master_feature_view.dart';
import 'package:prize_lottery_app/views/master/pages/search/search_detail_view.dart';
import 'package:prize_lottery_app/views/master/pages/search_master_view.dart';
import 'package:prize_lottery_app/views/news/pages/news_detail_view.dart';
import 'package:prize_lottery_app/views/news/pages/news_list_view.dart';
import 'package:prize_lottery_app/views/pay/pages/order_center_view.dart';
import 'package:prize_lottery_app/views/pivot/pages/fc3d_pivot_view.dart';
import 'package:prize_lottery_app/views/pivot/pages/pl3_pivot_view.dart';
import 'package:prize_lottery_app/views/protocol/beian_miit_view.dart';
import 'package:prize_lottery_app/views/protocol/credential_quality_view.dart';
import 'package:prize_lottery_app/views/protocol/manual_book_view.dart';
import 'package:prize_lottery_app/views/protocol/permission_list_view.dart';
import 'package:prize_lottery_app/views/protocol/privacy_protocol_view.dart';
import 'package:prize_lottery_app/views/protocol/usage_protocol_view.dart';
import 'package:prize_lottery_app/views/rank/bindings/dlt_rank_bindings.dart';
import 'package:prize_lottery_app/views/rank/bindings/fc3d_rank_bindings.dart';
import 'package:prize_lottery_app/views/rank/bindings/pl3_rank_bindings.dart';
import 'package:prize_lottery_app/views/rank/bindings/qlc_rank_bindings.dart';
import 'package:prize_lottery_app/views/rank/bindings/ssq_rank_bindings.dart';
import 'package:prize_lottery_app/views/rank/pages/item/dlt_item_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/item/fc3d_item_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/item/pl3_item_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/item/qlc_item_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/item/ssq_item_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/mul/dlt_mul_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/mul/fc3d_mul_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/mul/pl3_mul_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/mul/qlc_mul_rank_view.dart';
import 'package:prize_lottery_app/views/rank/pages/mul/ssq_mul_rank_view.dart';
import 'package:prize_lottery_app/views/recom/bindings/fc3d_warning_bindings.dart';
import 'package:prize_lottery_app/views/recom/bindings/num3_warn_bindings.dart';
import 'package:prize_lottery_app/views/recom/bindings/pl3_warning_bindings.dart';
import 'package:prize_lottery_app/views/recom/pages/fc3d_warning_view.dart';
import 'package:prize_lottery_app/views/recom/pages/num3_com_warn_view.dart';
import 'package:prize_lottery_app/views/recom/pages/num3_layer_view.dart';
import 'package:prize_lottery_app/views/recom/pages/pl3_warning_view.dart';
import 'package:prize_lottery_app/views/shrink/bindings/dlt_shrink_bindings.dart';
import 'package:prize_lottery_app/views/shrink/bindings/fc3d_shrink_bindings.dart';
import 'package:prize_lottery_app/views/shrink/bindings/pl3_shrink_bindings.dart';
import 'package:prize_lottery_app/views/shrink/bindings/qlc_shrink_bindings.dart';
import 'package:prize_lottery_app/views/shrink/bindings/ssq_shrink_bindings.dart';
import 'package:prize_lottery_app/views/shrink/pages/dlt_shrink_view.dart';
import 'package:prize_lottery_app/views/shrink/pages/fc3d_shrink_view.dart';
import 'package:prize_lottery_app/views/shrink/pages/pl3_shrink_view.dart';
import 'package:prize_lottery_app/views/shrink/pages/qlc_shrink_view.dart';
import 'package:prize_lottery_app/views/shrink/pages/ssq_shrink_view.dart';
import 'package:prize_lottery_app/views/skill/pages/skill_detaill_view.dart';
import 'package:prize_lottery_app/views/skill/pages/skill_list_view.dart';
import 'package:prize_lottery_app/views/splash/splash_view.dart';
import 'package:prize_lottery_app/views/user/bindings/about_account_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/feedback_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/message_center_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/reset_password_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_balance_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_browse_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_invite_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_login_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_member_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_sign_bindings.dart';
import 'package:prize_lottery_app/views/user/bindings/user_subscribe_binding.dart';
import 'package:prize_lottery_app/views/user/bindings/user_voucher_bindings.dart';
import 'package:prize_lottery_app/views/user/pages/about_account_view.dart';
import 'package:prize_lottery_app/views/user/pages/invite/agent_account_view.dart';
import 'package:prize_lottery_app/views/user/pages/invite/agent_income_view.dart';
import 'package:prize_lottery_app/views/user/pages/invite/agent_protocol_view.dart';
import 'package:prize_lottery_app/views/user/pages/invite/invite_history_view.dart';
import 'package:prize_lottery_app/views/user/pages/invite/user_invite_view.dart';
import 'package:prize_lottery_app/views/user/pages/member/member_record_view.dart';
import 'package:prize_lottery_app/views/user/pages/member/user_member_view.dart';
import 'package:prize_lottery_app/views/user/pages/message/channel_message_view.dart';
import 'package:prize_lottery_app/views/user/pages/message/channel_setting_view.dart';
import 'package:prize_lottery_app/views/user/pages/message/message_center_view.dart';
import 'package:prize_lottery_app/views/user/pages/records/consume_record_view.dart';
import 'package:prize_lottery_app/views/user/pages/records/exchange_record_view.dart';
import 'package:prize_lottery_app/views/user/pages/records/withdraw_record_view.dart';
import 'package:prize_lottery_app/views/user/pages/reset_password_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_account_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_balance_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_browse_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_feedback_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_login_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_sign_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_subscribe_view.dart';
import 'package:prize_lottery_app/views/user/pages/voucher/draw_voucher_view.dart';
import 'package:prize_lottery_app/views/user/pages/voucher/user_voucher_view.dart';
import 'package:prize_lottery_app/views/wens/bindins/wens_filter_bindings.dart';
import 'package:prize_lottery_app/views/wens/pages/wens_filter_view.dart';

class AppPages {
  ///
  /// 路由集合
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      transition: Transition.noTransition,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const UserLoginView(),
      binding: UserLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.usage,
      page: () => const UsageProtocolView(),
    ),
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyProtocolView(),
    ),
    GetPage(
      name: AppRoutes.beian,
      page: () => const BeiAnMiitView(),
    ),
    GetPage(
      name: AppRoutes.credential,
      page: () => const CredentialQualityView(),
    ),
    GetPage(
      name: AppRoutes.permission,
      page: () => const PermissionListView(),
    ),
    GetPage(
      name: AppRoutes.appInfo,
      page: () => const AppInfoView(),
    ),
    GetPage(
      name: AppRoutes.browse,
      page: () => const UserBrowseView(),
      binding: UserBrowseBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const AppSettingView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const UserAccountView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.balance,
      page: () => const UserBalanceView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.voucher,
      page: () => const UserVoucherView(),
      binding: UserVoucherBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.voucherDraw,
      page: () => const DrawVoucherView(),
      binding: DrawVoucherBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.consume,
      page: () => const ConsumeRecordView(),
      binding: ConsumeRecordBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.exchange,
      page: () => const ExchangeRecordView(),
      binding: ExchangeRecordBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.withdraw,
      page: () => const WithdrawRecordView(),
      binding: WithdrawLogBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.subscribe,
      page: () => const UserSubscribeView(),
      binding: UserSubscribeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.feedback,
      page: () => const FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: AppRoutes.order,
      page: () => const OrderCenterView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.invite,
      page: () => const UserInviteView(),
      binding: UserInviteBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.inviteHistory,
      page: () => const InviteHistoryView(),
      transition: Transition.rightToLeft,
      binding: InviteHistoryBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.agentApply,
      page: () => const AgentProtocolView(),
      binding: AgentApplyBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.agentAccount,
      page: () => const AgentAccountView(),
      binding: AgentAccountBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.agentIncome,
      page: () => const AgentIncomeView(),
      transition: Transition.rightToLeft,
      binding: AgentIncomeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.sign,
      page: () => const UserSignView(),
      binding: UserSignBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.member,
      page: () => const UserMemberView(),
      binding: UserMemberBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.memberLog,
      page: () => const MemberRecordView(),
      binding: MemberRecordBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.hintMessage,
      page: () => const MessageCenterView(),
      binding: MessageCenterBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.channelMessage,
      page: () => const ChannelMessageView(),
      binding: ChannelMessageBindings(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.channelSetting,
      page: () => const ChannelSettingView(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.aboutAcct,
      page: () => const AboutAccountView(),
      binding: AboutAccountBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.assistant,
      page: () => const LotteryAssistantView(),
      binding: LotteryAssistantBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.assistantDetail,
      page: () => const AssistantDetailView(),
      binding: AssistantDetailBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fastTable,
      page: () => const FastTableView(),
      binding: FastTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.huntTable,
      page: () => const HuntTableView(),
      binding: HuntTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.diagramsTable,
      page: () => const LotteryDiagramsView(),
      binding: DiagramsTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.wuXingTable,
      page: () => const WuXingTableView(),
      binding: WuXingTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.aroundTable,
      page: () => const LotteryAroundView(),
      binding: LotteryAroundBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.honeyTable,
      page: () => const LotteryHoneyView(),
      binding: LotteryHoneyBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.universalCode,
      page: () => const UniversalCodeView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.lotteryHistory,
      page: () => const LotteryHistoryView(),
      binding: LotteryHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.lotteryDetail,
      page: () => const LotteryDetailView(),
      binding: LotteryDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.lotteryDan,
      page: () => const LotteryDanView(),
      binding: LotteryDanBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.searchMaster,
      page: () => const SearchMasterView(),
      binding: SearchMasterBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.searchDetail,
      page: () => const SearchDetailView(),
      binding: SearchDetailBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.fc3dMulRank,
      page: () => const Fc3dMasterRankView(),
      binding: Fc3dMulRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dItemRank,
      page: () => const Fc3dItemRankView(),
      binding: Fc3dItemRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dGladList,
      page: () => const Fc3dGladListView(),
      binding: Fc3dGladBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dMaster,
      page: () => const Fc3dMasterDetailView(),
      preventDuplicates: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dMasterFeature,
      page: () => const Fc3dMasterFeatureView(),
      binding: Fc3dFeatureBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dForecast,
      page: () => const Fc3dForecastView(),
      preventDuplicates: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dBattle,
      page: () => const Fc3dBattleView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dBattleRank,
      page: () => const Fc3dBattleRankView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dFullCensus,
      page: () => const Fc3dFullCensusView(),
      binding: Fc3dFullCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dVipCensus,
      page: () => const Fc3dVipCensusView(),
      binding: Fc3dVipCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dRateCensus,
      page: () => const Fc3dRateCensusView(),
      binding: Fc3dRateCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dHotCensus,
      page: () => const Fc3dHotCensusView(),
      binding: Fc3dHotCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dAnaCensus,
      page: () => const Fc3dAnalyzeView(),
      binding: Fc3dAnalyzeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dTrend,
      page: () => const Fc3dNumberTrendView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.lottoPian,
      page: () => const LotteryPianView(),
      binding: LotteryPianBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dShrink,
      page: () => const Fc3dShrinkView(),
      binding: Fc3dShrinkBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dRealTime,
      page: () => const Fc3dRealTimeView(),
      binding: Fc3dRealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dIntellect,
      page: () => const Fc3dIntellectView(),
      binding: Fc3dIntellectBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dWarn,
      page: () => const Fc3dWarningView(),
      binding: Fc3dWarningBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.palaceTable,
      page: () => const LotteryPalaceView(),
      binding: HoneyTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.palaceNewTable,
      page: () => const LotteryPalaceNewView(),
      binding: HoneyNewTableBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.fc3dPivot,
      page: () => const Fc3dPivotView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.pl3MulRank,
      page: () => const Pl3MasterRankView(),
      binding: Pl3MulRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3ItemRank,
      page: () => const Pl3ItemRankView(),
      binding: Pl3ItemRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Master,
      page: () => const Pl3MasterDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3MasterFeature,
      page: () => const Pl3MasterFeatureView(),
      binding: Pl3FeatureBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3GladList,
      page: () => const Pl3GladListView(),
      binding: Pl3GladBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Forecast,
      page: () => const Pl3ForecastView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Battle,
      page: () => const Pl3BattleView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3BattleRank,
      page: () => const Pl3BattleRankView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3FullCensus,
      page: () => const Pl3FullCensusView(),
      binding: Pl3FullCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3VipCensus,
      page: () => const Pl3VipCensusView(),
      binding: Pl3VipCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3RateCensus,
      page: () => const Pl3RateCensusView(),
      binding: Pl3RateCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3HotCensus,
      page: () => const Pl3HotCensusView(),
      binding: Pl3HotCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3AnaCensus,
      page: () => const Pl3AnalyzeView(),
      binding: Pl3AnalyzeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Trend,
      page: () => const Pl3NumberTrendView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Shrink,
      page: () => const Pl3ShrinkView(),
      binding: Pl3ShrinkBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3RealTime,
      page: () => const Pl3RealTimeView(),
      binding: Pl3RealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Intellect,
      page: () => const Pl3IntellectView(),
      binding: Pl3IntellectBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Warn,
      page: () => const Pl3WarningView(),
      binding: Pl3WarningBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pl3Pivot,
      page: () => const Pl3PivotView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.ssqMulRank,
      page: () => const SsqMasterRankView(),
      binding: SsqMulRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqItemRank,
      page: () => const SsqItemRankView(),
      binding: SsqItemRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqMaster,
      page: () => const SsqMasterDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqMasterFeature,
      page: () => const SsqMasterFeatureView(),
      binding: SsqFeatureBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqGladList,
      page: () => const SsqGladListView(),
      binding: SsqGladBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqForecast,
      page: () => const SsqForecastView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqBattle,
      page: () => const SsqBattleView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqBattleRank,
      page: () => const SsqBattleRankView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqFullCensus,
      page: () => const SsqFullCensusView(),
      binding: SsqFullCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqVipCensus,
      page: () => const SsqVipCensusView(),
      binding: SsqVipCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqRateCensus,
      page: () => const SsqRateCensusView(),
      binding: SsqRateCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqHotCensus,
      page: () => const SsqHotCensusView(),
      binding: SsqHotCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqAnaCensus,
      page: () => const SsqAnalyzeView(),
      binding: SsqAnalyzeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqCalculator,
      page: () => const SsqCalculatorView(),
      binding: SsqCalculatorBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqTrend,
      page: () => const SsqNumberTrendView(),
      binding: SsqNumberTrendBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqShrink,
      page: () => const SsqShrinkView(),
      binding: SsqShrinkBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqRealTime,
      page: () => const SsqRealTimeView(),
      binding: SsqRealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.ssqIntellect,
      page: () => const SsqIntellectView(),
      binding: SsqIntellectBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.dltMulRank,
      page: () => const DltMasterRankView(),
      binding: DltMulRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltItemRank,
      page: () => const DltItemRankView(),
      binding: DltItemRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltMaster,
      page: () => const DltMasterDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltMasterFeature,
      page: () => const DltMasterFeatureView(),
      binding: DltFeatureBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltGladList,
      page: () => const DltGladListView(),
      binding: DltGladBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltForecast,
      page: () => const DltForecastView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltBattle,
      page: () => const DltBattleView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltBattleRank,
      page: () => const DltBattleRankView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltFullCensus,
      page: () => const DltFullCensusView(),
      binding: DltFullCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltVipCensus,
      page: () => const DltVipCensusView(),
      binding: DltVipCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltRateCensus,
      page: () => const DltRateCensusView(),
      binding: DltRateCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltHotCensus,
      page: () => const DltHotCensusView(),
      binding: DltHotCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltAnaCensus,
      page: () => const DltLottoAnaView(),
      binding: DltAnalyzeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltCalculator,
      page: () => const DltCalculatorView(),
      binding: DltCalculatorBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltTrend,
      page: () => const DltNumberTrendView(),
      binding: DltNumberTrendBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltShrink,
      page: () => const DltShrinkView(),
      binding: DltShrinkBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltRealTime,
      page: () => const DltRealTimeView(),
      binding: DltRealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.dltIntellect,
      page: () => const DltIntellectView(),
      binding: DltIntellectBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.qlcMulRank,
      page: () => const QlcMasterRankView(),
      binding: QlcMulRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcItemRank,
      page: () => const QlcItemRankView(),
      binding: QlcItemRankBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcMaster,
      page: () => const QlcMasterDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcMasterFeature,
      page: () => const QlcMasterFeatureView(),
      binding: QlcFeatureBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcGladList,
      page: () => const QlcGladListView(),
      binding: QlcGladBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcForecast,
      page: () => const QlcForecastView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcBattle,
      page: () => const QlcBattleView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcBattleRank,
      page: () => const QlcBattleRankView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcFullCensus,
      page: () => const QlcFullCensusView(),
      binding: QlcFullCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcVipCensus,
      page: () => const QlcVipCensusView(),
      binding: QlcVipCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcRateCensus,
      page: () => const QlcRateCensusView(),
      binding: QlcRateCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcHotCensus,
      page: () => const QlcHotCensusView(),
      binding: QlcHotCensusBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcAnaCensus,
      page: () => const QlcAnalyzeView(),
      binding: QlcAnalyzeBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcCalculator,
      page: () => const QlcCalculatorView(),
      binding: QlcCalculatorBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcTrend,
      page: () => const QlcNumberTrendView(),
      binding: QlcNumberTrendBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcShrink,
      page: () => const QlcShrinkView(),
      binding: QlcShrinkBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcRealTime,
      page: () => const QlcRealTimeView(),
      binding: QlcRealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.qlcIntellect,
      page: () => const QlcIntellectView(),
      binding: QlcIntellectBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.kl8Calculator,
      page: () => const Kl8CalculatorView(),
      binding: Kl8CalculatorBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.kl8Trend,
      page: () => const Kl8NumberTrendView(),
      binding: Kl8NumberTrendBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.kl8Matrix,
      page: () => const Kl8TailMatrixView(),
      binding: Kl8MatrixBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.kl8RealTime,
      page: () => const Kl8RealTimeView(),
      binding: Kl8RealTimeBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    ///
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.newsList,
      page: () => const NewsListView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.skillDetail,
      page: () => const SkillDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.skillList,
      page: () => const SkillListView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.expertCenter,
      page: () => const ExpertCenterView(),
      binding: ExpertCenterBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.num3Warn,
      page: () => const Num3ComWarnView(),
      binding: Num3WarnBindings(),
      opaque: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.num3Layer,
      page: () => const Num3LayerView(),
      binding: Num3LayerBindings(),
      opaque: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.wensFilter,
      page: () => const WensFilterView(),
      binding: WensFilterBindings(),
      opaque: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.num3LottoIndex,
      page: () => const Num3LottoIndexView(),
      binding: Num3LottoIndexBindings(),
      opaque: false,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),

    ///
    GetPage(
      name: AppRoutes.fucaiLive,
      page: () => const FucaiLiveView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.fucaiHistory,
      page: () => const FucaiHistoryView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.sportLive,
      page: () => const SportLiveView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.sportHistory,
      page: () => const SportHistoryView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.manualBook,
      page: () => const ManualBookView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.num3ComCount,
      page: () => const Num3ComCountView(),
      binding: Num3CountBindings(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.num3Follow,
      page: () => const Num3LottoFollowView(),
      binding: Num3FollowBindings(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.comFollow,
      page: () => const Num3ComFollowView(),
      binding: ComFollowBindings(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.fc3dItemOmit,
      page: () => const Fc3dItemTrendView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.pl3ItemOmit,
      page: () => const Pl3ItemTrendWidget(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.pl5Item,
      page: () => const Pl5ItemTrendView(),
      opaque: false,
    ),
    GetPage(
      name: AppRoutes.pl5Omit,
      page: () => const Pl5OmitTrendView(),
      opaque: false,
    ),
  ];
}

import 'dart:collection';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/store/config.dart';

///
///
class AppCalendarHint {
  ///
  ///
  static AppCalendarHint? _instance;

  ///
  late DeviceCalendarPlugin _calendarPlugin;

  AppCalendarHint.internal() {
    _calendarPlugin = DeviceCalendarPlugin();
  }

  factory AppCalendarHint() {
    AppCalendarHint._instance ??= AppCalendarHint.internal();
    return AppCalendarHint._instance!;
  }

  ///
  ///
  /// 不存在创建提醒事件
  void createEventIfAbsent() async {
    EasyLoading.show();
    bool exist = await _hasExistHintEvent();
    if (exist) {
      EasyLoading.showToast('已创建提醒');
      return;
    }
    bool value = await _createCalendarEvent();
    if (value) {
      EasyLoading.showToast('创建成功');
      return;
    }
    EasyLoading.dismiss();
  }

  ///
  /// 申请日历权限
  ///
  Future<bool> _permissionIfAbsent() async {
    Result<bool> granted = await _calendarPlugin.hasPermissions();
    if (!granted.isSuccess) {
      return false;
    }
    if (granted.data!) {
      return true;
    }
    granted = await _calendarPlugin.requestPermissions();
    return granted.isSuccess && granted.data!;
  }

  ///
  /// 判断是否存在提醒日历事件
  ///
  Future<bool> _hasExistHintEvent() async {
    ///申请日历权限
    if (!(await _permissionIfAbsent())) {
      return false;
    }

    ///查询是否存在已添加日历事件
    var result = await _calendarPlugin.retrieveCalendars();
    if (result.data == null || result.data!.isEmpty) {
      return false;
    }
    List<Calendar> calendars = result.data as List<Calendar>;
    Calendar calendar =
        calendars.firstWhere((e) => e.isReadOnly == null || !e.isReadOnly!);
    String eventId = ConfigStore().calendarHintEvent;
    if (eventId.isNotEmpty) {
      Result<UnmodifiableListView<Event>> eventResult =
          await _calendarPlugin.retrieveEvents(
        calendar.id,
        RetrieveEventsParams(eventIds: [eventId]),
      );
      if (eventResult.isSuccess && eventResult.data!.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  ///
  /// 创建开奖日历提醒
  ///
  Future<bool> _createCalendarEvent() async {
    ///申请日历权限
    if (!(await _permissionIfAbsent())) {
      return false;
    }

    ///获取本地日历
    var result = await _calendarPlugin.retrieveCalendars();
    if (result.data == null || result.data!.isEmpty) {
      return false;
    }
    try {
      List<Calendar> calendars = result.data as List<Calendar>;
      Calendar calendar =
          calendars.firstWhere((e) => e.isReadOnly == null || !e.isReadOnly!);

      late TZDateTime start, end;
      Location location = getLocation('Asia/Shanghai');
      TZDateTime time = TZDateTime.now(location);
      if (time.hour > 20) {
        time = time.add(const Duration(days: 1));
      }
      start = TZDateTime(location, time.year, time.month, time.day, 20, 30);
      end = start.add(const Duration(hours: 1));

      ///日历提醒事件
      Event event = Event(calendar.id,

          ///开始时间
          start: start,

          ///结束时间
          end: end,

          ///提醒内容
          title: '【哇彩提醒】今日开奖时间马上到了，请您关注哟！',

          ///日程提醒加入跳转链接
          description: '哇彩推荐开奖日程提醒👉👉👉',

          ///提醒规则
          recurrenceRule: RecurrenceRule(
            frequency: Frequency.daily,
          ),

          ///到期10分钟前提醒
          reminders: [
            Reminder(minutes: 10),
          ]);

      ///创建日历事件
      Result<String>? response =
          await _calendarPlugin.createOrUpdateEvent(event);
      if (response != null && response.isSuccess) {
        String eventId = response.data!;
        ConfigStore().calendarHintEvent = eventId;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

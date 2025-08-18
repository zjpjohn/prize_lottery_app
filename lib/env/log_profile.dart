import 'package:logger/logger.dart';

///
/// 日志
///
final Logger logger = Logger(
  level: Level.info,
  filter: DevelopmentFilter(),
  printer: PrettyPrinter(),
);

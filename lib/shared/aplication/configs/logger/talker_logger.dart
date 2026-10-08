import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
final talkerInterceptor = TalkerDioLogger(
  talker: talker,
  settings: TalkerDioLoggerSettings(
    printResponseHeaders: true,
    printResponseRedirects: true,
    printRequestHeaders: true,
    printRequestData: true,
  ),
);

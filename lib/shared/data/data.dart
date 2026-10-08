import 'dart:async';

import 'package:baraka_pos/features/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../shared.dart';
import 'sources/local_sources.dart';

part 'dto/json_collection_dto.dart';
part 'dto/json_dto.dart';
part 'dto/json_paginated_collection_dto.dart';
part 'request/remote_request.dart';
part 'sources/dio_client.dart';
part 'sources/remoute_sources.dart';

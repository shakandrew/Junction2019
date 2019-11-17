import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:greenlist/blocs/init/index.dart';
import 'package:greenlist/services/api/challenge.dart';
import 'package:greenlist/services/api/index.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class InitEvent {
  Future<InitState> applyAsync({InitState state, InitBloc bloc});
}

class InitInitEvent extends InitEvent {
  @override
  Future<InitState> applyAsync({InitState state, InitBloc bloc}) async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (Platform.isAndroid)
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    else
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    Api().init(state.uuid);
    return InitState()
      ..inited = true
      ..uuid = state.uuid;
  }
}

class LoginInitEvent extends InitEvent {
  final int selectedMonths;
  LoginInitEvent(this.selectedMonths);
  @override
  Future<InitState> applyAsync({InitState state, InitBloc bloc}) async {
    String uuid = Uuid().v1();
    Api().init(uuid);
    await ChallengeApi.post(selectedMonths);
    return InitState()
      ..inited = true
      ..uuid = uuid;
  }
}

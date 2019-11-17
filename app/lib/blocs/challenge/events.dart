import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greenlist/blocs/challenge/index.dart';
import 'package:greenlist/services/api/challenge.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChallengeEvent {
  Future<ChallengeState> applyAsync({ChallengeState state, ChallengeBloc bloc});
}

class FetchChallengeEvent extends ChallengeEvent {
  @override
  Future<ChallengeState> applyAsync(
      {ChallengeState state, ChallengeBloc bloc}) async {
    var _state = await ChallengeApi.get();
    return ChallengeState.fromJson(_state);
  }
}

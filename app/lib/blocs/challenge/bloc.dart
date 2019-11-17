import 'dart:async';
import 'package:greenlist/blocs/challenge/index.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class ChallengeBloc extends HydratedBloc<ChallengeEvent, ChallengeState> {
  static final ChallengeBloc _challengeBlocSingleton =
      ChallengeBloc._internal();
  factory ChallengeBloc() => _challengeBlocSingleton;
  ChallengeBloc._internal();

  @override
  close() async {
    _challengeBlocSingleton.close();
    super.close();
  }

  @override
  ChallengeState get initialState {
    return super.initialState ?? ChallengeState();
  }

  @override
  Stream<ChallengeState> mapEventToState(ChallengeEvent event) async* {
    try {
      yield await event.applyAsync(state: state, bloc: this);
    } catch (_, stackTrace) {
      print(['ChallengeBloc', _, stackTrace]);
      yield state;
    }
  }

  @override
  ChallengeState fromJson(Map<String, dynamic> json) {
    return ChallengeState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ChallengeState state) {
    return state.toJson();
  }
}

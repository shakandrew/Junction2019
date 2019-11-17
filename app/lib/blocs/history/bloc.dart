import 'dart:async';
import 'package:greenlist/blocs/history/index.dart';

import 'package:bloc/bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  static final HistoryBloc _historyBlocSingleton = HistoryBloc._internal();
  factory HistoryBloc() => _historyBlocSingleton;
  HistoryBloc._internal();

  @override
  close() async {
    if (this != _historyBlocSingleton) _historyBlocSingleton.close();
    super.close();
  }

  @override
  HistoryState get initialState => HistoryState();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    try {
      yield await event.applyAsync(state: state, bloc: this);
    } catch (_, stackTrace) {
      print(['HistoryBloc', _, stackTrace]);
      yield state;
    }
  }
}

import 'dart:async';
import 'package:greenlist/blocs/greenList/index.dart';

import 'package:bloc/bloc.dart';

class GreenListBloc extends Bloc<GreenListEvent, GreenListState> {
  static final GreenListBloc _greenListBlocSingleton =
      GreenListBloc._internal();
  factory GreenListBloc() => _greenListBlocSingleton;
  GreenListBloc._internal();

  @override
  close() async {
    _greenListBlocSingleton.close();
    super.close();
  }

  @override
  GreenListState get initialState => GreenListState();

  @override
  Stream<GreenListState> mapEventToState(GreenListEvent event) async* {
    try {
      yield await event.applyAsync(state: state, bloc: this);
    } catch (_, stackTrace) {
      print(['GreenListBloc', _, stackTrace]);
      yield state;
    }
  }
}

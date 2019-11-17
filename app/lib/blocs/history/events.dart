import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greenlist/blocs/history/index.dart';
import 'package:greenlist/services/api/products.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent {
  Future<HistoryState> applyAsync({HistoryState state, HistoryBloc bloc});
}

class FetchHistoryEvent extends HistoryEvent {
  @override
  Future<HistoryState> applyAsync(
      {HistoryState state, HistoryBloc bloc}) async {
    var products = await ProductsApi.suggestions();
    return HistoryState()..products = products;
  }
}

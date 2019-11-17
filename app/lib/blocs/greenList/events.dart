import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greenlist/blocs/greenList/index.dart';
import 'package:greenlist/models/index.dart';
import 'package:greenlist/services/api/greenList.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GreenListEvent {
  Future<GreenListState> applyAsync({GreenListState state, GreenListBloc bloc});
}

class FetchGreenListEvent extends GreenListEvent {
  @override
  Future<GreenListState> applyAsync(
      {GreenListState state, GreenListBloc bloc}) async {
    var products = await GreenListApi.get();
    return GreenListState()..products = products;
  }
}

class AddProductGreenListEvent extends GreenListEvent {
  final Product product;
  AddProductGreenListEvent(this.product);
  @override
  Future<GreenListState> applyAsync(
      {GreenListState state, GreenListBloc bloc}) async {
    await GreenListApi.post(product.id, product.treesDifference);
    var products = await GreenListApi.get();
    return GreenListState()..products = products;
  }
}

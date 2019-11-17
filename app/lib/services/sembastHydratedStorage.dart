import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sembast/sembast.dart';
import 'dart:convert';

import 'database.dart';

class SembastHydratedStorage implements HydratedStorage {
  Map<String, String> store;

  load() async {
    this.store = {};
    var store = stringMapStoreFactory.store("blocs");
    List<RecordSnapshot> list = await store.find(DataBase.db);
    for (var r in list) {
      this.store[r.key] = json.encode(r.value);
    }
  }

  @override
  dynamic read(String key) {
    print(["read", key]);
    return this.store[key];
  }

  @override
  Future<void> write(String key, dynamic value) async {
    print(["write", key, value]);
    this.store[key] = value;
    var store = stringMapStoreFactory.store("blocs");
    store.record(key).put(DataBase.db, json.decode(value));
  }

  @override
  Future<void> delete(String key) async {
    print(["delete", key]);
    this.store.remove(key);
    var store = stringMapStoreFactory.store("blocs");
    store.record(key).delete(DataBase.db);
  }

  @override
  Future<void> clear() async {
    print(["clear"]);
    this.store = {};
    var store = stringMapStoreFactory.store("blocs");
    store.drop(DataBase.db);
  }
}

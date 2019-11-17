class InitState {
  bool inited = false;
  String uuid;
  InitState();

  InitState.fromJson(Map<String, dynamic> json) {
    inited = false;
    uuid = json["uuid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = uuid;
    return data;
  }
}

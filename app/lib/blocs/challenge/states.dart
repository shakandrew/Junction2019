class ChallengeState {
  String startTime;
  String endTime;
  int score;

  ChallengeState({this.startTime, this.endTime, this.score});

  ChallengeState.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['score'] = this.score;
    return data;
  }
}

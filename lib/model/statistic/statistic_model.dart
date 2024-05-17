class StatisticModel {
  String? date;
  String? elapsedTime;
  String? gameTitle;
  String? gameType;
  String? userName;

  StatisticModel(
      {this.date,
      this.elapsedTime,
      this.gameTitle,
      this.gameType,
      this.userName});

  StatisticModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    elapsedTime = json['elapsedTime'];
    gameTitle = json['gameTitle'];
    gameType = json['gameType'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['elapsedTime'] = this.elapsedTime;
    data['gameTitle'] = this.gameTitle;
    data['gameType'] = this.gameType;
    data['userName'] = this.userName;
    return data;
  }
}
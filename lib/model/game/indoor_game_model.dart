import 'base_game_model.dart';

class IndoorGameModel extends BaseGameModel {
  List<String>? qrList;
  List<String>? informations;

  IndoorGameModel({
    String? location,
    String? description,
    String? organizerName,
    String? title,
    this.qrList,
    this.informations,
  }) : super(
          location: location,
          description: description,
          organizerName: organizerName,
          title: title,
        );

  factory IndoorGameModel.fromJson(Map<String, dynamic> json) {
    return IndoorGameModel(
      location: json['location'],
      description: json['description'],
      organizerName: json['organizerName'],
      title: json['title'],
      informations: (json['informations'] != null)
          ? List<String>.from(json['informations'])
          : [],
      qrList: (json['qrList'] != null)
          ? List<String>.from(json['qrList'])
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['qrList'] = this.qrList;
    data['informations'] = this.informations;
    return data;
  }
}

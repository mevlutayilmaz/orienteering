import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  String? type;
  String? description;
  List<GeoPoint>? markers;
  String? organizerName;
  String? title;
  List<String>? markerInfo;
  List<String>? markerQuestion;
  List<String>? answerToQuestion;

  GameModel({
    this.type,
    this.description,
    this.markers,
    this.organizerName,
    this.title,
    this.markerInfo,
    this.markerQuestion,
    this.answerToQuestion,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      type: json['type'],
      description: json['description'],
      markers: (json['markers'] as List<dynamic>).map<GeoPoint>((marker) => marker as GeoPoint).toList(),
      organizerName: json['organizerName'],
      title: json['title'],
      markerInfo: (json['markerInfo'] != null) ? (json['markerInfo'] as List<dynamic>).map<String>((info) => info as String).toList() : [],
      markerQuestion: (json['markerQuestion'] != null) ? (json['markerQuestion'] as List<dynamic>).map<String>((info) => info as String).toList() : [],
      answerToQuestion: (json['answerToQuestion'] != null) ? (json['answerToQuestion'] as List<dynamic>).map<String>((info) => info as String).toList() : [],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    data['markers'] = this.markers?.map((marker) => marker).toList();
    data['organizerName'] = this.organizerName;
    data['title'] = this.title;
    data['markerInfo'] = this.markerInfo;
    data['markerQuestion'] = this.markerQuestion;
    data['answerToQuestion'] = this.answerToQuestion;
    return data;
  }
}

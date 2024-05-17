import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_game_model.dart';

class OutdoorGameModel extends BaseGameModel{
  List<GeoPoint>? markers;
  List<String>? markerInfo;

  OutdoorGameModel({
    String? location,
    String? description,
    String? organizerName,
    String? title,
    this.markers,
    this.markerInfo,
  }) : super(
          location: location,
          description: description,
          organizerName: organizerName,
          title: title,
        );

  factory OutdoorGameModel.fromJson(Map<String, dynamic> json) {
    return OutdoorGameModel(
      location: json['location'],
      description: json['description'],
      markers: (json['markers'] as List<dynamic>).map<GeoPoint>((marker) => marker as GeoPoint).toList(),
      organizerName: json['organizerName'],
      title: json['title'],
      markerInfo: (json['markerInfo'] != null) ? (json['markerInfo'] as List<dynamic>).map<String>((info) => info as String).toList() : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['markers'] = this.markers?.map((marker) => marker).toList();
    data['markerInfo'] = this.markerInfo;
    return data;
  }
}

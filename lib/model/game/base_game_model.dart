class BaseGameModel {
  String? location;
  String? description;
  String? organizerName;
  String? title;


  BaseGameModel({
    this.location,
    this.description,
    this.organizerName,
    this.title,
  });

  factory BaseGameModel.fromJson(Map<String, dynamic> json) {
    return BaseGameModel(
      location: json['location'],
      description: json['description'],
      organizerName: json['organizerName'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['description'] = this.description;
    data['organizerName'] = this.organizerName;
    data['title'] = this.title;
    return data;
  }
}

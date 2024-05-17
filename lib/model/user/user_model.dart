class UserModel {
  String? documentId;
  String? email;
  String? name;
  String? password;
  String? image;

  UserModel({this.documentId, this.email, this.name, this.password, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    image = json['image'];
  }

  UserModel.empty();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['image'] = this.image;
    return data;
  }
}
class User {
  int id;
  String authenticatoin;
  bool response;

  User({this.id,this.authenticatoin, this.response});

  User.fromJson(Map<String, dynamic> json) {
      id =json['id'];
    authenticatoin = json['Authenticatoin'];
    response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Authenticatoin'] = this.authenticatoin;
    data['Response'] = this.response;
    return data;
  }
}
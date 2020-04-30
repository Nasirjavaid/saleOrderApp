class LoginScreenLogoAndComapnyName {
  int id;
  String companyLogo;
  String companyName;

  LoginScreenLogoAndComapnyName({this.id, this.companyLogo, this.companyName});

  LoginScreenLogoAndComapnyName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyLogo = json['Company_Logo'];
    companyName = json['Company_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Company_Logo'] = this.companyLogo;
    data['Company_Name'] = this.companyName;
    return data;
  }
}
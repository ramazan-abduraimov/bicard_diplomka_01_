class UserModel {
  String? userName;
  String? email;
  String? phoneNumber;
  String? age;
  String? sex;
  String? photoPath;

  UserModel({this.userName,
    this.email,
    this.phoneNumber,
    this.age,
    this.sex,
    this.photoPath});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    age = json['age'].toString();
    sex = json['sex'];
    photoPath = json['photoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['photoPath'] = this.photoPath;
    return data;
  }
}



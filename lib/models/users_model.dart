class UserModel {
  String? userName;
  String? email;
  String? phoneNumber;
  String? birthDay;
  String? sex;
  String? photoPath;

  UserModel(
      {this.userName,
        this.email,
        this.phoneNumber,
        this.birthDay,
        this.sex,
        this.photoPath});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    birthDay = json['birthDay'];
    sex = json['sex'];
    photoPath = json['photoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['birthDay'] = this.birthDay;
    data['sex'] = this.sex;
    data['photoPath'] = this.photoPath;
    return data;
  }
}
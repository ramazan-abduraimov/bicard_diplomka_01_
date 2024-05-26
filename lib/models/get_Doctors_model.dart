class DoctorModel {
  int? id;
  String? name;
  String? speciality;
  String? bio;
  String? education;
  String? experience;
  String? pathToPhoto;
  String? phoneNumber;
  String? email;
  String? address;
  int? userId;

  DoctorModel(
      {this.id,
        this.name,
        this.speciality,
        this.bio,
        this.education,
        this.experience,
        this.pathToPhoto,
        this.phoneNumber,
        this.email,
        this.address,
        this.userId});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    speciality = json['speciality'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    pathToPhoto = json['pathToPhoto'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['pathToPhoto'] = this.pathToPhoto;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['userId'] = this.userId;
    return data;
  }
}
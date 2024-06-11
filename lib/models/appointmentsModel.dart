class AppointmentsModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? age;
  bool? isConfirmed;
  String? date;
  int? doctorId;
  int? userId;
  String? timeStamp;

  AppointmentsModel(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.age,
        this.isConfirmed,
        this.date,
        this.doctorId,
        this.userId,
        this.timeStamp});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    isConfirmed = json['isConfirmed'];
    date = json['date'];
    doctorId = json['doctorId'];
    userId = json['userId'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['age'] = this.age;
    data['isConfirmed'] = this.isConfirmed;
    data['date'] = this.date;
    data['doctorId'] = this.doctorId;
    data['userId'] = this.userId;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

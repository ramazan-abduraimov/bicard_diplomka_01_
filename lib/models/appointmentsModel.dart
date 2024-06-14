class AppointmentsModel {
  String? doctorPhoto;
  String? doctorName;
  String? doctorSpeciality;
  String? appointmentDate;
  bool? isConfirmed;

  AppointmentsModel(
      {this.doctorPhoto,
        this.doctorName,
        this.doctorSpeciality,
        this.appointmentDate,
        this.isConfirmed});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    doctorPhoto = json['doctorPhoto'];
    doctorName = json['doctorName'];
    doctorSpeciality = json['doctorSpeciality'];
    appointmentDate = json['appointmentDate'];
    isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorPhoto'] = this.doctorPhoto;
    data['doctorName'] = this.doctorName;
    data['doctorSpeciality'] = this.doctorSpeciality;
    data['appointmentDate'] = this.appointmentDate;
    data['isConfirmed'] = this.isConfirmed;
    return data;
  }
}

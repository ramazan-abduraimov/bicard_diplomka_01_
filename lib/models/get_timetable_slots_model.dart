class GetTimesModels {
  String? date;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  List<Timeslots>? timeslots;

  GetTimesModels(
      {this.date,
        this.dayOfWeek,
        this.startTime,
        this.endTime,
        this.timeslots});

  GetTimesModels.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    if (json['timeslots'] != null) {
      timeslots = <Timeslots>[];
      json['timeslots'].forEach((v) {
        timeslots!.add(Timeslots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['dayOfWeek'] = dayOfWeek;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (timeslots != null) {
      data['timeslots'] = timeslots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeslots {
  String? time;
  String? status;

  Timeslots({this.time, this.status});

  Timeslots.fromJson(Map<String, dynamic> json) {
    time = json['Time'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Time'] = time;
    data['Status'] = status;
    return data;
  }
}
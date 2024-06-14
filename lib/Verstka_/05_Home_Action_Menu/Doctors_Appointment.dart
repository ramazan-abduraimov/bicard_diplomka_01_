import 'package:bicard_diplomka_01_/api_service/api_service.dart';
import 'package:bicard_diplomka_01_/models/appointmentsModel.dart';
import 'package:flutter/material.dart';

class DoctorsAppointment extends StatefulWidget {
  const DoctorsAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorsAppointment> createState() => _DoctorsAppointmentState();
}

class _DoctorsAppointmentState extends State<DoctorsAppointment> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Менин жазылууларым ")),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 25, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: selectedIndex == 1
                                ? Border(bottom: BorderSide(width: 2))
                                : null,
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Text('Кутуудомун'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: selectedIndex == 0
                                ? Border(bottom: BorderSide(width: 2))
                                : null,
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Text('Жазылдым'),
                          ),
                        ),
                      ),

                    ],
                  ),
                  selectedIndex == 0
                      ? Uncoming() // green
                      : selectedIndex == 1
                      ? CompletedContainer() //yellow
                      : SizedBox(), // Show IncomingContainer if selectedIndex is 0
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Uncoming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().appointmentsModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No appointments available'),
          );
        }

        List<AppointmentsModel> allDoctorsList = snapshot.data ?? [];
        List<AppointmentsModel> confirmedDoctorsList = allDoctorsList.where((doctor) => doctor.isConfirmed == true).toList();

        if (confirmedDoctorsList.isEmpty) {
          return Center(
            child: Text('No confirmed appointments available'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            AppointmentsModel doctor = confirmedDoctorsList[index];

            return Container(
              // Customize your container here
              width: 342,
              height: 250,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[100], //.fromRGBO(243, 244, 246, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.appointmentDate ?? "Time",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400),
                          top: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // Adjust the border radius as needed
                            child: Container(
                              width: 100,
                              // Adjust the width and height as needed to make it square
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: 2.0),
                                // Border details
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Image.network(
                                "${ApiService.IPAdres}/TempFileStorage/${doctor.doctorPhoto}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 18.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                doctor.doctorName ??
                                "Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                doctor.doctorSpeciality ??
                                "Speciality",
                                style: TextStyle(fontSize: 16.0),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "позвоните, чтобы отменить или перенести дату",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    // Add more appointment details as needed
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: confirmedDoctorsList.length,
        );
      },
    );
  }
}


class CompletedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().appointmentsModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No appointments available'),
          );
        }

        List<AppointmentsModel> allDoctorsList = snapshot.data ?? [];
        List<AppointmentsModel> confirmedDoctorsList = allDoctorsList.where((doctor) => doctor.isConfirmed == false).toList();

        if (confirmedDoctorsList.isEmpty) {
          return Center(
            child: Text('No confirmed appointments available'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            AppointmentsModel doctor = confirmedDoctorsList[index];

            return Container(

              // Customize your container here
              width: 342,
              height: 250,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.appointmentDate ?? "tima",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                            color: Colors.grey.shade400),
                            top: BorderSide(color: Colors.grey.shade400)),
                      ),
                      child: Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // Adjust the border radius as needed
                          child: Container(
                            width: 100,
                            // Adjust the width and height as needed to make it square
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white, width: 2.0),
                              // Border details
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.network(
                              "${ApiService.IPAdres}/TempFileStorage/${doctor.doctorPhoto}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 18.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(doctor.doctorName ?? "Name", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                            Text( doctor.doctorSpeciality ?? "Speciality",
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Text("Пожалуйста, подождите, пока мы свяжемся с вами",
                        style: TextStyle(fontSize: 16.0)),

                    // Add more appointment details as needed
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: confirmedDoctorsList.length,
        );
      },
    );
  }
}


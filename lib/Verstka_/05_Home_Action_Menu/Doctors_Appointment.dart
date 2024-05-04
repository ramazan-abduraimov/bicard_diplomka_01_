import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Doctor_Details.dart';
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
        title: Center(child: Text("Мои заказы ")),
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
                            child: Text('свяжитесь с вами'),
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
                            child: Text('Предстоящий'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: selectedIndex == 2
                                ? Border(bottom: BorderSide(width: 2))
                                : null,
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            child: Text('Отмененный'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  selectedIndex == 0
                      ? Uncoming()
                      : selectedIndex == 1
                      ? CompletedContainer()
                      : selectedIndex == 2
                      ? CanceledContainer()
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

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>DoctorDetailsScreen(doctorInfo: doctorinfo, reviews: reviews, ),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' May 22, 2023 - 10.00 AM',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400),top: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                  child: Container(
                    width: 100, // Adjust the width and height as needed to make it square
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2.0), // Border details
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset("asset/images/DoctorImage.png"),
                  ),
                ),
                SizedBox(width: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text("Dr. James Robinson", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                    Text("Orthopedic Surgery", style: TextStyle(fontSize: 16.0)),
                    Text("Elite Ortho Clinic, USA", style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ],
              ),
            ),
            Text("позвоните, чтобы отменить или перенести дату",style: TextStyle(fontSize: 16.0)),

            // Add more appointment details as needed
          ],
        ),
      ),
    );
  }
}

class CompletedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>DoctorDetailsScreen(doctorInfo: doctorinfo, reviews: reviews, ),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' May 22, 2023 - 10.00 AM',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400),top: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                  child: Container(
                    width: 100, // Adjust the width and height as needed to make it square
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2.0), // Border details
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset("asset/images/DoctorImage.png"),
                  ),
                ),
                SizedBox(width: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text("Dr. James Robinson", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                    Text("Orthopedic Surgery", style: TextStyle(fontSize: 16.0)),
                    Text("Elite Ortho Clinic, USA", style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ],
              ),
            ),
            Text("Пожалуйста, подождите, пока мы свяжемся с вами",style: TextStyle(fontSize: 16.0)),

            // Add more appointment details as needed
          ],
        ),
      ),
    );
  }
}

class CanceledContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      // Customize your container here
      width: 342,
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red[100],
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

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>DoctorDetailsScreen(doctorInfo: doctorinfo, reviews: reviews, ),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' May 22, 2023 - 10.00 AM',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400),top: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                  child: Container(
                    width: 100, // Adjust the width and height as needed to make it square
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2.0), // Border details
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset("asset/images/DoctorImage.png"),
                  ),
                ),
                SizedBox(width: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text("Dr. James Robinson", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                    Text("Orthopedic Surgery", style: TextStyle(fontSize: 16.0)),
                    Text("Elite Ortho Clinic, USA", style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ],
              ),
            ),
            Text("Ваш запрос отклонен",style: TextStyle(fontSize: 16.0)),

            // Add more appointment details as needed
          ],
        ),
      ),
    );
  }
}

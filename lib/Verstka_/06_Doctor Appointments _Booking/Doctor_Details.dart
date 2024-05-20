import 'package:bicard_diplomka_01_/Verstka_/06_Doctor%20Appointments%20_Booking/Book_Appointment.dart';
import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialization;
  final String clinic;
  final String location;
  final double rating;
  final int reviews;
  final String about;
  final String workingHours;

  Doctor({
    required this.name,
    required this.specialization,
    required this.clinic,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.about,
    required this.workingHours,
  });
}

class Review {
  final String reviewerName;
  final double rating;
  final String reviewText;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.reviewText,
  });
}

// Simulated doctor data
final doctorinfo = Doctor(
  name: 'Док Дэвид Патель',
  specialization: 'Кардиолог',
  clinic: 'Золотой кардиологический центр',
  location: 'Золотые ворота, СТОЛИЦА',
  rating: 5.0,
  reviews: 1872,
  about: 'Доктор Дэвид Патель, специалист по кардиологии, обладает богатым опытом работы в кардиологическом центре Golden Gate в Голден Гейт, Калифорния. подробнее',
  workingHours: 'Понедельник-пятница, с 08:00 до 18:00',
);

// Simulated review data
final reviews = [
  Review(
    reviewerName: 'Emily Anderson',
    rating: 5.0,
    reviewText: 'Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to anyone seeking excellent cardiac care.',
  ),
  // Add more reviews as needed
];

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctorInfo;
  final List<Review> reviews;

  DoctorDetailsScreen({required this.doctorInfo, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details"),
        // Add back button and heart icon as needed
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Information Section
              Container(
                width: 380,
                height: 120,
                child: Material(
                  elevation: 5.0, // Adjust the elevation as needed
                  shadowColor: Colors.grey, // Adjust the shadow color as needed
                  borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        child: Container(
                          width: 100, // Adjust the width and height as needed to make it square
                          height: 100,
                          child: Image.asset("asset/images/DoctorImage.png"),
                        ),
                      ),
                      SizedBox(width: 18.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text(doctorinfo.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                          Text(doctorinfo.specialization, style: TextStyle(fontSize: 16.0)),
                          Text(doctorinfo.clinic, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20.0),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                          radius: 30,
                          child: Icon(Icons.people)),
                      Text('2,000+', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      Text('пациенты',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                          radius: 30,
                          child: Icon(Icons.workspace_premium_sharp)),
                      Text('10+', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      Text('опыт',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                          radius: 30,
                          child: Icon(Icons.star)),
                      Text('${doctorinfo.rating}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      Text('rating',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                          radius: 30,
                          child: Icon(Icons.chat)),
                      Text('${doctorinfo.reviews}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      Text('reviews',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              // About Me Section
              Text('Обо мне ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 8.0),
              Text(doctorinfo.about),
              // Add "View More" functionality if needed

              SizedBox(height: 20.0),

              // Working Time Section
              Text('Рабочее время ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 8.0),
              Text(doctorinfo.workingHours),

              SizedBox(height: 20.0),

              // Reviews Section
              Text('Обзоры', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 8.0),
              // Display reviews (implement as described above)

              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(28, 42, 58, 1),
                    ),
                    foregroundColor:
                    MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(380, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DateTimePicker()));
                  },
                  child: Text(
                    "Запишитесь на прием ",
                    style: TextStyle(fontSize: 18),
                  ),),

            ],
          ),
        ),
      ),
    );
  }
}
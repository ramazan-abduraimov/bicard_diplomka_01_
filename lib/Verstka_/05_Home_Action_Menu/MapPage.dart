import 'package:bicard_diplomka_01_/Verstka_/proba.dart';
import 'package:flutter/material.dart';



class Doctor {
  final String name;
  final String specialization;
  final String clinic;
  final String location;
  final double rating;
  final int reviews;

  Doctor({
    required this.name,
    required this.specialization,
    required this.clinic,
    required this.location,
    required this.rating,
    required this.reviews,
  });
}

List<Doctor> doctors = [
  Doctor(
    name: 'Dr. David Patel',
    specialization: 'Cardiologist',
    clinic: 'Cardiology Center',
    location: 'USA',
    rating: 5.0,
    reviews: 1872,
  ),
  Doctor(
    name: 'Dr. Sarah Lee',
    specialization: 'Dermatologist',
    clinic: 'Skin Care Clinic',
    location: 'Canada',
    rating: 4.8,
    reviews: 1425,
  ),
  // Add more doctors here
];

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String _selectedSpecialization = "All";

  @override
  Widget build(BuildContext context) {
    List<Doctor> filteredDoctors = _selectedSpecialization == "All"
        ? doctors
        : doctors.where((doctor) => doctor.specialization == _selectedSpecialization).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("All Doctors"),
        // Add back button and styling as needed
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search doctor...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                label: Text("All"),
                selected: _selectedSpecialization == "All",
                onSelected: (selected) {
                  setState(() {
                    _selectedSpecialization = "All";
                  });
                },
              ),
              FilterChip(
                label: Text("Cardiologist"),
                selected: _selectedSpecialization == "Cardiologist",
                onSelected: (selected) {
                  setState(() {
                    _selectedSpecialization = "Cardiologist";
                  });
                },
              ),
              FilterChip(
                label: Text("Dermatologist"),
                selected: _selectedSpecialization == "Dermatologist",
                onSelected: (selected) {
                  setState(() {
                    _selectedSpecialization = "Dermatologist";
                  });
                },
              ),
              // Add more filter chips for other specializations
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) => DoctorItem(doctor: filteredDoctors[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorItem({Key? key, required this.doctor}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: (){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>DoctorDetailsScreen(doctorInfo: doctorinfo, reviews: reviews, ),));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('assets/doctor_avatar.png'), // Replace with actual image
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(doctor.specialization),
                    Text('${doctor.clinic}, ${doctor.location}'),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Text('${doctor.rating} (${doctor.reviews})'),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
          
                }, // Add favorite functionality
              ),
            ],
          ),
        ),
      ),
    );
  }
}

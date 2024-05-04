import 'package:bicard_diplomka_01_/Verstka_/05_Category_/Hospitalization.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Cardiology.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Hospitalization.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Microsurgery.dart';
import 'package:bicard_diplomka_01_/Verstka_/05_Info_Category/Info_Surgery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLocation = 'Bishkek, Kyrgyzstan';

  List<String> locations = [
    'Bishkek, Kyrgyzstan',
    'Москва',
    'Париж',
    'Нью-Йорк'
  ];

  double FotoSize = 85;
  void _navigateToDetailPage(BuildContext context, int index) {
    // Depending on the index, navigate to different detail pages
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoCardiology()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  InfoHospitolization()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoMicrosurgery()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoSurgery()));
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "asset/images/lokation.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                });
                              },
                              items: locations
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                            SizedBox(
                              width: 95,
                            ),
                            Positioned(
                              top: 20.0,
                              right: 20.0,
                              child: Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor:
                                    Color.fromRGBO(243, 244, 246, 1),
                                    child: Icon(
                                      Icons.notifications_active_rounded,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          filled: true, // Fill the background with color
                          fillColor: Color.fromRGBO(243, 244, 246, 1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(243, 244, 246, 1),
                            ), // Border color
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(156, 163, 175, 1),
                          ),
                          labelText: "Search doctor...",
                          labelStyle:
                          TextStyle(color: Color.fromRGBO(156, 163, 175, 1)))),
                  SizedBox(
                    height: 15,
                  ),
                  CarouselSlider.builder(
                    itemCount: 4,
                    options: CarouselOptions(
                      height: 220.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      onPageChanged: (index, reason) {},
                    ),
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      List<String> imagePaths = [
                        "asset/images/HospitalizationCategory.png",
                        "asset/images/CardiologyCategory.jpg",
                        "asset/images/MicrosurgeryCategory.jpg",
                        "asset/images/SurgeryCategory.jpg",
                      ];

                      return Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            _navigateToDetailPage(context, index); // Navigate to detail page
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: 800,
                                color: Colors.transparent,
                                child: Image.asset(
                                  imagePaths[index], // Selecting image based on index
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 20,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text("4.8"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 10,
                      child: Text("Category Doctors")),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Hospitalization(),
                              ));
                            },
                            child: Container(
                              width: FotoSize,
                              height: FotoSize,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, width: 2.0), // Border details
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Image.asset("asset/images/Image1.png"),
                            ),
                          ),
                          Text(
                            'Госпит.. ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: FotoSize,
                            height: FotoSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 2.0), // Border details
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset("asset/images/Image1.png"),
                          ),
                          Text(
                            'Кардиолог..',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: FotoSize,
                            height: FotoSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 2.0), // Border details
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset("asset/images/Image1.png"),
                          ),
                          Text(
                            'Микрохир..',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: FotoSize,
                            height: FotoSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 2.0), // Border details
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset("asset/images/Image1.png"),
                          ),
                          Text(
                            'Хирургия',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("last News"),
                  Container(
                    height: 200, // Set a height for the container
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: List.generate(
                            10,
                                (index) => Container(
                              width: 350,
                              height: 200,
                              margin: EdgeInsets.all(8),
                              color: Colors.primaries[index % Colors.primaries.length],
                              child: Center(child: Text('Item ${index + 1}')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

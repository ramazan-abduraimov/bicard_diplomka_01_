
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLocation = 'Bishkek, Kyrgyzstan';

  List<String> locations = [
    'Bishkek, Kyrgyzstan',
    'Москва',
    'Париж',
    'Нью-Йорк'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 5, 0),
              child: Column(children: [
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
                            items: locations.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          ),
                          SizedBox(width: 95,),
                          Positioned(
                            top: 20.0,
                            right: 20.0,
                            child: Container(
                              child: TextButton(
                                  onPressed: () {},
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                                    child: Icon(Icons.notifications_active_rounded,size: 25,),

                                  ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ), // Уведомления (вверх на право)
                CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    height: 220.0,
                    autoPlay: true,

                    autoPlayInterval: Duration(seconds: 5),
                    onPageChanged: (index, reason) {},

                  ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => MehanicPage()));
                      },
                      child: Stack(

                        children: [
                          Container(
                              height: 200,

                              color: Colors.transparent,

                              child: Stack(
                                children: [
                                  Image.asset(
                                    "asset/images/CoruselImage.png",
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              )),
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.7)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text("4.8")
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 140,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.7)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/logo_2.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  Text("   Auto service")
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 200,
                            top: 140,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.7)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/marker (1) 1.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  Text("  3.2km")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],),
            ),
          ),
        ),
      ),
    );
  }
}

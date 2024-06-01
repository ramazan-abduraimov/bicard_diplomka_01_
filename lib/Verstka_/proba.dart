// class All extends StatelessWidget {
//   const All({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: ApiService().fetchDoctorsList(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<DoctorModel> allDoctorsList = snapshot.data ?? [];
//             return ListView.separated(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 DoctorModel doctor = allDoctorsList[index];
//                 return Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                   width: 380,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0, 2),
//                           blurRadius: 4),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DoctorDetailsScreen(
//                                   doctorInfo: doctorinfo,
//                                   reviews: reviews,
//                                 ),
//                               ));
//                         },
//                         child: Container(
//                           color: Colors.transparent,
//                           width: 380,
//                           height: 120,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 // Adjust the border radius as needed
//                                 child: Container(
//                                   width: 100,
//                                   // Adjust the width and height as needed to make it square
//                                   height: 100,
//                                   child: Image.network("http://192.168.50.226:5297/TempFileStorage/${doctor.pathToPhoto}" ??
//                                       "asset/images/DoctorImage.png"),
//                                 ),
//                               ),
//                               SizedBox(width: 18.0),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(doctor.name ?? "Бош",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20.0)),
//                                     Text(doctor.speciality ?? " Bosh",
//                                         style: TextStyle(fontSize: 16.0)),
//                                     Text(doctor.phoneNumber ?? "bosh",
//                                         style: TextStyle(
//                                             fontSize: 14.0, color: Colors.grey)),
//                                   ],
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child:  Column(
//                           children: [
//                             GestureDetector(
//                                 child: SizedBox(
//                                   width: 35,
//                                   height: 35,
//                                   child: Icon(
//                                     Icons.favorite_outline,
//                                     size: 35,
//                                   ),
//                                 )),
//                             Text(doctor.id.toString() ?? "ertgr" ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return SizedBox(
//                   height: 10,
//                 );
//               },
//               itemCount: allDoctorsList.length,
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           return SizedBox();
//         });
//   }
// }

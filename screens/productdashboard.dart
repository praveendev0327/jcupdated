// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:justcall/screens/editproduct.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class ProductDashboard extends StatefulWidget {
//   const ProductDashboard({super.key});
//
//   @override
//   State<ProductDashboard> createState() => _ProductDashboardState();
// }
//
// class _ProductDashboardState extends State<ProductDashboard> {
//   bool? _selectedGenderCheck = false;
//   String? _selectedSubGroup = "VEGETABLE" ;
//   final List<String> _dropdownGender = [];
//   late List<dynamic> _productsFuture = [];
//   @override
//   void initState() {
//     fetchAllSubGroupData();
//     fetchCategoryList();
//   }
//
//   void fetchAllSubGroupData() async{
//
//     try {
//       // final Data = {
//       //   "SubGroupName" :  _selectedSubGroup
//       // };
//       final response = await http.get(
//         Uri.parse("https://justcalltest.onrender.com/api/users/allCategoryList/${_selectedSubGroup}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         // body: jsonEncode(Data),
//       );
//
//       if (response.statusCode == 200) {
//         // Successfully sent data
//         // print('Data sent successfully');
//         final fetch = json.decode( response.body);
//         // print('login fetch : ${fetch }');
//
//         final subGroupList = fetch["data"];
//         setState(() {
//           _productsFuture = subGroupList;
//         });
//
//         // print('All Data from sub group : ${fetch["data"]}');
//       } else {
//         // Error occurred while sending data
//         print('Failed to send data: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Exception occurred
//       print('Exception occurred: $e');
//     }
//
//   }
//
//   void fetchCategoryList() async{
//
//     try {
//
//       final response = await http.get(
//         Uri.parse("https://justcalltest.onrender.com/api/users/subGroupList"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//
//       );
//
//       if (response.statusCode == 200) {
//         // Successfully sent data
//         // print('Data sent successfully');
//         final fetch = json.decode( response.body);
//         // print('login fetch : ${fetch[0] }');
//
//         final subGroupList = fetch["data"];
//         for(var item in subGroupList) {
//           setState(() {
//             _dropdownGender.add(item["SubGroup"]);
//           });
//         }
//
//         // print('login successfully : ${_dropdownGender }');
//       } else {
//         // Error occurred while sending data
//         print('Failed to send data: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Exception occurred
//       print('Exception occurred: $e');
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     double widthSize = screenSize.width;
//     double heightSize = screenSize.height;
//     bool isMobile = MediaQuery.of(context).size.width < 900;
//
//     void logoutUser() async {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('login', "0");
//       context.go("/");
//     }
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MouseRegion(
//                       child: Container(
//                         // color: Colors.grey,
//                         child: GestureDetector(
//                           onTap: () {
//                             // context.go('/');
//                           },
//                           child: isMobile ?
//                           Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,)
//                               : Center(
//                             child: Text("JUSTCALL",
//                                 style: GoogleFonts.josefinSans(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   decoration: TextDecoration.none,
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     // context.go('/profile');
//                     //     setState(() {
//                     //       screen = 3 ;
//                     //     });
//                     //   },
//                     //   child: Center(
//                     //     child: Icon(
//                     //       Icons.menu,
//                     //       size: 26.0,
//                     //       color: Colors.green,
//                     //     ),
//                     //   ),
//                     // ),
//                     GestureDetector(
//                       onTap : () {
//                         logoutUser();
//                     },
//                       child: Container(
//                         child: Text("Logout",
//                             style: GoogleFonts.josefinSans(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.deepOrange,
//                               decoration: TextDecoration.none,
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 250,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // productDialog(context);
//
//                         Map<String, dynamic> updatedData = {
//                           'name': "",
//                           'description': "",
//                           'productType': "",
//                           // 'gender':_productsFuture![index]["Product Name"],
//                           // 'category' : product.category,
//                           // 'color' : product.color,
//                           // 'role' : product.role,
//                         };
//
//                         // if (product.imageUrls != null && product.imageUrls!.isNotEmpty) {
//                         //   List<String> imageUrls = product.imageUrls!;
//                         //   updatedData['imageUrls'] = imageUrls;
//                         // }
//                         // editProductDialog(context,"0", updatedData);
//                         context.go("/addproduct");
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                               0), // Set the border radius to 0 for a rectangular shape
//                         ),
//                         backgroundColor: Colors.green,
//                       ),
//                       child: Text(
//                         "Add Offer Product",
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       setState(() {
//                         // screen = 0 ;
//                         fetchAllSubGroupData();
//                       });
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         FaIcon(
//                           FontAwesomeIcons.refresh,
//                           size: 18,
//                           color: Colors.green,
//                         ),
//                         Text("Home",
//                           style: GoogleFonts.poppins(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   DropdownButton<String>(
//                     hint: Text('Category',style: TextStyle(color: _selectedGenderCheck == false ?Colors.black : Colors.red),),
//                     value: _selectedSubGroup,
//                     padding: EdgeInsets.all(10),
//                     items: _dropdownGender.map((String item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedSubGroup = newValue!;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 40,
//                       width: 150,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // productDialog(context);
//                           fetchAllSubGroupData();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 0), // Set the border radius to 0 for a rectangular shape
//                           ),
//                           backgroundColor: Colors.deepOrangeAccent,
//                         ),
//                         child: Text(
//                           "Search",
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     width: 30,
//                     child: Center(
//                       child: Text("S.No",style: GoogleFonts.josefinSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                         decoration: TextDecoration.none,
//                       )),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//
//                     },
//                     child: Container(
//                       width: 100,
//                       child: Center(
//                         child: Text("Name",style: GoogleFonts.josefinSans(
//                         fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                           decoration: TextDecoration.none,
//                         )),
//                       ),
//                     ),
//                   ),
//                   // Container(
//                   //   width: 100,
//                   //   child: Text("Price",style: GoogleFonts.josefinSans(
//                   //     fontSize: 16.sp,
//                   //     fontWeight: FontWeight.bold,
//                   //     color: Colors.green,
//                   //     decoration: TextDecoration.none,
//                   //   )),
//                   // ),
//                   Container(
//                     width: 100,
//                     child: Center(
//                       child: Text("Image",style: GoogleFonts.josefinSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                         decoration: TextDecoration.none,
//                       )),
//                     ),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Center(
//                       child: Text("Edit",style: GoogleFonts.josefinSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                         decoration: TextDecoration.none,
//                       )),
//                     ),
//                   ),
//
//                 ],
//               ),
//               _productsFuture == null ? CircularProgressIndicator() :
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _productsFuture!.length,
//                   itemBuilder: (context, index) {
//                     int serialNumber = index + 1;
//                     return Container(
//                       margin: EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             width: 30,
//                               child: Text('${serialNumber}',style: GoogleFonts.josefinSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 decoration: TextDecoration.none,
//                               )),
//
//                           ),
//                           Container(
//                             width: 100,
//                             child: Text(_productsFuture![index]["Product Name"] as String,style: GoogleFonts.josefinSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 decoration: TextDecoration.none,
//                               )),
//
//                           ),
//                           // Container(
//                           //   width: 100,
//                           //   child: Text("Price",style: GoogleFonts.josefinSans(
//                           //     fontSize: 16.sp,
//                           //     fontWeight: FontWeight.bold,
//                           //     color: Colors.green,
//                           //     decoration: TextDecoration.none,
//                           //   )),
//                           // ),
//                           Container(
//                             width: 100,
//                             child: _productsFuture![index]["image"] != null
//                                 ?
//
//                             Image.memory(base64Decode(_productsFuture![index]["image"]!.contains(',')  ? _productsFuture![index]["image"].split(',')[1] : _productsFuture![index]["image"]),
//                             // Image.network( "https://justcalltest.onrender.com/productimages/${_productsFuture![index]["img"]}",
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   width: 50,
//                                   height: 50,
//                                   color: Colors.grey,
//                                   child: Center(
//                                     child: Icon(Icons.broken_image),
//                                   ),
//                                 );
//                               },
//                             )
//                                 : Container(
//                               width: 100,
//                               height: 50,
//                               color: Colors.grey,
//                               child: Center(
//                                 child: Text('No image',style: GoogleFonts.josefinSans(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   decoration: TextDecoration.none,
//                                 )),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 100,
//                             child: Center(
//                               child: GestureDetector(
//                                 onTap: (){
//                                   Map<String, dynamic> updatedData = {
//                                     'name': _productsFuture![index]["Product Name"],
//                                     'description': _productsFuture![index]["Price 1"],
//                                     'productType': _productsFuture![index]["Barcode"],
//                                     'img' : _productsFuture![index]["image"]
//                                     // 'gender':_productsFuture![index]["Product Name"],
//                                     // 'category' : product.category,
//                                     // 'color' : product.color,
//                                     // 'role' : product.role,
//                                   };
//
//                                   // if (product.imageUrls != null && product.imageUrls!.isNotEmpty) {
//                                   //   List<String> imageUrls = product.imageUrls!;
//                                   //   updatedData['imageUrls'] = imageUrls;
//                                   // }
//                                   editProductDialog(context,_productsFuture![index]["Barcode"], updatedData);
//                                 },
//                                 child: Text("Edit",style: GoogleFonts.josefinSans(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green,
//                                   decoration: TextDecoration.none,
//                                 )),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//
//             ],
//           ),
//       ),
//     );
//   }
// }
//
// Future<dynamic> editProductDialog(BuildContext context,String id, Map<String, dynamic> updatedData) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//           content: SingleChildScrollView(
//             child: Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.height * 0.70,
//                 child:
//                 EditProduct(productId: id, currentProductData: updatedData,)
//             ),
//           )); // Custom widget for dress details
//     },
//   );
// }
//

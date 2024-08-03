import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/constants/collections.dart';
import 'package:justcall/hover/onhover.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/middleware/events.dart';
import 'package:justcall/modals/products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<JcProductListData> collectionListData  = CollectionConstants.productConstants;

  void _incrementQuantity(int index) {
    // print("object ${collectionListData[index].qty++}" );
    setState(() {
      collectionListData[index].qty ++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (collectionListData[index].qty! > 0) {
        collectionListData[index].qty --;
        print("object ${collectionListData[index].qty--}" );
      }
    });
  }

  Future<void> sendJsonData(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.post(
        Uri.parse("https://justcalltest.onrender.com/api/users/createItemPurchase"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        // print('Data sent successfully');
      } else {
        // Error occurred while sending data
        // print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      // print('Exception occurred: $e');
    }
  }

  void _sendMessage() async {
    String phoneNumber = '+971506279715'; // Replace with your phone number
    String message = 'Hello from Flutter!'; // Your message
    // Filter products where quantity is not equal to 0
    List<JcProductListData> filteredProducts = collectionListData.where((product) => product.qty != 0).toList();

    // Convert the filtered list to a text variable
    String filteredText = filteredProducts.map((product) => '${product.name} - Quantity: ${product.qty} - Price: ${product.price},').join('\n');

    final details = {
      "items" : Uri.encodeFull(filteredText)
    };

    await sendJsonData(details);
    // Encode the message to handle special characters
    String url = 'https://wa.me/$phoneNumber/?text= Order List : ${Uri.encodeFull(filteredText)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 750;
    final int maxItems = 8;


    return Container(
      // color: Color(0xFFE0FBE2),
      height: MediaQuery.of(context).size.height * 0.89,
      child:
      Stack(
          children: [
            Positioned(
              width: widthSize,
              top: 20,
              left: 20,
              child: GestureDetector(
              onTap: (){
                context.go('/');
              },
              child: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                size: 24,
                color: Colors.green,
              )
            ),),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.only(top: 60),
                child: Column(

                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Container(),
                    //     Text("Our Collections",
                    //       style: GoogleFonts.pacifico(
                    //         fontSize : 35.sp ,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.grey,
                    //         decoration: TextDecoration.none,
                    //       ),
                    //     ),
                    //     OnHover(
                    //     builder: (isHovered) {
                    //       return
                    //       MouseRegion(
                    //         cursor: SystemMouseCursors.click,
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             // Navigator.push(
                    //             //   context,
                    //             //   MaterialPageRoute(builder: (context) =>
                    //             //       Filter()
                    //             //   ),
                    //             // );
                    //           },
                    //           child: Text("Filter",
                    //             style: GoogleFonts.teko(
                    //               fontSize: 25.sp,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.green,
                    //               decoration: TextDecoration.none,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widthSize < 600 ? 3 : widthSize < 1120 ? 4 :   6,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: isMobile ? 1.2 / 3 : 2/3,
                        ),
                        // itemCount: collectionListData.length  > maxItems ? maxItems : collectionListData.length,
                        itemCount: collectionListData.length  ,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            // Expanded(
                            // child:
                            OnHover(
                                builder: (isHovered) {
                                  return
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(

                                        margin: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 80),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // color: Color(int.parse(collectionListData[index].back as String)),
                                          // color: Color(0xFFE1F0DA),
                                          // color: Color(0xFFFFFFFF),
                                        ),
                                        // height: heightSize * 0.65,
                                        // width: widthSize * 0.35,

                                        child:
                                        Center(
                                          child:
                                          Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [


                                                      // Container(
                                                      //   color: Colors.blueGrey,
                                                      //   height: heightSize * 0.04,
                                                      //   width: widthSize,
                                                      //   child: Text("34.99",
                                                      //     textAlign: TextAlign.right,
                                                      //     style: GoogleFonts.teko(
                                                      //       fontSize: widthSize * 0.040,
                                                      //       fontWeight: FontWeight.w500,
                                                      //       color: Colors.black,
                                                      //       decoration: TextDecoration.none,
                                                      //
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        child: Container(
                                                            height: isMobile ? heightSize * 0.2 : heightSize * 0.3,
                                                            // width: widthSize,
                                                            // color: Color(0xFFE0FBE2),
                                                            child: Image.asset(
                                                              collectionListData[index].img as String,
                                                              fit: BoxFit.contain,)),
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Container(
                                                        // color: Colors.blueGrey,
                                                        height: isMobile ? heightSize * 0.06 : heightSize * 0.1,
                                                        width: widthSize,
                                                        child: Text(collectionListData[index].name as String,
                                                          style: GoogleFonts.roboto(
                                                            fontSize: isMobile ? 12 : 16,
                                                            fontWeight: isMobile ?FontWeight.w500 :  FontWeight.bold,
                                                            color: Colors.black,
                                                            decoration: TextDecoration.none,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 20,
                                                        width: 150,
                                                        child: Center(
                                                          child: Text("${collectionListData[index].price} AED",
                                                            style: GoogleFonts.teko(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.deepOrange,
                                                              decoration: TextDecoration.none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(Icons.remove),
                                                            color: Colors.red,
                                                            onPressed:  () => _decrementQuantity(index),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                            // color: Colors.blueGrey,
                                                            child: Text(
                                                                '${collectionListData[index].qty}',
                                                                style: GoogleFonts.roboto(
                                                                  fontSize: 18.sp,

                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.black,
                                                                  decoration: TextDecoration.none,
                                                                )
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons.add),
                                                            color: Colors.green,
                                                            onPressed: () => {
                                                              _incrementQuantity(index),
                                                            context.read<ProductBloc>().add(AddProduct(collectionListData[index].name,collectionListData[index].price))
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Positioned(
                                                //     top: 10,
                                                //     right: 0,
                                                //
                                                //     child: Container(
                                                //       padding: EdgeInsets.all( isMobile ? 3 : 5),
                                                //       // padding: EdgeInsets.all(1.0),
                                                //       decoration: BoxDecoration(
                                                //         color: Colors.deepOrange,
                                                //         borderRadius: BorderRadius.circular(8.0),
                                                //       ),
                                                //       child: Center(
                                                //         child: Text(
                                                //             '${collectionListData[index].price}',
                                                //             style: GoogleFonts.pacifico(
                                                //               fontSize: isMobile ? 18.sp : 18.sp,
                                                //
                                                //               fontWeight: FontWeight.bold,
                                                //               color: Colors.white,
                                                //               decoration: TextDecoration.none,
                                                //             )
                                                //         ),
                                                //       ),
                                                //
                                                //     ))
                                              ]
                                          ),

                                        ),
                                      ),
                                    );
                                }
                            );
                          // );
                        },
                      ),
                    ),
                    // Container(height: 100,)
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: widthSize  < 450 ?  0 :widthSize  > 450 ?  12 : widthSize > 551 && widthSize < 800 ? 12 :  12,
                width: widthSize,
                child: isMobile ?
                ElevatedButton(

                    onPressed: (){ context.go("/cart");},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Set the border radius to 0 for a rectangular shape
                      ),
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Place Order",
                      style: GoogleFonts.teko(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    )
                )
                    :
                ElevatedButton(

                    onPressed: (){ _sendMessage();},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Set the border radius to 0 for a rectangular shape
                      ),
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Place Order",
                      style: GoogleFonts.teko(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    )
                )
            )
          ]
      ),
    );
  }
}

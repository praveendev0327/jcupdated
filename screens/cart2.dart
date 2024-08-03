import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/constants/collections.dart';
import 'package:justcall/hover/onhover.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/middleware/events.dart';
import 'package:justcall/middleware/state.dart';
import 'package:justcall/modals/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CartOut extends StatefulWidget {
  const CartOut({super.key});

  @override
  State<CartOut> createState() => _CartState();
}

class _CartState extends State<CartOut> {
  var count = 0;
  String orderPlaced = '';
  Map<String, dynamic> userData = {};
  bool? indicator = false;

  // List<JcProductListData> collectionListData =
  //     CollectionConstants.productConstants;

  @override
  void initState() {
    super.initState();
    loadData().then((loadedData) {
      if (loadedData != null) {
        setState(() {
          userData = loadedData;
        });
      }
    });
  }



  Future<void> sendJsonData(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://justcalltest.onrender.com/api/users/createItemPurchase"),
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

  void _sendMessage(List<Product> products) async {
    String phoneNumber = '+971506279715'; // Replace with your phone number
    String message = 'Hello from Flutter!'; // Your message
    // Filter products where quantity is not equal to 0
    // final data = products.where((product) => product.qty != 0).toList();
    // List<JcProductListData> filteredProducts =
    // collectionListData.where((product) => product.qty != 0).toList();
    // print("filteredProducts ${filteredProducts.length}");
    // Convert the filtered list to a text variable
    // String filteredText = filteredProducts
    //     .map((product) =>
    // '${product.name} - Quantity: ${product.qty} - Price: ${product.price},')
    //     .join('\n');

    String orderData = products
        .map((product) =>
    '${product.name} - Quantity: ${product.quantity} - Price: ${product
        .price},')
        .join('\n');

    // final details = {"items": Uri.encodeFull(filteredText)};

    // await sendJsonData(details);
    // Encode the message to handle special characters
    String url =
        'https://wa.me/$phoneNumber/?text= Order List : ${Uri.encodeFull(
        orderData)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendDeliveryList(Map<String, dynamic> data, BuildContext context) async{
    // String orderData = products
    //     .map((product) =>
    // '${product.name} - Quantity: ${product.quantity} - Price: ${product
    //     .price},')
    //     .join('\n');
    final ProductBloc resetBloc = context.read<ProductBloc>();
    try {
      final response = await http.post(
        Uri.parse(
            "https://justcalltest.onrender.com/api/users/createDelivery"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        await sendPushMessage(data);
        resetBloc.add(ResetProduct());
        setState(() {
          indicator = false;
        });
        print('Data sent successfully');
        setState(() {
          orderPlaced = 'Your order has been placed successfully!';
        });

        // showOrderPlacedDialog(context);

      } else {
        // Error occurred while sending data
        setState(() {
          indicator = false;
        });
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      setState(() {
        indicator = false;
      });
      print('Exception occurred: $e');
    }

  }

  void showOrderPlacedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        // Start the timer to close the dialog automatically
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });

        return AlertDialog(
          title: Text('Order Placed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your order has been placed successfully!'),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  void saveData(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data); // Convert map to JSON string
    await prefs.setString('userData', jsonData); // Save JSON string to Shared Preferences
  }

  Future<Map<String, dynamic>?> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('userData'); // Retrieve JSON string
    if (jsonData != null) {
      return jsonDecode(jsonData); // Convert JSON string to map
    }
    return null; // Return null if no data found
  }

  Future<void> sendPushMessage(Map<String, dynamic> data) async {
    // String orderData = data["orderlist"]
    //     .map((product) =>
    // '${product.name} - Quantity: ${product.quantity} - Price: ${product
    //     .price},')
    //     .join('\n');
    var token = "cgBGjyR1TuioTjrb3kV07R:APA91bHNvg9n7Eif6fuvbmOIBSQV1xPHNZlf47w7BC0VXQ9qBDpAfdhwKcDfCch2sgvOOM2_MB6VXhGHrx54-AY3LsLotWK7HYufpcLKZtpVjoik8oBwBTwIVLOXOGyOXUS47i0UthsR";
    final String serverKey = '7664811f1de7ee912bf0d45aae214af6dd6c0272';
    final String serverKeys = 'ya29.a0AcM612zkf2ZWh6xcvQHfJUpO7SJQFDkTkwDBsnrBWUYTJXqam2vndkpLZi0wmdd4uVJHOe558iO3_gY9i-DqTByLb9IegR9t--t4BInzJryxLH0_g2Z_INHweNdCkk7OUPOaXf5wDVvyBl6pq82iK2XbK8u332_D3uXzaCgYKAYoSARMSFQHGX2Mih-ETDbxtG7SZzMDhzKTmBw0171'; // Replace with your server key or use OAuth token
    final String oauthToken = 'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC30dD3s3JvjpcZt7kmTK1hxHPgKMbjzAZlLe3LIgVFfH28ZMyL8ptixJdIHzecC01ugoi9d+psLKt30dUOZFJPKbo7V6mCymvStN90XisSR4bjMQVj3QF7c+X3pan3h7riUnboaDcoz6piuHYwfoBTO0rGM5lfJ1Abz8/lKNc+qDVSIgdphLmqJ8eS1UOt8l6XDP/gwcpuGUnsAvgLWJG+p3zYYb7eZPviSnQt8STXB2SnUKq1TCQWsMTaQyk66BduNrghFENQB+cu2R0O+20peAG4fqwTbRtSeUSvupUEitkfcj8ADpScKLuAFHibRLjt081PH5vSYOmdvfeqOHtHAgMBAAECggEAAyUJQfuQFR183e6ZMcZftEuj6df4vb6TS27TjG/quYDC4T1eNx9cONPWfLWKrNY6qbh89goo+KxzoIChTaDkvEBL/yY68FGzMi8a9YbY43QAIuncnD6UfxQBVqZpt8zazcgNtbXMCnGHCi+lV04Ktvci39d+eQoXTOqAtXxoi5oAl/Bfb0waMcb9eJBEzCoM90mr4L/EF0r9R/JZ5e4imNNLZrajroWavwKQMKbiBOIs2O1Z2EwYLxEkmD0k+inaRzerqtnc5lkh/5mRk5xRYfwPG27y6tWNYIuDFu8+kvPvLC4YWQ11z/K1hUkOAJo/vl4h20HFlYxeZVF0Qcke4QKBgQD2cbElBbdpregUs9jxUSvtNW+WwGqmWGxnDaCYiUEmi+vuEr8Q/E6v9qnP05i8CGVNPtVH52qDVyWWMmNhh3HAk4ScVzIs1UoSPL8Cn1/LiKQ9P0g4jREKy9UGy8MNn5uim+9gDn4zgR+SHDigNuw4ZyI0RRE0YIx4ydZZ8X3GZwKBgQC+8nysHy3mQZ6+MwilOYhEs++SqcOsieD3qWF1BX1myvEWlzLIGsz6dI6YlSmjWhnC+jpJbOQ4UymvWUXVe6Kv9ugZAW/6WKLiqzBmz4g5eiNSHj889u9eGV8GpV2EE5HVe+CE8kr1beDA939N8qeAptdMOvdqrrEGE8IdOq3YIQKBgBFgcNoobgdQkNWs3LYfQBaotuaNSLfT8kjN6C35N5PNN+SAg+Jht/amUNDrnZBckzAAJy+7vIHoSikuAl3lG/s1K5uOdmY8380rZVh8/lcumk4LQT9jivkU6D9jbKxwPZwYnKdMPk/JYf1+aeu6E6viccH3wL/NsvntWWTcJz8vAoGAEHA7v22nu+zmR6WJFwBO9OswssWerNnp3ihc1YA1fYX3H2TA4G0+PEmQhR5CSWfWU+zK28teEmNGcWwUEP7l0JRHAvAWvcynqS/nqNIw/hG/vLAR7aOsk8NHZQETfe1ZXrGdcJSTU3G0Kaik8wby2KaEXnGtHygO4WEOEwocMUECgYBly5b6yeBqhQGhic/KV71UBbjaENIhm+AQ1rnL0liFulothKrEeaTZg6XNQjGlW0fPoe1UuuHcEbBrckxxeft0s6A84ur255Yq4Me+Gn9Zze7MwssDWXQjt6cMVS5Y1sw3q6hC4K/wzWznLx5ki5QH3zT9e2LNplJqHWaZjC7/sQ=='; // Replace with your OAuth 2.0 access token

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/justcall-78dcb/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKeys',
        },
        body:
        // jsonEncode(
        //   <String, dynamic>{
        //     'notification': <String, dynamic>{
        //       'body': data["orderlist"],
        //       'title': data["name"],
        //       'sound': 'default'
        //     },
        //     'priority': 'high',
        //     'data': <String, dynamic>{
        //       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        //     },
        //     'to': token,
        //   },
        // ),100484314105721545298

        jsonEncode(
          <String, dynamic>{
            'message': <String, dynamic>{
              'token': token,
              'notification': <String, dynamic>{
                'body': "${data["orderlist"]}",
                'title': "${data["name"]}",
              },
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              },
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        print("FCM request sent successfully");
      } else {
        print("FCM request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending FCM message: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery
        .of(context)
        .size
        .width < 750;
    final int maxItems = 8;

    return SafeArea(
      child: Scaffold(
        body: Container(
          // color: Color(0xFFE0FBE2),
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Stack(children: [
            Positioned(
              width: widthSize,
              top: 20,
              left: 20,
              child:
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        context.go('/');
                      },
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.arrowLeftLong,
                            size: 22,
                            color: Colors.green,
                          ),
                          Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,)
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  // Text('Cart',
                  //     style: GoogleFonts.roboto(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.deepOrangeAccent,
                  //       decoration: TextDecoration.none,
                  //     )),
                ],
              ),
            ),
            Positioned.fill(
              top: 70,
              child: Container(
                padding: EdgeInsets.all( 10),
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
                    SizedBox(
                      height: 15,
                    ),
                    userData.isNotEmpty ?
                    Column(
      
                      children: [
                        Text(
                          'Name : ${userData["name"]}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          'Phone : ${userData["phone"]}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          'Address : ${userData["address"]}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            editUserData(context);
                          },
                          child: Text("edit",style: TextStyle(color: Colors.deepOrange,),),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ): SizedBox(),
                    orderPlaced != '' ? SizedBox() :
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return state.grandTotal != 0
                              ? Text(
                            'verify your product list',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                            ),
                          )
                              : Text(
                            'Please add your favorites on cart',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                            ),
                          );
                        }),
      
                    SizedBox(
                      height: 5,
                    ),
                    orderPlaced != '' ? Text(
                      '${orderPlaced}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        decoration: TextDecoration.none,
                      ),
                    ) :
                    Expanded(
                      child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            void _incrementQuantity(int index) {
                              // print("object ${collectionListData[index].qty++}" );
                              setState(() {
                                state.products[index].quantity + 1;
                              });
                            }
      
                            void _decrementQuantity(int index) {
                              setState(() {
                                if (state.products[index].quantity > 0) {
                                  state.products[index].quantity - 1;
                                }
                              });
                            }
      
                            return ListView.builder(
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
      
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: widthSize * 0.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name,
                                                    style: GoogleFonts.teko(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                      decoration: TextDecoration
                                                          .none,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Quantity: ${product
                                                        .quantity}',
                                                    style: GoogleFonts.teko(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors.black54,
                                                      decoration: TextDecoration
                                                          .none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "${product.quantity *
                                                  product.price} AED",
                                              style: GoogleFonts.teko(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.deepOrange,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              color: Colors.red,
                                              onPressed: () =>
                                              {
                                                _decrementQuantity(index),
                                                context.read<ProductBloc>().add(
                                                    RemoveProduct(
                                                        product!.name as String))
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              // color: Colors.blueGrey,
                                              child: Text('${product!.quantity}',
                                                  // "0",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .none,
                                                  )),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              color: Colors.green,
                                              onPressed: () =>
                                              {
                                                _incrementQuantity(index),
                                                context.read<ProductBloc>().add(
                                                    AddProduct(
                                                        product.name,
                                                        product.price))
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   child:
                    //   BlocBuilder<ProductBloc, ProductState>(
                    //       builder: (context, state) {
                    //
                    //         return GestureDetector(
                    //           onTap: (){
                    //             print("order data : ${state.products}");
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //            children: [
                    //              Text(
                    //                'Order c',
                    //                style: GoogleFonts.roboto(
                    //                  fontSize: 14,
                    //                  fontWeight: FontWeight.normal,
                    //                  color: Colors.white,
                    //                  decoration: TextDecoration.none,
                    //                ),
                    //              ),
                    //              SizedBox(width: 5,),
                    //              Text(
                    //                '${state.grandTotal} AED',
                    //                style: GoogleFonts.roboto(
                    //                  fontSize: 16,
                    //                  fontWeight: FontWeight.bold,
                    //                  color: Colors.white,
                    //                  decoration: TextDecoration.none,
                    //                ),
                    //              ),
                    //            ],
                    //           ),
                    //         );
                    //       }),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: BlocBuilder<ProductBloc, ProductState>(
                    //     builder: (context, state) {
                    //       return Text(
                    //         'Grand Total: ${state.grandTotal}',
                    //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Container(height: 100,)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: widthSize < 450
                  ? 0
                  : widthSize > 450
                  ? 12
                  : widthSize > 551 && widthSize < 800
                  ? 12
                  : 12,
              width: widthSize,
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          // _sendMessage(state.products);
                          // showInputDialog(context, state.products).then((_) {
                          //   // Once the first dialog is closed, show the second dialog
                          //   showSecondDialog(context);
                          // });
                          if( userData.isNotEmpty){
                            String orderData = state.products
                                .map((product) =>
                            '${product.name} - Quantity: ${product.quantity} - Price: ${product
                                .price},')
                                .join('\n');
                            Map<String,dynamic> data = {
                              "name" : userData["name"],
                              "phone" : userData["phone"],
                              "address" : userData["address"],
                              "orderlist" : orderData,
                              "orderstatus" : "new_order"
                            };
                            print("object$data");
                            setState(() {
                              indicator = true;
                            });
                            sendDeliveryList(data,context);
                          }else{
                            setState(() {
                              indicator = true;
                            });
                            showInputDialog(context, state.products);
                          }
      
      
                          // sendDeliveryList(state.products);
                          // final pro = state.products[0];
                          // print("object1 ${pro.name}");
                          // print("object2 ${state.products}");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), // Set the border radius to 0 for a rectangular shape
                          ),
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child:
                        // Text(
                        //   "Place Order",
                        //   style: GoogleFonts.teko(
                        //     fontSize: 22.sp,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.white,
                        //     decoration: TextDecoration.none,
                        //   ),
                        // )
                        // BlocBuilder<ProductBloc, ProductState>(
                        //     builder: (context, state) {
      
                        // return
                        indicator == true
                            ? Center(
                            child: SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                strokeWidth: 2.0,
                              ),
                            ))
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Order Grand Total',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${state.grandTotal.toStringAsFixed(2)} AED',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        )
                      // }),
                    );
                  }),
              // :
              // ElevatedButton(
              //         onPressed: () {
              //           _sendMessage();
              //         },
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(
              //                 0), // Set the border radius to 0 for a rectangular shape
              //           ),
              //           backgroundColor: Colors.green,
              //           minimumSize: Size(double.infinity, 50),
              //         ),
              //         child: Text(
              //           "Order",
              //           style: GoogleFonts.teko(
              //             fontSize: 22.sp,
              //             fontWeight: FontWeight.w500,
              //             color: Colors.white,
              //             decoration: TextDecoration.none,
              //           ),
              //         ))
            )
          ]),
        ),
      ),
    );
  }


  void showInputDialog(BuildContext context, List<Product> products) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String phone = phoneController.text;
                String address = addressController.text;
                print('Name: $name, Phone: $phone, Address: $address');
                String orderData = products
                    .map((product) =>
                '${product.name} - Quantity: ${product.quantity} - Price: ${product
                    .price},')
                    .join('\n');
                Map<String,dynamic> data = {
                  "name" : name,
                  "phone" : phone,
                  "address" : address,
                  "orderlist" : orderData,
                  "orderstatus" : "new_order"
                };
                Map<String,dynamic> userDatas = {
                  "name" : name,
                  "phone" : phone,
                  "address" : address,
                };
                saveData(userDatas);
                Navigator.of(context).pop();
                sendDeliveryList(data,context);

              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  void editUserData(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String phone = phoneController.text;
                String address = addressController.text;
                print('Name: $name, Phone: $phone, Address: $address');


                Map<String,dynamic> userDatas = {
                  "name" : name,
                  "phone" : phone,
                  "address" : address,
                };
                saveData(userDatas);
                Navigator.of(context).pop();


              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

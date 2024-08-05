import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late List<dynamic> _productsFuture = [];
  var status = 0;
  bool? indicator = false;
  bool? indicatorStatus = false;
  late final SharedPreferences prefs;


  @override
  void initState() {

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      updateDeliveryToken(token);
    });
      fetchAllDeliveryData();

  }



  void fetchAllDeliveryData() async{

    try {
      // final Data = {
      //   "SubGroupName" :  _selectedSubGroup
      // };
      final response = await http.get(
        Uri.parse("https://justcalltest.onrender.com/api/deliverylist") ,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode(Data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        // print('Data sent successfully');
        final fetch = json.decode( response.body);
        // print('login fetch : ${fetch }');

        final subGroupList = fetch["data"];


        setState(() {
          if(status == 0){
            List<dynamic> newOrder = subGroupList.where((item) => item['orderstatus'] == "new_order").toList();
            _productsFuture = newOrder;
          }
          if(status == 1){
            List<dynamic> pending = subGroupList.where((item) => item['orderstatus'] == "pending").toList();
            _productsFuture = pending;
          }
          if(status == 2){
            List<dynamic> delivered = subGroupList.where((item) => item['orderstatus'] == "delivered").toList();
            _productsFuture = delivered;
          }
        });
        setState(() {
          indicator = false;
        });
        // print('All Data from sub group : ${fetch["data"]}');
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


  void sendDeliveryStatus(Map<String, dynamic> data) async{


    try {
      final response = await http.put(
        Uri.parse(
            "https://justcalltest.onrender.com/api/users/updateDeliveryStatus"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        setState(() {
          indicatorStatus = false;
        });
        print('Data updated successfully');
        // setState(() {
        //   orderPlaced = 'Your order has been placed successfully!';
        // });
        fetchAllDeliveryData();
        // showOrderPlacedDialog(context);

      } else {
        // Error occurred while sending data
        setState(() {
          indicatorStatus = false;
        });
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      setState(() {
        indicatorStatus = false;
      });
      print('Exception occurred: $e');
    }

  }

  void updateDeliveryToken(String? token) async {
    prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('FCMTOKEN');
    String? tt = token;
    if (fcmToken == null) {

      prefs.setString('FCMTOKEN', tt!);
    try {
      var data = {
        'token': token,
        'id': 1
      };
      final response = await http.put(
        Uri.parse(
            "https://justcalltest.onrender.com/api/users/updateDeliveryAppToken"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully sent data
        // setState(() {
        //   indicatorStatus = false;
        // });
        print('Data updated successfully');
        // setState(() {
        //   orderPlaced = 'Your order has been placed successfully!';
        // });
        // fetchAllDeliveryData();
        // showOrderPlacedDialog(context);

      } else {
        // Error occurred while sending data
        // setState(() {
        //   indicatorStatus = false;
        // });
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      // setState(() {
      //   indicatorStatus = false;
      // });
      print('Exception occurred: $e');
    }
  }

  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 750;

    return SafeArea(
      child: Container(
        width: widthSize,
        height: heightSize,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Navbar(),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: status == 0 ? Colors.white : Colors.deepOrange,
                  margin: EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        indicator = true;
                      });
                      setState(() {
                        status = 0;
                      });
                      fetchAllDeliveryData();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(5),
                      child: Text(
                        'New Order',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: status == 1 ? Colors.white : Colors.deepOrange,
                  margin: EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        indicator = true;
                      });
                      setState(() {
                        status = 1;
                      });
                      fetchAllDeliveryData();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                         'Pending',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: status == 2 ? Colors.white : Colors.deepOrange,
                  margin: EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        status = 2;
                      });
                      fetchAllDeliveryData();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Delivered',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    fetchAllDeliveryData();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.refresh,
                    size: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),

            // _productsFuture == null ? CircularProgressIndicator() :
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
                :
            Expanded(
              child: ListView.builder(
                itemCount: _productsFuture!.length,
                itemBuilder: (context, index) {
                  int serialNumber = index + 1;
                  DateTime dateTime = DateTime.parse(_productsFuture[index]["time"]);

                  // Format the DateTime object to the desired string format
                  String formattedDateTime = "${dateTime.toLocal().toIso8601String().split('T').first} ${dateTime.toLocal().toIso8601String().split('T').last.split('.')[0]}";

                  return
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name : ${_productsFuture[index]["name"]}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      'Phone : ${_productsFuture[index]["phone"]}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      'Address : ${_productsFuture[index]["address"]}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${formattedDateTime}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Order List : ${_productsFuture[index]["orderlist"]}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (status == 0){
                                      int id = _productsFuture[index]["id"] as int;
                                      String sts = "pending";
                                      Map<String,dynamic> statusDetails = {
                                        "serialno" : "0",
                                        "orderstatus" : 'pending',
                                        "id" : id,
                                      };
                                      // setState(() {
                                      //   indicatorStatus = true;
                                      // });

                                      sendDeliveryStatus(statusDetails);
                                      // deliveryDetails(context, id );
                                    }
                                  },
                                  child: Text(status == 2 ? "" :'Pending'),
                                ),

                                TextButton(
                                  onPressed: () {

                                    if (status != 2){
                                      int id = _productsFuture[index]["id"] as int;
                                      setState(() {
                                        indicatorStatus = true;
                                      });
                                      deliveryDetails(context, id );
                                    }

                                  },
                                  child: indicatorStatus == true
                                      ? Center(
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.deepOrange),
                                          strokeWidth: 2.0,
                                        ),
                                      ))
                                      : Text('Delivered'),
                                ),
                              ],
                            )

                            // TextButton(
                            //   onPressed: (){
                            //     editUserData(context);
                            //   },
                            //   child: Text("edit",style: TextStyle(color: Colors.deepOrange,),),
                            // ),

                          ],
                        ),
                      ),
                    );
                },
              ),
            )
          ],
        ),
      
      ),
    );
  }

  void deliveryDetails(BuildContext context, int id) {
    TextEditingController serialController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Serial No'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serialController,
                decoration: InputDecoration(labelText: 'Serial No'),
              ),
              // TextField(
              //   controller: phoneController,
              //   decoration: InputDecoration(labelText: 'Phone'),
              // ),
              // TextField(
              //   controller: addressController,
              //   decoration: InputDecoration(labelText: 'Address'),
              // ),
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
                String serialno = serialController.text;
                // String phone = phoneController.text;
                // String address = addressController.text;
                // print('Name: $name, Phone: $phone, Address: $address');


                Map<String,dynamic> statusDetails = {
                  "serialno" : serialno,
                  "orderstatus" : 'delivered',
                  "id" : id,
                };
                // saveData(userDatas);
                sendDeliveryStatus(statusDetails);
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/middleware/events.dart';
import 'package:justcall/middleware/state.dart';
class Explorer extends StatefulWidget {
  final List<Map<String, String>> data;
  const Explorer({super.key, required this.data});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  final List<String> items = ['a', 'b', 'c', 'd'];
  late List<dynamic> _productsFuture = [];
  int selectedIndex = 0;
  String selectedSubGroup = '';
  @override
  void initState() {
    // selectedIndex = widget.data.indexWhere(
    //       (item) => item["name"] == widget.data[0]["name"],
    // );
    fetchAllSubGroupData(widget.data[0]["id"] as String);
  }


  void fetchAllSubGroupData(String data) async{

    setState(() {
      _productsFuture = [];
    });

    try {
      // final Data = {
      //   "SubGroupName" :  _selectedSubGroup
      // };
      final response = await http.get(
        Uri.parse("https://justcalltest.onrender.com/api/users/allCategoryList/${data}"),
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
        for (var product in subGroupList) {
          product['qty'] = 0;
        }
        setState(() {
          _productsFuture = subGroupList;
        });

        // print('All Data from sub group : ${fetch["data"]}');
      } else {
        // Error occurred while sending data
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
    }

  }

  void _incrementQuantity(int index) {
    // print("object ${collectionListData[index].qty++}" );
    setState(() {
      // collectionListData[index].qty ++;
      _productsFuture[index]["qty"] ++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {

      if (_productsFuture[index]["qty"] > 0) {
        _productsFuture[index]["qty"] --;
        // print("object ${_productsFuture[index]["qty"]--}" );
      }

      // if (collectionListData[index].qty! > 0) {
      //   collectionListData[index].qty --;
      //   print("object ${collectionListData[index].qty--}" );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {

    print("data : ${widget.data[0]}");
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 750;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: heightSize,
          width: widthSize,
          // padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: heightSize * 0.10,
                width: widthSize ,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        Row(
                          children: [
                            BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              return Container(
                                child: state.products.length == 0 ? SizedBox() :
                                Text('${state.products.length == 0  ? 0 : state.products.length + 1 -1} Items',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent,
                                      decoration: TextDecoration.none,
                                    )),
                              );
                            }
                            ),
                            SizedBox(width: 3,),
                            GestureDetector(
                              onTap: (){
                                context.go("/cartout");
                              },
                              child: Container(
                                height: 22,
                                width: 22,
                                child: Icon(Icons.shopping_cart,color: Colors.green,),
                              ),
                            ),
                          ],
                        )
                        ,
                      ],
                    ),
              ),
              Row(
                children: [
                  Container(
                    height: heightSize * 0.85,
                    width: widthSize * 0.20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(2.0),
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              fetchAllSubGroupData(widget.data[index]["id"] as String);
                            });
                          },
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            padding: EdgeInsets.all(2.0),

                            child: Column(
                              children: [
                                Container(
                                  // height: isMobile ? heightSize * 0.04 : 300.h,
                                  //   width: 150,
                                    height: 50,
                                    child: Image.asset(
                                      widget.data[index]["img"] as String ,
                                      fit: BoxFit.cover,)
                                ),
                                Center(
                                  child: Text(
                                    widget.data[index]["name"] as String,

                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: selectedIndex == index ? Colors.deepOrange : Colors.black,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: heightSize * 0.85 ,
                    width: widthSize * 0.80,
                    // color: Color(0xFFE0FBE2),
                    child: _productsFuture.isEmpty ? Container(
                      // height :  MediaQuery.of(context).size.height,
                        padding : EdgeInsets.only(left: 8,right: 8,top: 50,bottom: 8),
                        child: Center(
                          child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                            ),
                          ),
                        )) :
                      GridView.builder(
                        // controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widthSize < 600 ? 2 : widthSize < 1120 ? 2 :   3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: isMobile ? 1.2 / 3 : 0.5,
                        ),
                        // itemCount: collectionListData.length  > maxItems ? maxItems : collectionListData.length,
                        itemCount: _productsFuture!.length  ,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == _productsFuture.length) {
                            return Center(child: Center(child: Container(
                              height: 20,
                                width: 20,
                                child: CircularProgressIndicator())));
                          }
                          return
                            // Expanded(
                            // child:

                            // OnHover(
                            //     builder: (isHovered) {
                            //       return
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                margin: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 80),
                                decoration: BoxDecoration(
                                    color:  Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),

                                  // color: Color(int.parse(collectionListData[index].back as String)),
                                  // color: Color(0xFFE1F0DA),
                                  // color: Color(0xFFACD793),
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
                                             Container(
                                                  height: isMobile ? heightSize * 0.2 : heightSize * 0.3,
                                                  width: widthSize,
                                                  // color: Colors.blue,
                                                  child:
                                                  // Image.asset(
                                                  //   collectionListData[index].img as String,
                                                  //   fit: BoxFit.contain,)
                                                  Image.memory(base64Decode(_productsFuture![index]["image"]!.contains(',')  ? _productsFuture![index]["image"].split(',')[1] : _productsFuture![index]["image"])),
                                                ),


                                              Container(
                                                // color: Colors.blueGrey,
                                                padding: EdgeInsets.only(left: 10),
                                                height: isMobile ? heightSize * 0.06 : heightSize * 0.1,
                                                width: widthSize,
                                                child: Text(_productsFuture![index]["Product Name"] as String,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: isMobile ?FontWeight.bold :  FontWeight.bold,
                                                    color: Colors.black,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.blueGrey,
                                                padding: EdgeInsets.only(left: 10),
                                                height: isMobile ? heightSize * 0.05 : heightSize * 0.1,
                                                width: widthSize,
                                                child: Text(_productsFuture![index]["Price 1"] as String,
                                                  style: GoogleFonts.roboto(
                                                    fontSize:  18,
                                                    fontWeight: isMobile ?FontWeight.bold :  FontWeight.bold,
                                                    color: Colors.deepOrange,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.remove),
                                                    color: Colors.red,
                                                    onPressed:  () => {
                                                      _decrementQuantity(index),
                                                      context.read<ProductBloc>().add(RemoveProduct(_productsFuture![index]["Product Name"] as String))
                                                    },
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    // color: Colors.blueGrey,
                                                    child: Text(
                                                        '${_productsFuture![index]["qty"]}',
                                                        // "0",
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 18,

                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          decoration: TextDecoration.none,
                                                        )
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.add),
                                                    color: Colors.green,
                                                    onPressed: () =>
                                                    {
                                                      _incrementQuantity(index),
                                                      context.read<ProductBloc>().add(AddProduct(_productsFuture![index]["Product Name"] as String,double.parse(_productsFuture![index]["Price 1"])))
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
                                        //           // '${collectionListData[index].price}',
                                        //             '${_productsFuture![index]["Price"] as String}',
                                        //             style: GoogleFonts.pacifico(
                                        //               fontSize: isMobile ? 18 : 18,
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
                          //     }
                          // );
                          // );
                        },
                      ),

                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

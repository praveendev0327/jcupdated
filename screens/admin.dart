import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/components/navbar.dart';
import 'package:justcall/screens/category.dart';
import 'package:justcall/screens/landing.dart';
import 'package:justcall/screens/offer.dart';
import 'package:justcall/screens/product.dart';
import 'package:justcall/screens/productdashboard.dart';
import 'package:justcall/screens/profile.dart';
import 'package:justcall/screens/init.dart';
import 'package:justcall/screens/uploadexcel.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: isMobile ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MouseRegion(
                    child: Container(
                      // color: Colors.grey,
                      child: GestureDetector(
                        onTap: () {
                          // context.go('/');
                        },
                        child: isMobile ?
                        Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,)
                            : Center(
                          child: Text("JODILIER",
                              style: GoogleFonts.josefinSans(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              )),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // context.go('/profile');
                  //     setState(() {
                  //       screen = 3 ;
                  //     });
                  //   },
                  //   child: Center(
                  //     child: Icon(
                  //       Icons.menu,
                  //       size: 26.0,
                  //       color: Colors.green,
                  //     ),
                  //   ),
                  // ),
                  SizedBox()
                ],
              ),
            )
                : SizedBox(),
          ),
          Positioned.fill(
            top: 70,
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),

              child: Column(
                children: [
                  // Products(),
                  // LandingPage(),
                  // SizedBox(height: 30,),
                  // Collection(),
                  // SizedBox(height: 30,),
                  // Option(),
                  // SizedBox(height: 60,),
                  // Adds(),
                  // SizedBox(height: 30,),
                  // Category(),
                  // SizedBox(height: 30,),
                  // Footer(),



                  //testing
                  // ProductDetail()
                  // Filter()
                  // Demo()
                  // Login()
                  // DashboardScreen()
                  //   Test()
                  // UploadExcel()

                 // ProductDashboard()
                ],
              ),
            ),
          ),

        ]
    );
  }
}

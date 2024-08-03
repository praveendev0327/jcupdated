import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/components/navbar.dart';
import 'package:justcall/screens/category.dart';
import 'package:justcall/screens/landing.dart';
import 'package:justcall/screens/offer.dart';
import 'package:justcall/screens/product.dart';
import 'package:justcall/screens/profile.dart';
import 'package:justcall/screens/init.dart';
import 'package:justcall/screens/uploadexcel.dart';

class Initial extends StatefulWidget {
  const Initial({super.key});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {

  var screen = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      // Landing()
      body:
      !isMobile ?
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Navbar(),
              ),
              Positioned.fill(
                top: 70,
                child: SingleChildScrollView(
                  child: Landing(),
                ),
              )
            ],
          )
       :
      Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:
              isMobile ?
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
                              :Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.go('/profile');
                        setState(() {
                          screen = 3 ;
                        });
                      },
                      child: Center(
                        child: Icon(
                          Icons.menu,
                          size: 26.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Navbar(),
            ),

            Positioned.fill(
              top: 70,
              child: SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),

                // child: Column(
                //   children: [
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

                  child:
                    _buildContentBasedOnState(screen)

                    // screen == 0 ? Offers() : SizedBox(),
                    // screen == 1 ? Offers() : SizedBox(),
                    // screen == 2 ? Offers() : SizedBox(),
                    // screen == 3 ? Profile() : SizedBox(),
      
      
                  // ],
                // ),
              ),
            ),
            !isMobile ? SizedBox() :
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: widthSize,
                color: Colors.green,
                padding: EdgeInsets.symmetric(
                    horizontal: widthSize > 500 ? 20: 20,
                    vertical: widthSize > 500 ? 20 : 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              screen = 0 ;
                            });
                         },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.home,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text("Home",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              screen = 1 ;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.cubes,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text("Categories",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // context.go("/offers");
                            setState(() {
                              screen = 2 ;

                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.boltLightning,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text("WeekendOffers",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            context.go("/cart");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.shoppingCart,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text("Cart",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
      
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
}

Widget _buildContentBasedOnState(state) {
  switch (state) {
    case 0:
      return Landing();
    case 1:
      return Category();
    case 2:
      return Offers();
    case 3:
      return Profile();
    default:
      return Profile();
  }
}


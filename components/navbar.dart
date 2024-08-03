import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/middleware/state.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 750;
    print("navbar");
    return Container(
      width: widthSize,
      // color: Colors.grey,
      padding: EdgeInsets.symmetric(
          horizontal: widthSize > 500 ? 20 : 20,
          vertical: widthSize > 500 ? 20 : 10),
      child: isMobile
          ?
      Padding(
        padding: const EdgeInsets.all(4.0),
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
                    child:
                    Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,)
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return Container(
                            child: state.products.length == 0 ? SizedBox() :
                            Text('${state.products.length == 0  ? 0 : state.products.length + 1 -1}',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
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
                ),
                // SizedBox(width: 15,),
                // GestureDetector(
                //   onTap: () {
                //     // context.go('/profile');
                //     // setState(() {
                //     //   screen = 3 ;
                //     // });
                //     showCustomDialog(context);
                //   },
                //   child: Center(
                //     child: Icon(
                //       Icons.menu,
                //       size: 26.0,
                //       color: Colors.green,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      )
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     MouseRegion(
      //       child: Container(
      //         // color: Colors.grey,
      //         child: GestureDetector(
      //           onTap: () {
      //             // context.go('/');
      //           },
      //           child: isMobile ?
      //           // Text("JODILIER",
      //           //         style: GoogleFonts.josefinSans(
      //           //           fontSize: 18.sp,
      //           //           fontWeight: FontWeight.bold,
      //           //           color: Colors.black,
      //           //           decoration: TextDecoration.none,
      //           //         ))
      //           Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 154,)
      //               : Center(
      //             child: Text("JODILIER",
      //                 style: GoogleFonts.josefinSans(
      //                   fontSize: 18.sp,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                   decoration: TextDecoration.none,
      //                 )),
      //           ),
      //         ),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         context.go('/profile');
      //         // showCustomDialog(context);
      //       },
      //       child: Center(
      //         child: Icon(
      //           Icons.menu,
      //           size: 26.0,
      //           color: Colors.green,
      //         ),
      //       ),
      //     ),
      //   ],
      // )
          :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   children: [
          //     MouseRegion(
          //       cursor: SystemMouseCursors.click,
          //       child: GestureDetector(
          //         onTap: () {
          //           context.go('/filter/${"Male"}');
          //         },
          //         child: Container(
          //           child: Text("Men",
          //               // style: TextStyle(color: Colors.black,fontSize: 16.sp,decoration: TextDecoration.none,
          //               // )
          //               style: GoogleFonts.josefinSans(
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.normal,
          //                 color: Colors.black,
          //                 decoration: TextDecoration.none,
          //               )),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 40),
          //     MouseRegion(
          //       cursor: SystemMouseCursors.click,
          //       child: GestureDetector(
          //         onTap: () {
          //           context.go('/filter/${"Female"}');
          //         },
          //         child: Container(
          //           child: Text("Women",
          //               style: GoogleFonts.josefinSans(
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.normal,
          //                 color: Colors.black,
          //                 decoration: TextDecoration.none,
          //               )),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 40),
          //     MouseRegion(
          //       cursor: SystemMouseCursors.click,
          //       child: GestureDetector(
          //         onTap: () {
          //           context.go('/filter/${"all"}');
          //         },
          //         child: Container(
          //           child: Text("Collections",
          //               style: GoogleFonts.josefinSans(
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.normal,
          //                 color: Colors.black,
          //                 decoration: TextDecoration.none,
          //               )),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          MouseRegion(
            child: Container(
              // color: Colors.grey,
              child: GestureDetector(
                  onTap: () {
                    // context.go('/');
                  },
                  child: isMobile
                      ?
                  Text("JustCall",
                      style: GoogleFonts.josefinSans(
                        fontSize : 18 ,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      )

                  )

                      :
                  // Center(
                  //         child: Text("JODILIER",
                  //             style: GoogleFonts.josefinSans(
                  //               fontSize: 18.sp,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //               decoration: TextDecoration.none,
                  //             )),
                  //       ),
                  Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 150,)
              ),
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        context.go('/offersweb');
                      },
                      child: Container(
                        child: Text("Weekend Offers",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      child: Text("About",
                          style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  SizedBox(width: 40),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      child: Text("Contact Us",
                          style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  SizedBox(width: 40),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: Container(
                        child: Text("Login",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );


  }
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content:
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.go("productlist");
                      },
                      child: Container(
                        child: Text("Offers",
                            // style: TextStyle(color: Colors.black,fontSize: 16.sp,decoration: TextDecoration.none,
                            // )
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print("object");
                        // context.go('home');
                        context.go('/home');
                      },
                      child: Container(
                        child: Text("Home",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // context.go('/filter/${"all"}');
                      },
                      child: Container(
                        child: Text("Category",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      child: Text("About",
                          style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      child: Text("Contact Us",
                          style: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.go('/login');

                      },
                      child: Container(
                        child: Text("Login",
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              decoration: TextDecoration.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
        );
      },
    );
  }

}

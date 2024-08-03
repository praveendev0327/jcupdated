import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  final category = [
    {"img" : "assets/fv.png", "name" : "Fruits & Vegitables" },
    {"img" : "assets/att.png", "name" : "Atta,Rice,Oil & Dals" },
    {"img" : "assets/mas1.png", "name" : "Masala & Dry Fruits" },
    {"img" : "assets/chh.png", "name" : "Sweet Cravings" },
    {"img" : "assets/froz.png", "name" : "Frozen Food & Ice Creams" },
    {"img" : "assets/daa.png", "name" : "Dairy, Bread & Egg" },
    {"img" : "assets/drr.png", "name" : "Cold Drinks & Juices" },
    {"img" : "assets/mee.png", "name" : "Meat & Fish" },
    {"img" : "assets/coo.png", "name" : "Tea & Coffee & More" },
    // {"img" : "assets/gr5.jpg", "name" : "Biscuits & Cookies" },
    {"img" : "assets/baa.png", "name" : "Bath, Body & Hair" },
    {"img" : "assets/moo.png", "name" : "Accessories" },
    {"img" : "assets/hoo.png", "name" : "Home Needs" },
    // {"img" : "assets/gr5.jpg", "name" : "Stationery & Crafts" },
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      child: Container(
        height: heightSize,
        margin: EdgeInsets.only(bottom: 100),
        // color: Colors.deepOrangeAccent,
        child: GridView.builder(
          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widthSize < 600 ? 4 : widthSize < 1120 ? 4 :   6,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: isMobile ? 2.5/4 : 2.5/3,
          ),
          // itemCount: collectionListData.length  > maxItems ? maxItems : collectionListData.length,
          itemCount: category.length ,
          itemBuilder: (BuildContext context, int index) {
            return
              // Expanded(
              //     child:
                  // OnHover(
                  //     builder: (isHovered) {
                  //       return
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
      
                      margin: EdgeInsets.all(6),
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
      
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE7F0DC),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          height: isMobile ? 100 : heightSize * 0.3,
                                          width: widthSize,
                                          // color: Colors.blue,
                                          child: Image.asset(
                                            '${category[index]["img"]}',
                                            fit: BoxFit.contain,)),
                                    ),
      
                                    Container(
                                      // color: Colors.blueGrey,
                                      height: isMobile ? heightSize * 0.08 : heightSize * 0.1,
                                      width: widthSize,
                                      child: Text(category[index]["name"] as String,
                                        style: GoogleFonts.roboto(
                                          fontSize: isMobile ? 12 : 16,
                                          fontWeight: isMobile ?FontWeight.w500 :  FontWeight.bold,
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     IconButton(
                                    //       icon: Icon(Icons.remove),
                                    //       color: Colors.red,
                                    //       onPressed:  () => _decrementQuantity(index),
                                    //     ),
                                    //     Container(
                                    //       padding: EdgeInsets.symmetric(horizontal: 5.0),
                                    //       // color: Colors.blueGrey,
                                    //       child: Text(
                                    //           '${collectionListData[index].qty}',
                                    //           style: GoogleFonts.roboto(
                                    //             fontSize: 18.sp,
                                    //
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.black,
                                    //             decoration: TextDecoration.none,
                                    //           )
                                    //       ),
                                    //     ),
                                    //     IconButton(
                                    //       icon: Icon(Icons.add),
                                    //       color: Colors.green,
                                    //       onPressed: () => _incrementQuantity(index),
                                    //     ),
                                    //   ],
                                    // ),
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
              // );
            // }
      
            // );
          },
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/screens/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

   final banner = [
     // "assets/gr5.jpg",
     "assets/bn2.png",
     "assets/bn1.jpeg",
     // "assets/gr4.jpg",
     // "assets/bgr1.jpg",
     "assets/bgr7.jpg",
     // "assets/bgr6.png",
   ];

   final banner1 = [
     "assets/bgr1.jpg",
     "assets/bgr7.jpg",
     "assets/bgr6.png",
     "assets/gr5.jpg",
     "assets/gr4.jpg",

   ];

   final best = [

     {"img" : "assets/froz.png", "name" : "Frozen Food & Ice Creams" },
     {"img" : "assets/daa.png", "name" : "Dairy, Bread & Egg" },
     {"img" : "assets/drr.png", "name" : "Cold Drinks & Juices" },
     {"img" : "assets/mee.png", "name" : "Meat & Fish" },
     {"img" : "assets/coo.png", "name" : "Tea & Coffee & More" },
     {"img" : "assets/chh.png", "name" : "Sweet Cravings" },
   ];

   final bests = [
     {"img" : "assets/mee.png", "name" : "Meat & Fish" },
     {"img" : "assets/coo.png", "name" : "Tea & Coffee & More" },
     {"img" : "assets/chh.png", "name" : "Sweet Cravings" },
     {"img" : "assets/froz.png", "name" : "Frozen Food & Ice Creams" },
     {"img" : "assets/daa.png", "name" : "Dairy, Bread & Egg" },
     {"img" : "assets/drr.png", "name" : "Cold Drinks & Juices" },

   ];

   final category = [
     {"img" : "assets/fv.png", "name" : "Fruits & Vegitables", "data" : [
       {"name": "VEGETABLES","id": "VEGETABLE", "img": "assets/i1.png"},
       {"name": "FRUITS","id": "FRUITS", "img": "assets/i2.jpg"}
     ] },
     {"img" : "assets/att.png", "name" : "Atta,Rice,Oil & Dals" ,"data" : [
       {"name": "ATTA","id": "ATTA", "img": "assets/jc/albach.jpg"},
       {"name": "OIL & GHEE","id": "Oil & Ghee", "img": "assets/jc/wzh.png"},
       {"name": "DAL","id": "DAL", "img": "assets/jc/chma.jpg"},
       {"name": "SUGAR","id": "SUGAR", "img": "assets/jc/volgasug.jpg"},
       {"name": "RICE","id": "Rice Products", "img": "assets/jc/grice.jpeg"},
     ]},
     {"img" : "assets/mas1.png", "name" : "Masala Powders", "data" : [
       {"name": "MASALA","id": "Masala Powders", "img": "assets/jc/wnel.png"},
       {"name": "COCONUT POWDER","id": "Coconut Milk powder", "img": "assets/jc/cc1.jpg"},
       {"name": "SPICES","id": "SPICES", "img": "assets/jc/ssp1.jpg"},

     ]},
     {"img" : "assets/chh.png", "name" : "Sweet Cravings" ,"data" : [
       {"name": "CHOCOLATE","id": "ALL CHOCOLATE", "img": "assets/jc/cho.png"},
       {"name": "CANDY","id": "CANDY", "img": "assets/jc/can.png"},
     ]},
     {"img" : "assets/froz.png", "name" : "Ice Creams & Frozen Food" ,"data" : [
       {"name": "ICE CREAM","id": "ICE CREAM", "img": "assets/jc/ic.jpg"},
       {"name": "FROZEN","id": "FROZEN", "img": "assets/jc/mixvg.jpeg"},
     ]},
     {"img" : "assets/daa.png", "name" : "Dairy, Bread & Egg", "data" : [
       {"name": "BAKERY","id": "BAKERY", "img": "assets/jc/ba1.png"},
       {"name": "MILK","id": "MILK PRODUDCT", "img": "assets/jc/mill.jpg"},
       {"name": "MILK POWDER","id": "MILK POWDER", "img": "assets/jc/milp.jpg"},
     ]},
     {"img" : "assets/drr.png", "name" : "Cold Drinks & Juices" , "data" : [
       {"name": "SOFT DRINKS","id": "SOFT DRINKS", "img": "assets/jc/co.png"},
       {"name": "WATER","id": "WATER", "img": "assets/jc/maiw15.jpg"},
     ]},
     // {"img" : "assets/mee.png", "name" : "Meat & Fish", "data" : [
     //   {"name": "DRY FISH","id": "DRY FISH", "img": "assets/i1.png"},
     // ] },
     {"img" : "assets/coo.png", "name" : "Tea & Coffee & Breakfast" , "data" : [
       {"name": "TEA & COFFEE","id": "Tea & COFFEE", "img": "assets/jc/dff.jpg"},
       {"name": "BREAKFAST","id": "Breakfast Products", "img": "assets/jc/br.jpg"},
       {"name": "JAM & SYRUPS","id": "Syrups, Jams & Paste", "img": "assets/jc/neljam.jpg"},
     ]},
     {"img" : "assets/jc/bl.jpg", "name" : "Biscuits & Chips" , "data" : [
       {"name": "BISCUIT","id": "BISCUIT", "img": "assets/jc/bis.jpg"},
       {"name": "CHIPS","id": "LAYS", "img": "assets/jc/lays.jpg"},
     ]},
     {"img" : "assets/jc/aass.jpg", "name" : "Assorted & Pickle" , "data" : [
       {"name": "ASSORTED PRODUCTS","id": "Assorted Items", "img": "assets/jc/aass.jpg"},
       {"name": "PICKLE","id": "Pickle", "img": "assets/jc/lpic.jpeg"},
       {"name": "TIN PRODUCTS","id": "TIN PRODUCT", "img": "assets/jc/tin.jpg"},
     ]},
     {"img" : "assets/jc/ro1.jpg", "name" : "Roastery & Dry Fruits" , "data" : [
       {"name": "ROASTERY LOOSE","id": "ROASTERY LOOSE", "img": "assets/jc/ro1.jpg"},
       {"name": "ROASTERY PACK","id": "ROASTERY PACK", "img": "assets/jc/alma.jpg"},
     ]},
     // {"img" : "assets/gr5.jpg", "name" : "Biscuits & Cookies" },
     {"img" : "assets/baa.png", "name" : "Bath, Body & Medicine" , "data" : [
       {"name": "MEDICINE","id": "MEDICINE", "img": "assets/jc/med.jpg"},
       {"name": "ROll ON","id": "ROLL-ON", "img": "assets/jc/rol1.jpg"},
       {"name": "DIAPER & PAD","id": "DIAPER AND PAD", "img": "assets/jc/apad.jpg"},
     ]},
     {"img" : "assets/moo.png", "name" : "Accessories" , "data" : [
       {"name": "ACCESSORIES","id": "ACCESSORIES", "img": "assets/moo.png"},
       {"name": "SMART WATCH","id": "SMART WATCH", "img": "assets/jc/smw.jpg"},
       {"name": "PERFUME","id": "ALL KIND OF PERFUME", "img": "assets/jc/cc.jpg"},
       // {"name": "WATCH","id": "ALL WATCH ITEM", "img": "assets/jc/apad.jpg"},
     ]},
     {"img" : "assets/hoo.png", "name" : "Home Needs" , "data" : [
       {"name": "HOUSE HOLD","id": "HOUSE HOLD", "img": "assets/hoo.png"},
       {"name": "DETERGENT","id": "DETERGENT", "img": "assets/jc/coli.jpg"},
     ]},
     {"img" : "assets/jc/sta.jpg", "name" : "Stationery & Crafts" , "data" : [
       {"name": "STATIONERY","id": "STATIONERY", "img": "assets/jc/sta.jpg"},
     ]},
     // {"img" : "assets/gr5.jpg", "name" : "Stationery & Crafts" },
   ];

   final datas = [
     {"name": "asd", "email": "ssss"},
     {"name": "asd", "email": "ssss"}
   ];


   @override
  void initState() {
     // loadData();
  }

   void loadData() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String? Data = prefs.getString('userLogin');
     print("userLogin ${Data}");
     setState(() {
       if(Data == "1"){
         context.go('/delivery');
       }


     });
   }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      child: Container(
          // height: heightSize,
          // : isMobile ? 100 : 250,
        // padding: EdgeInsets.all( isMobile ? 0 : 55),
          width:  widthSize,
          padding: EdgeInsets.all( isMobile ? 8 : 15),
      
            child: Column(
              children: [
                CarouselSlider(
                  items: banner
                      .map((item) =>
                      Container(
                        width: widthSize,
      
                        child: Image.asset(
                          item.toString(),
                          fit: BoxFit.fill,
      
                          errorBuilder: (context, error,
                              stackTrace) {
                            return Container(
                              // width: 100,
                              // height: 100,
                              color: Colors.grey,
                              child: Center(
                                child: Icon(
                                    Icons.broken_image),
                              ),
                            );
                          },
                        ),
                      ),
                  ).toList(),
                  options: CarouselOptions(
                    height: isMobile ? screenSize.height*0.17 : screenSize.height*0.3, // Customize the height of the carousel
                    autoPlay: true, // Enable auto-play
                    enlargeCenterPage: true, // Increase the size of the center item
                    enableInfiniteScroll: true, // Enable infinite scroll
                    onPageChanged: (index, reason) {
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Explore By Categories",
                      style: GoogleFonts.roboto(
                        fontSize : 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),),
      
      
                    GestureDetector(
                      onTap: (){
                        // context.go("/offers");
                      },
                      child: Text("",
                        style: GoogleFonts.roboto(
                          fontSize : 12 ,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrangeAccent,
                          decoration: TextDecoration.none,
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: isMobile ? 650 : 650,
                  // color: Colors.deepOrangeAccent,
                  padding: EdgeInsets.all( isMobile ? 0 : 55),
                  child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widthSize < 600 ? 4 : widthSize < 1120 ? 4 :   6,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: isMobile ? 2.5/4 : 4/4,
                        ),
                        // itemCount: collectionListData.length  > maxItems ? maxItems : collectionListData.length,
                        itemCount: category.length ,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            // Expanded(
                            // child:
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
                                        GestureDetector(
                                          onTap: (){
                                            // context.go("/offers");
                                            final data = category[index]["data"];
                                            context.go('/explorer', extra: data);
                                          },
                                          child: Center(
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
                                                              height: isMobile ? 100 : 150,
                                                              width: widthSize,
                                                              // color: Colors.blue,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(12),
                                                                child: Image.asset(
                                                                  category[index]["img"] as String,
                                                                  fit: BoxFit.fitHeight,),
                                                              )),
                                                        ),
                                                        SizedBox(height: 2,),
                                                        Container(
                                                          // color: Colors.blueGrey,
                                                          height: isMobile ? heightSize * 0.08 : 20,
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
                                      ),
                                    );
                          // );
                                // }
      
                          // );
                        },
                      ),
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Best Sellers",
                      style: GoogleFonts.roboto(
                        fontSize : 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),),
      
      
                    Text("See All >",
                      style: GoogleFonts.roboto(
                        fontSize : 12 ,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrangeAccent,
                        decoration: TextDecoration.none,
                      ),),
                  ],
                ),
                SizedBox(height: 0,),
      
                Container(
                  height: 230,
                  // color: Colors.deepOrangeAccent,
                  child:
                      ListView.builder(
                        // controller: _scrollController,
                        scrollDirection:
                        Axis.horizontal, // Set the scroll direction to horizontal
                        itemCount: best.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print("object ${productData[index].name}");
                          return
      
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    image: DecorationImage(
                                      image: AssetImage("assets/bbg.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // height: isMobile ? heightSize * 0.04 : 300.h,
                                          width: 150,
                                          height: 100,
                                          child: Image.asset(
                                            best[index] ["img"] as String ,
                                            fit: BoxFit.cover,)
                                      ),
                                      Container(
                                        height: 20,
                                        width: 150,
                                        child: Center(
                                          child: Text(best[index] ["name"] as String,
                                            style: GoogleFonts.teko(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 150,
                                        child: Center(
                                          child: Text("AED 19.99",
                                            style: GoogleFonts.teko(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.deepOrange,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
      
                        },
                      ),
                ),
                SizedBox(height: 0,),
                // CarouselSlider(
                //   items: banner1
                //       .map((item) =>
                //       Container(
                //         width: widthSize,
                //         child: Image.network(
                //           item.toString(),
                //           fit: BoxFit.fill,
                //           errorBuilder: (context, error,
                //               stackTrace) {
                //             return Container(
                //               // width: 100,
                //               // height: 100,
                //               color: Colors.grey,
                //               child: Center(
                //                 child: Icon(
                //                     Icons.broken_image),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //   ).toList(),
                //   options: CarouselOptions(
                //     height: screenSize.height*0.17, // Customize the height of the carousel
                //     autoPlay: true, // Enable auto-play
                //     enlargeCenterPage: true, // Increase the size of the center item
                //     enableInfiniteScroll: true, // Enable infinite scroll
                //     onPageChanged: (index, reason) {
                //     },
                //   ),
                // ),
                SizedBox(height: 0,),
                Container(
                  height: 150,
                  // color: Colors.deepOrangeAccent,
                  child:  ListView.builder(
                        // controller: _scrollController,
                        scrollDirection:
                        Axis.horizontal, // Set the scroll direction to horizontal
                        itemCount: banner1.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print("object ${productData[index].name}");
                          return
      
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
      
                                  decoration: BoxDecoration(
                                    // color: Color(0xFFF8C794),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // height: isMobile ? heightSize * 0.04 : 300.h,
                                          width: 200,
                                          height: 100,
                                          child: Image.asset(
                                            banner1[index] ,
                                            fit: BoxFit.cover,)),
      
                                    ],
                                  )
                              ),
                            );
      
                        },
                      ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Exclusive Offers",
                      style: GoogleFonts.roboto(
                        fontSize : 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),),
      
      
                    Text("See All >",
                      style: GoogleFonts.roboto(
                        fontSize : 12 ,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrangeAccent,
                        decoration: TextDecoration.none,
                      ),),
                  ],
                ),
                SizedBox(height: 0,),
                Container(
                  height: 220,
                  // color: Colors.deepOrangeAccent,
                  child: ListView.builder(
                        // controller: _scrollController,
                        scrollDirection:
                        Axis.horizontal, // Set the scroll direction to horizontal
                        itemCount: bests.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print("object ${productData[index].name}");
                          return
      
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
      
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // height: isMobile ? heightSize * 0.04 : 300.h,
                                          width: 150,
                                          height: 100,
                                          child: Image.asset(
                                            bests[index] ["img"] as String ,
                                            fit: BoxFit.cover,)
                                      ),
                                      Container(
                                        height: 20,
                                        width: 150,
                                        child: Center(
                                          child: Text(bests[index] ["name"] as String,
                                            style: GoogleFonts.teko(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black38,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 150,
                                        child: Center(
                                          child: Text("AED 19.99",
                                            style: GoogleFonts.teko(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.deepOrange,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
      
                        },
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Feature for you",
                      style: GoogleFonts.roboto(
                        fontSize : 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),),
      
      
                    Text("See All >",
                      style: GoogleFonts.roboto(
                        fontSize : 12 ,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrangeAccent,
                        decoration: TextDecoration.none,
                      ),),
                  ],
                ),
                SizedBox(height: 0,),
                Container(
                  height: 150,
                  // color: Colors.deepOrangeAccent,
                  child: ListView.builder(
                        // controller: _scrollController,
                        scrollDirection:
                        Axis.horizontal, // Set the scroll direction to horizontal
                        itemCount: best.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print("object ${productData[index].name}");
                          return
      
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
      
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8C794),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // height: isMobile ? heightSize * 0.04 : 300.h,
                                          width: 150,
                                          height: 100,
                                          child: Image.asset(
                                            best[index] ["img"] as String ,
                                            fit: BoxFit.cover,)),
                                      Container(
                                        height: 20,
                                        width: 150,
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text(best[index] ["name"] as String,
                                            style: GoogleFonts.teko(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
      
                        },
                      ),
                ),
                SizedBox(height: 60,),
              ],
            ),
      
      
      
        ),
    );

  }
}

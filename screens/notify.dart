import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Notify extends StatefulWidget {
  final Map<String, dynamic> data;
  const Notify({super.key,required this.data});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    print("object${widget.data}");
    var messageData = widget.data;
    return Container(
      height: heightSize,
      width: widthSize,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: widthSize,
           padding: EdgeInsets.all(20),
            child:
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      context.go('/delivery');
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
          SizedBox(height: 30,),
          Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    '${messageData["title"]}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    '${messageData["body"]}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}

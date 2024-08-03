import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justcall/screens/login.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height ,
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          SizedBox(height: 40),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // print("object");
                // context.go('home');
                context.go('/');
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
          SizedBox(height: 20),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                context.go("/offers");
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
          SizedBox(height: 20),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                context.go('/products');
              },
              child: Container(
                child: Text("Grocerys",
                    style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    )),
              ),
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // context.go('/login');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

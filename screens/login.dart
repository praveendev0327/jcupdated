import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justcall/screens/productdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late Timer _timer;
  int _currentIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late final FirebaseAuth _firebaseAuth;
  final fn = FocusNode();
  bool screenChangeStatus = false;
  bool? indicator = false;
  // bool o = false;

  List<String> _imageUrls = [
    'assets/jc1.png',


    // 'assets/gr5.jpg'
    // Add more image URLs as needed
  ];

  @override
  void initState() {

    super.initState();
    // _focusNode.addListener(() {
    //   print('Focus: ${_focusNode.hasFocus}');
    // });
    // Start the timer when the widget is initialized//
    // _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   setState(() {
    //     // Update the current index to display the next image//
    //     _currentIndex = (_currentIndex + 1) % _imageUrls.length;
    //   });
    // });

    //CURRENT LOGED USER DETAILS//
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // // print(' user: ${currentUser}');
    // if (currentUser != null) {
    //   // print('Current user: ${currentUser.email}');
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(currentUser!.uid)
    //       .get()
    //       .then((DocumentSnapshot documentSnapshot) {
    //     if (documentSnapshot.get('role') == "Admin") {
    //       // print("Login by Admin => ${documentSnapshot.get('role')}");
    //     }else{
    //       print("Login by User");
    //     }
    //   });
    //
    // } else {
    //   print('No user signed in');
    // }

  }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  //   // _timer?.cancel();
  //   // print("First Page timer cancelled");
  // }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  // Future<void> _getUserInfo() async{
  //   final GoogleSignInAccount? googleUser =  await GoogleSignIn().signIn();
  //   if (googleUser != null) {
  //     // Obtain the GoogleSignInAuthentication object
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     // Access user information
  //     // print('User ID: ${googleUser.id}');
  //     // print('Display Name: ${googleUser.displayName}');
  //     // print('Email: ${googleUser.email}');
  //     // print('Profile Photo URL: ${googleUser.photoUrl}');
  //
  //     // The ID token can be used to authenticate the user with a backend server
  //     // print('ID Token: ${googleAuth.idToken}');
  //   }
  // }

  // LOGIN WITH LOGIN CREDENTIALS
  void _signIn() async {
    print("SIgnIn");
    // print("screenStatus $screenChangeStatus");
    // print("email ${_emailController.text.trim()}");
    // print("email ${_passwordController.text.trim()}");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the home screen or display a success message
      // print("Signed in: ${userCredential.user?.email}");

      print("Step 1");
      User? user = FirebaseAuth.instance.currentUser;
      var kk =  FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {


        if (documentSnapshot.get('role') == "Admin") {
          // context.go('/dashboard');
          // print("Login by Admin SignIn FUnction");
        }else{
          print("Login by User");

        }

      });
      print("Step 2");

      _emailController.clear();
      _passwordController.clear();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'wrong-password':
          message = 'The password is incorrect.';
          break;
        case 'user-not-found':
          message = 'No user found for this email.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many sign-in attempts. Please try again later.';
          break;
        default:
          message = 'An undefined Error happened.';
      }
      print("Error: $message");
      // Show the error message to the user, e.g., using a dialog or a Snackbar
    }
  }



  Future<void> _signUp() async {
    print("SIgnUp");
    // print("screenStatus $screenChangeStatus");
    User? user;
    // print("email ${_emailController.text.trim()}");
    // print("password ${_passwordController.text.trim()}");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('Step 1');
      var currentUserInfo = FirebaseAuth.instance.currentUser;
      CollectionReference ref = FirebaseFirestore.instance.collection('users');
      ref.doc(currentUserInfo!.uid).set({'email': _emailController.text.trim(), 'role': "User"});
      print('Step 2');
      user = userCredential.user;
      // print("User Details => ${user}");
      // Access the access token from the AuthCredential object
      final String? accessToken = userCredential.credential?.accessToken;
      if (accessToken != null) {
        print('Access Token: $accessToken');
      } else {
        print('Access Token not available');
      }
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      print("Sign up successfully");
      setState(() {
        screenChangeStatus = false ;
      });
      // Navigate to another screen upon successful signup
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      print("Sign up failed: $e");
      // Show error message to the user
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up failed')));
    }
  }

  //ROLEBASED AUTHENTICATIONS

  // Future<void> postDetailsToFirestore(String email, String rool) async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   var user = _auth.currentUser;
  //   CollectionReference ref = FirebaseFirestore.instance.collection('users');
  //   ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
  // }



  //LOGIN WITH GOOGLE CREDENTIALS
  // Future<void> _signInWithGoogle() async {
  //   final googleProvider = GoogleAuthProvider();
  //   User? user;
  //   try{
  //     final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
  //     user = userCredential.user;
  //     // print("User Details => ${user}");
  //     // Access the access token from the AuthCredential object
  //     final String? accessToken = userCredential.credential?.accessToken;
  //     if (accessToken != null) {
  //       // print('Access Token: $accessToken');
  //     } else {
  //       print('Access Token not available');
  //     }
  //     //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool("auth", true);
  //
  //   } on FirebaseException catch (e){
  //     print("User Details => ${e.message}");
  //     if(mounted){
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //               content: Text("Failed to sign in with google : ${e.message}")
  //           ));
  //     }
  //   } catch (e){
  //     if(mounted){
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //               content: Text("Failed to sign in with google : ${e}")
  //           ));
  //     }
  //   }
  // }
  Future<void> _signOutGoogle () async{
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("auth", false);
    print('User signed out successfully');
  }

  void saveData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String jsonData = jsonEncode(data); // Convert map to JSON string
    await prefs.setString('userLogin', data); // Save JSON string to Shared Preferences
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    final FocusNode _focusNode = FocusNode();

    void loginUser() async {
      // final prefs = await SharedPreferences.getInstance();
      print('login');
      try {
        final data ={
          "email" : _emailController.text.trim(),
          "password" : _passwordController.text.trim()
        };
        final response = await http.post(
          Uri.parse("https://justcalltest.onrender.com/api/users/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          // Successfully sent data
          // print('login successfully');
          final fetch = json.decode( response.body);
          // print('login fetch : ${fetch }');
          // print('login successfully : ${fetch["data"][0] }');
          final checkUser = fetch["data"][0];
          // print('checkUser: ${checkUser["email"] }');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProductDashboard()),
          // );
          setState(() {
            indicator = false;
          });
          if(checkUser["email"] == "admin@gmail.com" && checkUser["password"] == _passwordController.text.trim()){
            // await prefs.setString('login', "1");
             saveData("0");
            context.go("/productdashboard");
          } else {
            List<String> parts = checkUser["email"].split('@');
            if(parts[1] == "delivery.ae"){
              saveData("1");
              context.go("/delivery");
            }else{
              saveData("2");
              context.go("/");
            }
            // await prefs.setString('login', "2");
          }
          _emailController.clear();
          _passwordController.clear();



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
        _emailController.clear();
        _passwordController.clear();
      }
    }
    return
      SafeArea(
        child: Scaffold(
        
          body: SingleChildScrollView(
            child: Container(
              // color: Color(0xFFE1F0DA),
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child:
              Row(
                children: [
                  isMobile ? SizedBox() :
                  Container(
                    color: Color(0xFFE1F0DA),
                    height: MediaQuery.of(context).size.height,
                    width:  MediaQuery.of(context).size.width/2,
                    child: Stack(
                      children: [
                        Positioned(
                          // height: heightSize * 0.5,
                          // right: widthSize * 0.22,
                            child: Container(
                              width: widthSize,
                              height: heightSize  ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child:
                              Image.asset(_imageUrls[_currentIndex], fit: BoxFit.contain)
                              ,
                            )),
                        // Positioned(
                        //     height: heightSize * 0.2 ,
                        //     width: widthSize * 0.25,
                        //     right: MediaQuery.of(context).size.height /4 ,
                        //     top: MediaQuery.of(context).size.height * 0.35,
                        //     child: Container(
                        //       width: widthSize ,
                        //       height: heightSize * 0.8 ,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(0),
                        //       ),
                        //       child: Image.asset('assets/jc1.png', fit: BoxFit.contain),
                        //     )),
                        // Positioned(
                        //     width: MediaQuery.of(context).size.width/2,
                        //     // right: 0.r,
                        //     left: 150.r ,
                        //     top: MediaQuery.of(context).size.height * 0.55,
                        //     child: Container(
                        //       // height: widthSize> 500 ? 400.r : 200.r,
                        //       width:  MediaQuery.of(context).size.width/2 ,
                        //       child: Text("FASHION",
                        //           style: GoogleFonts.lexendMega(
                        //             fontSize: 70,
                        //             fontWeight: FontWeight.bold,
                        //             color: Color(0xFFFFFFFF),
                        //             decoration: TextDecoration.none,
                        //           )
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: isMobile ? widthSize : MediaQuery.of(context).size.width/2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          screenChangeStatus ? SizedBox(height: 30,) :  SizedBox(height: 50,),
                          Container(
                            child: Center(
                              child:
                              // Text(screenChangeStatus ? "REGISTER" : "LOGIN",
                              //     style: GoogleFonts.josefinSans(
                              //       fontSize : 28.sp ,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.black,
                              //       decoration: TextDecoration.none,
                              //     )
                              // ),
                              Image.asset('assets/jc1.png', fit: BoxFit.contain, height: 64,width: 200,)
                            ),
                          ),
                          screenChangeStatus ? SizedBox(height: 0,) :  SizedBox(height: 40,),
                          Container(
                            width:isMobile ? widthSize : widthSize * 0.3,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Material(
                                      child: TextFormField(
            
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          labelText: 'Username',
                                          border: UnderlineInputBorder(),
                                          labelStyle:GoogleFonts.josefinSans(
                                            fontSize : 18 ,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black54,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        // keyboardType: TextInputType.text,
                                        // textInputAction: TextInputAction.done,
                                        // focusNode: _focusNode,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your username';
                                          }
                                          // Check if username matches the regex pattern
                                          if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                                            return 'Invalid username';
                                          }
                                          return null;
                                        },
                                        // onSaved: (value) {
                                        //   _username = value!;
                                        // },
                                      ),
                                    ),
                                    SizedBox(height: 40.0),
                                    Material(
                                      child: TextFormField(
            
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: UnderlineInputBorder(),
                                          labelStyle:GoogleFonts.josefinSans(
                                            fontSize : 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black54,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        // keyboardType: TextInputType.text,
                                        // textInputAction: TextInputAction.done,
                                        // focusNode: _focusNode,
                                        validator: (value) {
            
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          // Check if password ,[A-Z]) matches the regex pattern
                                          if (!RegExp(r'^(?=.*?(?=.*?[a-z])(?=.*?[0-9]).{8,}$)')
                                              .hasMatch(value)) {
                                            return 'Invalid password';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    screenChangeStatus ? SizedBox(height: 40.0) : SizedBox(),
                                    screenChangeStatus ? Material(
                                      child: TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          border: UnderlineInputBorder(),
                                          labelStyle:GoogleFonts.josefinSans(
                                            fontSize : 18 ,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black54,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your confirm password';
                                          }
                                          // Check if password matches the regex pattern
                                          if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
                                            return 'Password must match';
                                          }
                                          return null;
                                        },
                                      ),
                                    ) : SizedBox(),
                                    screenChangeStatus ? SizedBox() : SizedBox(height: 30,),
                                    screenChangeStatus ? SizedBox() : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text("Forgot password?",
                                            style: GoogleFonts.teko(
                                              fontSize : 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.green,
                                              decoration: TextDecoration.none,
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // if (_formKey.currentState!.validate()) {
                                        //   _formKey.currentState!.save();
                                        //   // print('login Successfully');
                                        //   // screenChangeStatus ? _signUp() : _signIn();
                                        //
                                        // }
                                        setState(() {
                                          indicator = true;
                                        });
                                        loginUser();
                                        // context.go("/admin");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0), // Set the border radius to 0 for a rectangular shape
                                        ), backgroundColor: Colors.green,
                                        minimumSize: Size(double.infinity, 50),
                                      ),
                                      child: indicator == true
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
                                          : Text(screenChangeStatus ?'Register':'Login',
                                        style: GoogleFonts.teko(
                                          fontSize : 22 ,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        ),),
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
            
                                        Text("---------- or ----------",
                                            style: GoogleFonts.teko(
                                              fontSize : 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.green,
                                              decoration: TextDecoration.none,
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // _signInWithGoogle();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0), // Set the border radius to 0 for a rectangular shape
                                        ), backgroundColor: Color(0xFFA8A9AD),
                                        minimumSize: Size(double.infinity, 50),
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 20,
                                                width: 20,
                                                child: Image.asset('assets/google5.png', fit: BoxFit.contain,)),
                                            SizedBox(width: 15,),
                                            Text('Sign in with Google',
                                              style: GoogleFonts.teko(
                                                fontSize : 22,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                              ),),
            
                                          ]
                                      ),
                                    ),
                                    SizedBox(height: 30,) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
            
                                        Text(screenChangeStatus ?
                                        "Already have an account?" : "New to JustCall?",
                                            style: GoogleFonts.josefinSans(
                                              fontSize : 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              decoration: TextDecoration.none,
                                            )
                                        ),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            // Action to perform when the text is clicked
                                            setState(() {
                                              if(screenChangeStatus == true){
                                                screenChangeStatus = false;
                                              } else{
                                                screenChangeStatus = true;
                                              }
                                            });
                                          },
                                          child: Text(screenChangeStatus ? "Login" : "Create Account",
                                              style: GoogleFonts.josefinSans(
                                                fontSize : 16 ,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.green,
                                                decoration: TextDecoration.none,
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:justcall/init/Initial.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/screens/admin.dart';
import 'package:justcall/screens/cart.dart';
import 'package:justcall/screens/form.dart';
import 'package:justcall/screens/landing.dart';
import 'package:justcall/screens/login.dart';
import 'package:justcall/screens/offer.dart';
import 'package:justcall/screens/product.dart';
import 'package:justcall/screens/productdashboard.dart';
import 'package:justcall/screens/profile.dart';
import 'package:justcall/screens/init.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

class SubMain extends StatefulWidget {
  const SubMain({super.key});

  @override
  State<SubMain> createState() => _SubMainState();
}

class _SubMainState extends State<SubMain> {
  String loginStatus = '0';


  @override
  void initState() {
    super.initState();
    // _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loginStatus = prefs.getString('login') ?? '0';
    });
    print("object${loginStatus}");
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;


      final GoRouter _router = GoRouter(
      // initialLocation: loginStatus == "0" ? '/' : loginStatus == "1" ? '/productdashboard' : '/' ,
      initialLocation:'/' ,

      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
          Initial(),
          // ProductDashboard(),
          // Login(),
          // MyCustomForm(),
          // Test(),
          routes: [
            GoRoute(
              path: 'productlist',
              builder: (context, state) {
                // final type = state.pathParameters['type']!;
                return Products();
              },
            ),

            // GoRoute(
            //   path: 'login',
            //   builder: (context, state) {
            //     // final type = state.pathParameters['type']!;
            //     return Login();
            //   },
            // ),
            // GoRoute(
            //   path: 'product/:id',
            //   builder: (context, state) {
            //     final id = state.pathParameters['id']!;
            //     return ViewProduct(id: id,);
            //   },
            // ),

          ],
        ),
        // GoRoute(
        //   path: '/login',
        //   builder: (context, state) => Login(),
        // ),
        GoRoute(
          path: '/home',
          builder: (context, state) => Landing(),
        ),
        GoRoute(
          path: '/offers',
          builder: (context, state) => Offers(),
        ),
        GoRoute(
          path: '/products',
          builder: (context, state) => Products(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => Cart(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => Profile(),
        ),

        GoRoute(
          path: '/admin',
          builder: (context, state) => Admin(),
        ),
        // GoRoute(
        //   path: '/productdashboard',
        //   builder: (context, state) => ProductDashboard(),
        // ),
      ],

    );

    return
      // Scaffold(
      // body: ScreenUtilInit(
      //     designSize: Size(widthSize, heightSize),
      //     child: Initial()
      // ),);
      Scaffold(
        // resizeToAvoidBottomInset: false,
        body:
        BlocProvider(
          create: (context) => ProductBloc(),
          child:
          ScreenUtilInit(
              designSize: Size(widthSize, heightSize),
              child:
              // MaterialApp(
              //     title: 'Jodilier',
              //     debugShowCheckedModeBanner: false,
              //     home:
              MaterialApp.router(
                title: 'JustCall',
                debugShowCheckedModeBanner: false,
                routerConfig: _router,
                // routerDelegate: _router.routerDelegate,
                // routeInformationParser: _router.routeInformationParser,
                // routeInformationProvider: _router.routeInformationProvider,
              )

            // ),
          ),
        ),
      );
  }
}

class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    // Handle route change events here
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // Handle route pop events here
    super.didPop(route, previousRoute);
  }
}
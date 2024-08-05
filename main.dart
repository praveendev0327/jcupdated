
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:justcall/init/Initial.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/screens/addproduct.dart';
import 'package:justcall/screens/admin.dart';
import 'package:justcall/screens/cart.dart';
import 'package:justcall/screens/cart2.dart';
import 'package:justcall/screens/category.dart';
import 'package:justcall/screens/delivery.dart';
import 'package:justcall/screens/exploreproducts.dart';
import 'package:justcall/screens/form.dart';
import 'package:justcall/screens/landing.dart';
import 'package:justcall/screens/login.dart';
import 'package:justcall/screens/notify.dart';
import 'package:justcall/screens/offer.dart';
import 'package:justcall/screens/offersweb.dart';
import 'package:justcall/screens/product.dart';
// import 'package:justcall/screens/productdashboard.dart';
import 'package:justcall/screens/profile.dart';
import 'package:justcall/screens/init.dart';
import 'package:justcall/screens/splash.dart';
import 'package:justcall/submain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// await Firebase.initializeApp();
  print('Handling a background message: ${message}');
}

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true);
  final channel =
  AndroidNotificationChannel('default_channel_id', 'default_channel_id',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      showBadge: true,
      enableVibration: true,
      playSound: true);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_launcher');
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print("FCM : ${fcmToken}");
  //ckwhnmBLTm2Li4PmrjAI1H:APA91bGqYv3k083hT98cCdxyVvMdqm_jVStByrEsilcCqKKp8dRaA5ZkB_g8nkr1_ncsl_ritpzUNGYGNKiStdPM4jdJ83Gc77Vkomk5vShCh2GksQjf3SmSgSIIS0I4ynVnvEHt3ok_
  //accesstoken:7664811f1de7ee912bf0d45aae214af6dd6c0272

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
   Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();
  final localNotification = FlutterLocalNotificationsPlugin();

  var androidData = const AndroidNotificationDetails(
    'default_channel_id',
    'default_channel_id',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    icon: '@drawable/ic_launcher',
  );
  late final String? userLoginData;
  bool? messageStatuss = false;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print('Received a message while in the foreground: ${message.messageId}');
      // if(Platform.isAndroid) {
        // var platform = await NotificationDetails(android: androidData);
        localNotification.show(
            1,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(android: androidData),
            payload: jsonEncode(message.toMap())
        );
      // }

      // openMes(message);
      // Handle foreground message
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      print('A new onMessageOpenedApp event was published: ${message.data}');
      // Handle app opened from notification
      // _prefs.setString('key', 'value');
      // context.go("/delivery");
      openMes(message);
    });


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM Token: $token");
    });
    // loadData();
  }

  Future<void> _firebaseMessagingBackgroundHandlers(RemoteMessage message) async {
// await Firebase.initializeApp();
    print('Handling a background message: ${message}');
  }

  Future<String?> _setMessageStatus() async {
    final SharedPreferences prefs = await _prefs;
    // _prefs.setString('key', 'value');
  }

  Future<String?> _getInitialRoute() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('messageStatus');
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Data = prefs.getString('userLogin');
    print("userLogin ${Data}");
    setState(() {
      if(Data == "1"){
        userLoginData = '/CartOut';
      }


    });
  }

  final GoRouter _router = GoRouter(
    initialLocation:  '/splash',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => InitialScreen(),
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) => Landing(),
      ),
      GoRoute(
        path: '/category',
        builder: (context, state) => Category(),
      ),
      GoRoute(
        path: '/offers',
        builder: (context, state) => Offers(),
      ),
      GoRoute(
        path: '/offersweb',
        builder: (context, state) => OffersWeb(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => Profile(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => Cart(),
      ),
      GoRoute(
        path: '/cartout',
        builder: (context, state) => CartOut(),
      ),
      GoRoute(
        path: '/explorer',
        // builder: (context, state) => Explorer(),
        builder: (context, state) {
          final List<Map<String, String>> data = state.extra as List<Map<String, String>>;
          return Explorer(data: data);
        },
      ),
      GoRoute(
        path: '/notify',
        // builder: (context, state) => Explorer(),
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return Notify(data: data);
        },
      ),

      GoRoute(
        path: '/delivery',
        builder: (context, state) => Delivery(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => Login(),
      ),
      // Add other routes as needed...
    ],

    // redirect: (context, state) async {
    //   // final String? userLoginData = await _getInitialRoute();
    //   if (messageStatuss == true) {
    //     return '/';
    //   } else {
    //     return '/delivery';
    //   }
    // },

  );

  void openMes (RemoteMessage message){
    var mds = {
      "title" : message.notification?.title,
      "body" : message.notification?.body,
    };
    print("object${mds}");
    final Map<String, dynamic> data = mds as Map<String, dynamic>;
    _router.go('/notify',extra: data);
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: MaterialApp.router(
        title: 'JustCall',
        routerConfig: _router,
        // routeInformationParser: _router.routeInformationParser,
        // routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: SubMain(),
        // home: const Login(),
        // home: Scaffold(body: Initial()),
        // home: MaterialApp.router(
        //   routerConfig: _router,
        //   debugShowCheckedModeBanner: false,
        //
        // ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String loginStatus = '0';
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadUsername();
  // }
  //
  // Future<void> _loadUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     loginStatus = prefs.getString('login') ?? '0';
  //   });
  //   print("object${loginStatus}");
  // }


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
            GoRoute(
              path: 'profile',
              builder: (context, state) => Profile(),
            ),
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
        //   path: '/home',
        //   builder: (context, state) => Landing(),
        // ),
        // GoRoute(
        //   path: '/offers',
        //   builder: (context, state) => Offers(),
        // ),
        // GoRoute(
        //   path: '/products',
        //   builder: (context, state) => Products(),
        // ),
        // GoRoute(
        //   path: '/cart',
        //   builder: (context, state) => Cart(),
        // ),
        // GoRoute(
        //   path: '/profile',
        //   builder: (context, state) => Profile(),
        // ),
        // GoRoute(
        //   path: '/login',
        //   builder: (context, state) => Login(),
        // ),
        // GoRoute(
        //   path: '/admin',
        //   builder: (context, state) => Admin(),
        // ),
        // GoRoute(
        //   path: '/productdashboard',
        //   builder: (context, state) => ProductDashboard(),
        // ),
      ],
      observers: [MyRouteObserver()],
    );

    return
      // Scaffold(
      // body: ScreenUtilInit(
      //     designSize: Size(widthSize, heightSize),
      //     child: Initial()
      // ),);
      Scaffold(
        // resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => ProductBloc(),
          child: ScreenUtilInit(
              designSize: Size(widthSize, heightSize),
              child:
              // MaterialApp(
              //     title: 'Jodilier',
              //     debugShowCheckedModeBanner: false,
              //     home: Login()
              MaterialApp.router(
                title: 'JustCall',
                debugShowCheckedModeBanner: false,
                routerDelegate: _router.routerDelegate,
                routeInformationParser: _router.routeInformationParser,
                routeInformationProvider: _router.routeInformationProvider,
              // )

            ),
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

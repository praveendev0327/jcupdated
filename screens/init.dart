import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justcall/components/navbar.dart';
import 'package:justcall/middleware/bloc.dart';
import 'package:justcall/middleware/state.dart';
import 'package:justcall/screens/cart.dart';
import 'package:justcall/screens/category.dart';
import 'package:justcall/screens/landing.dart';
import 'package:justcall/screens/offer.dart';
import 'package:justcall/screens/profile.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Landing(),
    Category(),
    Offers(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 900) {
              // Mobile view with bottom navigation bar
              return Column(
                children: [
                  // SizedBox(height: 50,),
                 Navbar(),
                  Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
                  BottomNavigationBar(
                    backgroundColor: Colors.orange, // Set the background color here
                    // selectedItemColor: Colors.white, // Set the color of the selected item
                    // unselectedItemColor: Colors.black,// Set the background color here
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        label: 'Category',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.discount),
                        label: 'WeekendOffers',
                      ),
                      BottomNavigationBarItem(
                        icon:  Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.deepOrangeAccent,
                    unselectedItemColor: Colors.green,
                    showUnselectedLabels: true, // Show unselected labels
                    showSelectedLabels: true, // Show selected labels
                    selectedLabelStyle: TextStyle(color: Colors.deepOrangeAccent,), // Style for selected labels
                    unselectedLabelStyle: TextStyle(color: Colors.green), // Optional: set the color of unselected items
                    onTap: _onItemTapped,
                  ),
                ],
              );
            } else {
              // Web or larger view without bottom navigation bar
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Navbar(),
                    _widgetOptions.elementAt(_selectedIndex),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
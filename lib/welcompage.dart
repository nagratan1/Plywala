import 'package:buildingmaterialusers/dashboardscreen.dart';
import 'package:buildingmaterialusers/orderhistorypage.dart';
import 'package:buildingmaterialusers/orderpage.dart';
import 'package:buildingmaterialusers/profile.dart';
import 'package:buildingmaterialusers/vendorspage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _selectedIndex = 0;
  late final String address;

  List<Widget> _widgetOptions = <Widget>[

    HomePage(),
    OrderHistoryPage(),
    SearchVendorsPage(),
    ProfilePage()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: GNav(
              gap: 8,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  iconColor: Colors.white,
                ),
                // GButton(
                //   icon: Icons.border_outer_rounded,
                //   text: 'OrderPage',
                //   iconColor: Colors.white,
                // ),
                  GButton(
                  icon: Icons.history_outlined,
                  text: 'Order History',
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.list,
                  text: 'Vendors',
                  iconColor: Colors.white,
                ),


                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  iconColor: Colors.white,
                ),

              
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


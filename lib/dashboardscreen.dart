import 'dart:async';

import 'package:buildingmaterialusers/cart_model.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DoorCategorypage.dart';
import 'Kitchencategorypage.dart';
import 'LockCategorypage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userLocation;
  int _currentIndex = 0;
  late PageController _pageController;
  int _currentPage = 0;
  final List<Map<String, String>> _bannerData = [
    {
      'image':
          'https://as2.ftcdn.net/jpg/05/43/21/15/1000_F_543211583_4NJZ9A062sNs4vtlA1pA09oYL2SbGWEU.jpg',
      'title': '30% Off!',
    },
    {
      'image':
          'https://www.blackmarbleply.com/assets/images/banner/website%20banners%20(1).jpg',
      'title': 'Free Delivery on First 10 Orders!',
    },
    {
      'image':
          'https://www.blackmarbleply.com/images/main-slider/slider1/web-banner03.png',
      'title': 'Flat 50% Off on Selected Items!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLocation(); // Load location from SharedPreferences

    // Initialize PageController for the carousel
    _pageController = PageController(initialPage: 0);

    // Set up automatic page switching for the carousel
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _bannerData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _loadLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userLocation = prefs.getString('userLocation');
    });

    // Show location dialog only if location is not saved
    if (_userLocation == null) {
      _showLocationDialog();
    }
  }

  Future<void> _saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userLocation', location);
    setState(() {
      _userLocation = location;
    });
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select Your Location",
            style:
                GoogleFonts.aboreto(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please provide your location manually or enable GPS."),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Simulate fetching GPS location
                  Navigator.pop(context);
                  _saveLocation("Current Location (via GPS)");
                },
                icon: Icon(Icons.gps_fixed),
                label: Text("Enable GPS"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter location manually",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onSubmitted: (value) {
                  Navigator.pop(context);
                  _saveLocation(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _onNavigationItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      // Show location dialog only if location is not set
      if (_userLocation == null) {
        _showLocationDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Your location: $_userLocation")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            elevation: 0,
            //centerTitle:true,
            backgroundColor: Colors.amber,
            title: Row(
              children: [
                Icon(Icons.location_on_rounded, color: Colors.black, size: 28),
                SizedBox(width: 0),
                Expanded(
                  child: GestureDetector(
                    onTap: _showLocationDialog,
                    child: Row(
                      children: [
                        Text(
                          _userLocation ?? "Select Location",
                          style: GoogleFonts.aboreto(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.black, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(cartItems: [])));
                },
                icon: Icon(Icons.add_shopping_cart, color: Colors.black),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            // Search Bar
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: 'Search for stores or items',
            //       hintStyle: mTextStyle12(),
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //   ),
            // ),

            // Carousel Slider
           CarouselSlider(
      options: CarouselOptions(height: 180, autoPlay: true),
      items: [
        {'title': 'Wood', 'image': 'assets/plywood_1.jpg'},
        {'title': 'Door', 'image': 'assets/plywood_1.jpg'},
        {'title': 'Lock', 'image': 'assets/plywood_1.jpg'},
        {'title': 'Paint', 'image': 'assets/plywood_1.jpg'},
      ].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26, // Added color for shadow
                    offset: Offset(1, 3),
                  )
                ],
                color: Colors.amber,
              ),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Ensures rounded corners for the image
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     item['title']!,
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      }).toList(),
    ),
            
            
            Container(
              height: 50,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.amber,
              ),
              child: Center(
                child: Text('Limited Time Offer: Flat 30% OFF!',
                    style: TextStyle(fontSize: 18,foreground: Paint() ..shader = LinearGradient(
                colors: [Colors.blue, Colors.purple,Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(30.0, 60.0, 300.0, 50.0)),)),
              ),
            ),
            SizedBox(height: 20),

            // Quick Access Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Categories', style: mTextStyle20()),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Doorcategorypage(categoryName: 'Door Type'),
                        ),
                      );
                    },
                    child: CategoryCard(
                        'Door', Icons.door_front_door, Colors.green),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Kitchencategorypage(
                              categoryName: 'Kitchen Type Product'),
                        ),
                      );
                    },
                    child: CategoryCard('Kitchen', Icons.kitchen, Colors.blue),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LockCategoryPage(
                              categoryName: 'Door Lock Product'),
                        ),
                      );
                    },
                    child: CategoryCard('Lock', Icons.book, Colors.orange),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text('Daily Use Products', style: mTextStyle20()),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProductCard(
                    'Door',
                    'https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889',
                    '₹350',
                  ),
                  ProductCard(
                    'Kitchen',
                    'https://3.imimg.com/data3/PQ/QJ/MY-3383277/c-type-modular-kitchen-1000x1000.jpg',
                    '₹600',
                  ),
                  ProductCard(
                    'Hings',
                    'https://m.media-amazon.com/images/I/61O8ShkddyL._AC_UF1000,1000_QL80_.jpg',
                    '₹120',
                  ),
                  ProductCard(
                    'Godrej Hinges',
                    'https://i0.wp.com/bhoomihardware.com/wp-content/uploads/2023/05/IMG_20230503_190605.jpg?fit=1836%2C1836&ssl=1',
                    '₹70',
                  ),
                ],
              ),
            ),

            // Recent Orders Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text('Recent Orders', style: mTextStyle20()),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2, // Number of recent orders
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return OrderCard(
                    'Order #${index + 1}',
                    'https://www.blackmarbleply.com/assets/images/banner/website%20banners%20(1).jpg',
                    'Delivered',
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: PageView(
                children: [
                  BannerTile(
                    'https://www.blackmarbleply.com/assets/images/banner/website%20banners%20(1).jpg',
                    '30% Off!',
                  ),
                  BannerTile(
                    'https://www.blackmarbleply.com/images/main-slider/slider1/web-banner03.png',
                    'Free Delivery!',
                  ),
                  BannerTile(
                    'https://www.blackmarbleply.com/images/main-slider/slider1/web-banner0.png',
                    '',
                  ),
                  BannerTile(
                    'https://www.blackmarbleply.com/images/main-slider/slider1/web-banner0.png',
                    '',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

// Reusable BannerTile Component
class BannerTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  BannerTile(this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(title, style: mTextStyle16()),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  CategoryCard(this.title, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 5),
          Text(title, style: mTextStyle12()),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;

  ProductCard(this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl, height: 80, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title, style: mTextStyle12()),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String imageUrl;
  final String status;

  OrderCard(this.orderId, this.imageUrl, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(orderId, style: mTextStyle16()),
                // SizedBox(height: 5),
                Text(status, style: mTextStyle12()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

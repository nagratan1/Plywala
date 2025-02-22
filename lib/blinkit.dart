import 'package:buildingmaterialusers/welcompage.dart';
import 'package:flutter/material.dart';

class BlinkitUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow[700],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_rounded
              // "Blinkit in 8 minutes",
              // style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
           Navigator.push(context,MaterialPageRoute(builder: (context)=>Welcome()));
              },
              child: Row(
                children: [
                  Text(
                    "Sector C, LDA Colony, Lucknow Division",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 16),
                ],
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.notifications_active, color: Colors.white),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search "cookies"',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Offer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOfferCard("₹50 OFF", "on first order above ₹299"),
                _buildOfferCard("Free Delivery", "on first 10 orders"),
              ],
            ),
          ),

          // Category Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to category page
                    },
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(category['image']!, width: 40, height: 40),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category['name']!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.repeat), label: "Order Again"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: "Print"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String title, String subtitle) {
    return Expanded(
      child: Card(
        elevation: 2,
        color: Colors.yellow[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample category data
final List<Map<String, String>> categories = [
  {
    "name": "Dairy, Bread & Eggs",
    "image": "https://via.placeholder.com/40",
  },
  {
    "name": "Vegetables & Fruits",
    "image": "https://via.placeholder.com/40",
  },
  {
    "name": "Oil, Ghee & Masala",
    "image": "https://via.placeholder.com/40",
  },
  {
    "name": "Chips & Namkeen",
    "image": "https://via.placeholder.com/40",
  },
  {
    "name": "Bakery & Biscuits",
    "image": "https://via.placeholder.com/40",
  },
  {
    "name": "Atta, Rice & Dal",
    "image": "https://via.placeholder.com/40",
  },
];

import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      'vendor': 'Vendor A',
      'product': 'Cement Bag',
      'price': '₹350',
      'status': 'Delivered',
      'imageUrl': 'https://img.freepik.com/premium-photo/many-ways-choose-from-open-doors-decision-making-many-ways-choose-from-open-doors-concepts-decision-making-different-opportunities-etc-3d-illustration_1028938-357771.jpg?w=1060',
      'dateTime': '2024-12-10 10:30 AM',
    },
    // {
    //   'vendor': 'Vendor B',
    //   'product': 'Bricks',
    //   'price': '₹1200',
    //   'status': 'Delivered',
    //   'imageUrl': 'https://via.placeholder.com/150',
    //   'dateTime': '2024-12-09 03:15 PM',
    // },
    // {
    //   'vendor': 'Vendor C',
    //   'product': 'Steel Rods',
    //   'price': '₹5000',
    //   'status': 'Pending',
    //   'imageUrl': 'https://via.placeholder.com/150',
    //   'dateTime': '2024-12-08 12:00 PM',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Order History',
            style: mTextStyle16(),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order['imageUrl']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  // Order Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['product']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Vendor: ${order['vendor']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Date: ${order['dateTime']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price and Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order['price']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        order['status']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: order['status'] == 'Delivered'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

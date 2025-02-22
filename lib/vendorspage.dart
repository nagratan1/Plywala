import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

class SearchVendorsPage extends StatefulWidget {
  @override
  _SearchVendorsPageState createState() => _SearchVendorsPageState();
}

class _SearchVendorsPageState extends State<SearchVendorsPage> {
  final List<Map<String, String>> vendors = [
    {'name': 'Vendor A', 'id': '1'},
    {'name': 'Vendor B', 'id': '2'},
    {'name': 'Vendor C', 'id': '3'},
    {'name': 'Vendor D', 'id': '4'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredVendors = vendors
        .where((vendor) => vendor['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Search Vendors',style: mTextStyle16())),
        backgroundColor: Colors.amber
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search vendors by name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVendors.length,
              itemBuilder: (context, index) {
                final vendor = filteredVendors[index];
                return ListTile(
                  title: Text(vendor['name']!),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorOrdersPage(vendorId: vendor['id']!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Vendor Orders Page
class VendorOrdersPage extends StatelessWidget {
  final String vendorId;

  VendorOrdersPage({required this.vendorId});

  final List<Map<String, String>> orders = [
    {'vendorId': '1', 'product': 'Cement Bag', 'price': '₹350', 'status': 'Delivered'},
    {'vendorId': '2', 'product': 'Bricks', 'price': '₹1200', 'status': 'Delivered'},
    {'vendorId': '3', 'product': 'Steel Rods', 'price': '₹5000', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    final vendorOrders = orders.where((order) => order['vendorId'] == vendorId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Vendor Orders',style: mTextStyle16() )),
        backgroundColor: Colors.amber,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: vendorOrders.length,
        itemBuilder: (context, index) {
          final order = vendorOrders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(order['product']!),
              subtitle: Text('Price: ${order['price']}'),
              trailing: Text(
                order['status']!,
                style: TextStyle(
                  color: order['status'] == 'Delivered' ? Colors.green : Colors.orange,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

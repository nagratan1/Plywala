import 'package:buildingmaterialusers/productdetails.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:flutter/material.dart';

import 'confirmatinorder.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    // Calculate total price safely
    double totalPrice = cartItems.fold(0, (sum, item) {
      double itemPrice = double.tryParse(
          item['price']?.replaceAll(RegExp(r'[^\d.]'), '') ?? '0') ??
          0;
      int itemQuantity = item['quantity'] ?? 0;
      return sum + (itemPrice * itemQuantity);
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Your Cart"),
        backgroundColor: Colors.amber,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          "Your cart is empty!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                double itemPrice = double.tryParse(
                    product['price']
                        ?.replaceAll(RegExp(r'[^\d.]'), '') ??
                        '0') ??
                    0;
                int itemQuantity = product['quantity'] ?? 0;

                return GestureDetector(
                  onTap: () {
                    // Navigate to the Product Detail Page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         ProductDetailPage(product: product)
                    //   ),
                    // );
                  },
                  child:
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Image.network(
                        product['image'] ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        product['name'] ?? 'Unknown',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "Price: ₹${itemPrice.toStringAsFixed(2)} x $itemQuantity\nSize: ${product['size'] ?? 'N/A'}"),
                      trailing: Text(
                        "₹${(itemPrice * itemQuantity).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total Price: ₹${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

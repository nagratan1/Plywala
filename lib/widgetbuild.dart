import 'package:flutter/material.dart';

Widget buildProductCard(String name, String imageUrl, double price) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          child: Image.network(
            imageUrl,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '₹${price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ),
      ],
    ),
  );
}

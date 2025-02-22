import 'package:flutter/material.dart';

class ProductImageScreen extends StatelessWidget {
  final String imageUrl;

  const ProductImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: InteractiveViewer(
            maxScale: 4.0, // Maximum zoom scale
            minScale: 1.0, // Minimum zoom scale
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

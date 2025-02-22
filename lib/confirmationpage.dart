
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String address;

  const ConfirmationPage({required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmed'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Order placed successfully!\nDelivery Address: $address',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

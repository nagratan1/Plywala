import 'package:buildingmaterialusers/ProductImageScreen.dart';
import 'package:flutter/material.dart';

import 'cart_model.dart';
import 'confirmatinorder.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  String selectedSize = "Small"; // Default size
  final List<String> availableSizes = [
    "Small",
    "Medium",
    "Large"
  ]; // Available sizes
  static List<Map<String, dynamic>> cartItems = []; // Shared cart items

  void _addToCart() {
    // Add the product to the shared cart
    final productWithDetails = {
      ...widget.product,
      'quantity': quantity,
      'size': selectedSize,
    };

    // Check if the product already exists in the cart
    final existingIndex = cartItems.indexWhere((item) =>
        item['name'] == productWithDetails['name'] &&
        item['size'] == productWithDetails['size']);

    if (existingIndex >= 0) {
      // Update the quantity of the existing item
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      // Add the product to the cart
      cartItems.add(productWithDetails);
    }

    // Show a snackbar to confirm addition
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text("$quantity x $selectedSize size added to cart!"),
          ],
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Navigate to the Cart Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.product['name']!,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductImageScreen(
                              imageUrl: widget.product['image']!,
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        widget.product['image']!,
                        // height: 240,
                        // width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Product Name
              Text(
                widget.product['name']!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Product Description
              Text(
                widget.product['description']!,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),

              // Product Price
              Text(
                widget.product['price']!,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Size Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedSize,
                    items: availableSizes
                        .map((size) => DropdownMenuItem(
                              value: size,
                              child: Text(size),
                            ))
                        .toList(),
                    onChanged: (newSize) {
                      setState(() {
                        selectedSize = newSize!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      height: 38,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white,
                          border: Border.all(color: Colors.black26)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        bottomLeft: Radius.circular(9)),
                                    color: Colors.redAccent,
                                  ),
                                  child: Icon(Icons.remove))),
                          Container(
                            height: 38,
                            width: 1,
                            color: Colors.black26,
                          ),
                          Container(
                              height: 38,
                              width: 38,
                              child: Center(
                                  child: Text(
                                '$quantity',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                          Container(
                              height: 38, width: 1, color: Colors.black26),
                          InkWell(
                              onTap: () {
                                setState(() => quantity++);
                              },
                              child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(9),
                                          bottomRight: Radius.circular(9)),
                                      color: Colors.green),
                                  child: Icon(Icons.add))),
                        ],
                      ))

                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         if (quantity > 1) {
                  //           setState(() => quantity--);
                  //         }
                  //       },
                  //       icon: Icon(Icons.remove_circle_outline,
                  //           color: Colors.redAccent),
                  //     ),
                  //     Text(
                  //       '$quantity',
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         setState(() => quantity++);
                  //       },
                  //       icon: Icon(Icons.add_circle_outline,
                  //           color: Colors.green),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 600, // Set the desired width
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmOrderPage(
                            product: widget.product,
                            quantity: quantity,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    label: Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

                //
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.amber,
                //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   onPressed: _addToCart, // Use the shared cart function
                //   icon: Icon(Icons.shopping_cart, color: Colors.black),
                //   label: Text(
                //     "Add to Cart",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

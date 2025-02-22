import 'package:buildingmaterialusers/productdetails.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

import 'cart_model.dart';



class LockCategoryPage extends StatefulWidget {
  final String categoryName;

  const LockCategoryPage({required this.categoryName});

  @override
  _LockCategoryPageState createState() => _LockCategoryPageState();
}

class _LockCategoryPageState extends State<LockCategoryPage> {
  List<Map<String, String>> filteredProducts = List.from(handpickedProducts);
  List<Map<String, String>> cartItems = [];
  String sortOrder = "";

  void _sortProducts(String order) {
    setState(() {
      sortOrder = order;
      filteredProducts.sort((a, b) {
        double priceA = double.parse(a['price']!.replaceAll(RegExp(r'[^\d.]'), ''));
        double priceB = double.parse(b['price']!.replaceAll(RegExp(r'[^\d.]'), ''));
        return order == "Low to High" ? priceA.compareTo(priceB) : priceB.compareTo(priceA);
      });
    });
  }

  void _toggleFavorite(Map<String, String> product) {
    setState(() {
      if (cartItems.contains(product)) {
        cartItems.remove(product);
      } else {
        cartItems.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text(
          widget.categoryName,
          style: mTextStyle16(),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text("Sort Low to High"),
                                  onTap: () {
                                    _sortProducts("Low to High");
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("Sort High to Low"),
                                  onTap: () {
                                    _sortProducts("High to Low");
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.filter_alt_outlined),
                    label: Text("Filter"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cartItems: cartItems),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text("View Cart (${cartItems.length})"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),

          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length + (filteredProducts.length ~/ 5), // Add extra count for subtitles
              itemBuilder: (context, index) {
                // Determine actual item index excluding subtitles
                int productIndex = index - (index ~/ 6);

                // Insert a subtitle after every 5 cards
                // if ((index + 1) % 6 == 0) {
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                //     child: Text(
                //       "Kitchen",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //         color: Colors.black87,
                //       ),
                //     ),
                //   );
                // }

                final product = filteredProducts[productIndex];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                            child: Image.network(
                              product['image']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          // Product Details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product['name']} (${product['brand']})",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Model: ${product['model']}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product['description']!,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),

                                  Text(
                                    product['price']!,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Favorite Icon
                          IconButton(
                            icon: Icon(
                              cartItems.contains(product)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: cartItems.contains(product) ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => _toggleFavorite(product),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Updated Sample Data with Network Images
final List<Map<String, String>> handpickedProducts = [


  {
    "name": "Godrej Padlock",
    "model": "gp001",
    "price": "₹500",
    "description": "Heavy-duty padlock offering superior security and durability.",
     "image":"https://m.media-amazon.com/images/I/91K732+-QbL._SL1500_.jpg",
    "brand": "Godrej"
  },
  {
    "name": "Harrison Padlock",
    "model": "hp001",
    "price": "₹550",
    "description": "High-security padlock designed for both outdoor and indoor use.",
      "image":"https://m.media-amazon.com/images/I/614MysqpqML._AC_UF1000,1000_QL80_.jpg",
    "brand": "Harrison"
  },
  {
    "name": "Spider Padlock",
    "model": "sp001",
    "price": "₹600",
    "description": "Durable and robust padlock designed for ultimate protection.",
"image":"https://m.media-amazon.com/images/I/71XQ84KdicL._AC_UF1000,1000_QL80_.jpg",
    "brand": "Spider"
  }
];

import 'package:buildingmaterialusers/productdetails.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

import 'cart_model.dart';



class Doorcategorypage extends StatefulWidget {
  final String categoryName;

  const Doorcategorypage({required this.categoryName});

  @override
  _DoorcategorypageState createState() => _DoorcategorypageState();
}

class _DoorcategorypageState extends State<Doorcategorypage> {
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
          style: mTextStyle20()
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
                // Check if this is a subtitle position
                if ((index + 1) % 6 == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Text(
                      "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }

                // Determine actual product index
                int productIndex = index - (index ~/ 6);

                // Safeguard against potential index out-of-bounds errors
                if (productIndex >= filteredProducts.length) return SizedBox.shrink();

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
          )

        ],
      ),
    );
  }
}

// Updated Sample Data with Network Images
final List<Map<String, String>> handpickedProducts = [

  {
    "name": "Green Plywood",
    "model": "gp001",
    "price": "₹3000",
    "description": "Durable and high-quality plywood suitable for kitchen cabinetry.",
     "image":"https://5.imimg.com/data5/PV/OR/MY-8772475/greenply-plywood-500x500.jpg",
    "brand": "Green"
  },

  {
    "name": "Century Plywood",
    "model": "cp001",
    "price": "₹3200",
    "description": "Premium plywood known for its long-lasting strength and finish.",
    "image":"https://5.imimg.com/data5/IS/KG/XJ/SELLER-60056267/centuryply-plywood.jpg",
    "brand": "Century"
  },

  {
    "name": "Kajaria Plywood",
    "model": "kp001",
    "price": "₹3100",
    "description": "High-quality plywood with moisture resistance, ideal for kitchen use.",
      "image":"https://5.imimg.com/data5/SELLER/Default/2024/5/419047719/MX/XP/CZ/2431300/kajaria-plywood-dealer-in-agra.jpeg",
    "brand": "Kajaria"
  },

  {
    "name": "Action HDMR",
    "model": "ahdmr001",
    "price": "₹3500",
    "description": "Moisture-resistant HDMR, perfect for kitchen surfaces and cabinetry.",
 "image":"https://5.imimg.com/data5/SELLER/Default/2023/5/306895312/SI/LY/NG/135377426/grey-18mm-action-tesa-hdhmr-board.jpg",
    "brand": "Action"
  },

  // {
  //   "name": "Green HDMR",
  //   "model": "ghdmr001",
  //   "price": "₹3400",
  //   "description": "Eco-friendly HDMR material with high durability and water resistance.",
  //   "image":"https://material-depot-content-files-noresize-endpoint-bsbkh4asdwecc9dp.z02.azurefd.net/CollectionImages/menu-images/shades-of-green.png?width=100",
  //   "brand": "Green"
  // },

  {
    "name": "Century HDMR",
    "model": "chdmr001",
    "price": "₹3600",
    "description": "High-density material that offers superior strength and moisture resistance.",
     "image":"https://5.imimg.com/data5/SELLER/Default/2023/9/342306547/AR/HG/VN/134362026/century-hdmr-board.jpeg",
    "brand": "Century"
  },

  {
    "name": "Godrej Basket",
    "model": "gb001",
    "price": "₹2500",
    "description": "Spacious and durable baskets designed for kitchen storage solutions.",
    "image": "https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889",
    "brand": "Godrej"
  },

  {
    "name": "Hettich Basket",
    "model": "hb001",
    "price": "₹2700",
    "description": "Elegant and functional baskets for organized kitchen storage.",
     "image":"https://5.imimg.com/data5/SELLER/Default/2023/1/HO/JI/WH/30867519/hettich-modular-kitchen-baskets-15x20x4-plain.jpeg",
    "brand": "Hettich"
  },
  {
    "name": "Godrej Channel",
    "model": "gc001",
    "price": "₹600",
    "description": "Strong and durable channels for smooth sliding doors and cabinets.",
    "image":"https://i0.wp.com/bhoomihardware.com/wp-content/uploads/2023/05/IMG_20230503_191232.jpg",
    "brand": "Godrej"
  },

  {
    "name": "Hettich Channel",
    "model": "hc001",
    "price": "₹650",
    "description": "Premium channels for reliable, quiet, and smooth sliding.",
    "image":"https://m.media-amazon.com/images/I/51v3Tef6nvL.jpg",
    "brand": "Hettich"
  }
  ];

  // {
  //   "name": "Sterling Basket",
  //   "model": "sb001",
  //   "price": "₹2600",
  //   "description": "High-quality baskets offering great storage options for kitchens.",
  //   "image":"https://www.google.com/imgres?q=Sterling%20Basket%20model%20sb001&imgurl=https%3A%2F%2F5.imimg.com%2Fdata5%2FXB%2FJX%2FGI%2FSELLER-2183661%2Fwooden-wicker-basket.jpg&imgrefurl=https%3A%2F%2Fwww.indiamart.com%2Fproddetail%2Fsterling-wicker-basket-20124945648.html&docid=MSwcZ9EHgV98EM&tbnid=GosS6aQscDHdfM&vet=12ahUKEwin4Jbx7LCKAxWIU2wGHa1MOKUQM3oECBgQAA..i&w=944&h=944&hcb=2&ved=2ahUKEwin4Jbx7LCKAxWIU2wGHa1MOKUQM3oECBgQAA",
  //   "brand": "Sterling"
  // },

  // {
  //   "name": "Sterling Channel",
  //   "model": "sc001",
  //   "price": "₹630",
  //   "description": "Durable channels designed for kitchen cabinets with smooth functionality.",
  //   "image": "https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889",
  //   "brand": "Sterling"
  // },
  // {
  //   "name": "Godrej Hinges",
  //   "model": "gh001",
  //   "price": "₹150",
  //   "description": "Heavy-duty hinges designed for high performance and durability.",
  //   "image": "https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889",
  //   "brand": "Godrej"
  // },
  // {
  //   "name": "Hettich Hinges",
  //   "model": "hh001",
  //   "price": "₹180",
  //   "description": "High-quality hinges offering smooth and noiseless operation.",
  //   "image": "https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889",
  //   "brand": "Hettich"
  // },
  // {
  //   "name": "Sterling Hinges",
  //   "model": "sh001",
  //   "price": "₹170",
  //   "description": "Reliable hinges offering strength and easy installation for kitchen cabinets.",
  //   "image": "https://www.iforinterior.in/cdn/shop/files/Green_MR_fa3c196a-411a-484b-b31c-d9674a0d4e15.jpg?v=1720530889",
  //   "brand": "Sterling"
  // },

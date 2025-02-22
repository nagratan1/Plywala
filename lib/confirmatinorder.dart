

import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'sucesspage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class ConfirmOrderPage extends StatefulWidget {
  final Map<String, String> product;
  final int quantity;

  ConfirmOrderPage({required this.product, required this.quantity});

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  double discount = 25.0; // Discount applied for the coupon
  bool isCouponApplied = false; // Coupon state
  String selectedDeliveryType = "Standard"; // Default delivery type
  String currentAddress = "Fetching location...";
  String manualAddress = ""; // For manual address input

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch current location on page load
  }


  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        currentAddress = "Location services are disabled. Please enable them.";
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          currentAddress =
          "Location permissions are permanently denied. Enable them in settings.";
        });
        return;
      }
      if (permission == LocationPermission.denied) {
        setState(() {
          currentAddress = "Location permissions are denied.";
        });
        return;
      }
    }

    // Fetch the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get address
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        currentAddress = "Failed to fetch address: $e";
      });
    }
  }



  void _showOrderProcessingPopup() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog manually
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Processing your order...",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );

    // Simulate a 10-second delay before navigating to the success page
    await Future.delayed(Duration(seconds: 10));

    Navigator.pop(context); // Close the dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.product['price']!
        .replaceAll(RegExp(r'[^0-9.]'), ''));
    double total = price * widget.quantity;
    double discountedTotal = isCouponApplied ? total - discount : total;

    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Confirm Order',
          style: mTextStyle16(),
        ),
        backgroundColor: Colors.amber

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Information Section
              Text(
                "Product Details",
                style: mTextStyle20(),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                        Image.asset(
                          widget.product['image']!,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50, color: Colors.grey);
                          },
                        )

                      ),
                      SizedBox(width: 16),
                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Quantity: ${widget.quantity}",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Total: ₹${total.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Address Selection Section
              Text(
                "Delivery Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.my_location, color: Colors.redAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              currentAddress,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: _getCurrentLocation,
                            child: Text("Current Location", style: mTextStyle12()),
                          ),
                        ],
                      ),
                      Divider(),
                      TextFormField(
                        initialValue: manualAddress.isEmpty ? currentAddress : manualAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter address manually',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            manualAddress = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20),

              // Payment Gateway Icons
              Text(
                "Payment Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Scan and Pay'),
                          Icon(Icons.qr_code, size: 50, color: Colors.blue),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Cash on delivery'),
                          Icon(Icons.currency_rupee, size: 50, color: Colors.red),

                        ],
                      )
                      // Icon(Icons.account_balance_wallet,
                      //     size: 50, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Final Amount Section
              Text(
                "Savings Corner",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  leading: Icon(
                    isCouponApplied ? Icons.check_circle : Icons.local_offer,
                    color: isCouponApplied ? Colors.green : Colors.orange,
                  ),
                  title: Text(
                    isCouponApplied
                        ? "Discount Applied"
                        : "Apply Discount Code",
                  ),
                  subtitle: Text(
                    isCouponApplied
                        ? "You saved ₹$discount!"
                        : "Use code to save ₹$discount",
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.green

                    ),
                    onPressed: () {
                      setState(() {
                        isCouponApplied = !isCouponApplied;
                      });
                    },
                    child: Text(
                      isCouponApplied ? "Remove" : "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Final Amount Section
              Text(
                "Final Amount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Original Price: ₹${total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (isCouponApplied)
                        Text(
                          "Discount: -₹${discount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      Divider(),
                      Text(
                        "Payable Amount: ₹${discountedTotal.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Confirm Order Button
              Center(
                child: SizedBox(
                  width: 600,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                  
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  
                    onPressed: _showOrderProcessingPopup,
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

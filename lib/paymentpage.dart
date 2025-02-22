
import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'welcompage.dart';

class PaymentSettingsPage extends StatefulWidget {
  @override
  State<PaymentSettingsPage> createState() => _PaymentSettingsPageState();
}

class _PaymentSettingsPageState extends State<PaymentSettingsPage> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();

    // Setting up Razorpay event listeners
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    razorpay.clear(); // Cleanup the Razorpay instance to avoid memory leaks
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_Q2EaBgbw3u8R12',
      'amount': 1 * 1, // Amount in smallest currency unit (100 = ₹1.00)
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata: ${response.error.toString()}",
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    debugPrint("Payment successful. Payment ID: ${response.paymentId}");
    // Navigate to the Welcome page directly without showing a dialog
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => Welcome()),
    // );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "Wallet: ${response.walletName}",
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
       
      },
    );

   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('Payment Settings',style: mTextStyle20())),
        backgroundColor: Colors.amber
      ),
      body: 
      ListView(
        padding: EdgeInsets.all(16),
        children: [
      //     ListTile(
      //       leading: Icon(Icons.credit_card, color: Colors.green),
      //       title: Text("Add New Card"),
      //       trailing: Icon(Icons.add),
      //       onTap: () {
      //         // Add new card logic
      //       },
      //     ),
      //     Divider(),
      //     ListTile(
      //       leading: Icon(Icons.paypal, color: Colors.green),
      //       title: Text("PayPal"),
      //       trailing: Icon(Icons.arrow_forward_ios),
      //       onTap: () {
             
      //       },
      //     ),
      //      Divider(),
          ListTile(
            leading: Icon(Icons.paypal, color: Colors.green),
            title: Text("Pay  Razorpay"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
             openCheckout();
            },
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.account_balance_wallet, color: Colors.green),
          //   title: Text("Wallet"),
          //   trailing: Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Manage Wallet logic
          //   },
          // ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class OrderDetailsPage extends StatefulWidget {
//   final String address;
//
//   OrderDetailsPage({required this.address});
//
//   @override
//   _OrderDetailsPageState createState() => _OrderDetailsPageState();
// }
//
// class _OrderDetailsPageState extends State<OrderDetailsPage> {
//   Duration deliveryTimeLeft = Duration(hours: 3, minutes: 30); // Example time
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (deliveryTimeLeft > Duration.zero) {
//           deliveryTimeLeft -= Duration(seconds: 1);
//         } else {
//           timer.cancel();
//         }
//       });
//     });
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String hours = twoDigits(duration.inHours);
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$hours:$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Center(
//           child: Text(
//             "Order Details",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Order Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text("Address: ${widget.address}", style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             Text(
//               "Estimated Delivery Time:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               deliveryTimeLeft > Duration.zero
//                   ? "Time Left: ${_formatDuration(deliveryTimeLeft)}"
//                   : "Your order has been delivered!",
//               style: TextStyle(fontSize: 16, color: deliveryTimeLeft > Duration.zero ? Colors.black : Colors.green),
//             ),
//             SizedBox(height: 16),
//             Divider(),
//             SizedBox(height: 16),
//             Text(
//               "Delivery Status",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 _buildStatusIcon(isCompleted: true),
//                 _buildStatusLine(),
//                 _buildStatusIcon(isCompleted: deliveryTimeLeft.inHours <= 2),
//                 _buildStatusLine(),
//                 _buildStatusIcon(isCompleted: deliveryTimeLeft <= Duration.zero),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Order Placed", style: TextStyle(fontSize: 14)),
//                 Text("Out for Delivery", style: TextStyle(fontSize: 14)),
//                 Text("Delivered", style: TextStyle(fontSize: 14)),
//               ],
//             ),
//             Spacer(),
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
//                 onPressed: () {
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                 },
//                 child: Text(
//                   'Return to Dashboard',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusIcon({required bool isCompleted}) {
//     return CircleAvatar(
//       radius: 20,
//       backgroundColor: isCompleted ? Colors.green : Colors.grey[300],
//       child: Icon(Icons.check, color: isCompleted ? Colors.white : Colors.grey),
//     );
//   }
//
//   Widget _buildStatusLine() {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: Colors.grey[300],
//         margin: EdgeInsets.symmetric(horizontal: 4),
//       ),
//     );
//   }
// }

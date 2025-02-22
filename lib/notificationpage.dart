import 'package:buildingmaterialusers/welcompage.dart';
import 'package:flutter/material.dart';




class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "Order Update",
      "body": "Your order #001 has been shipped.",
      "timestamp": "10:00 AM"
    },
    {
      "title": "Payment Received",
      "body": "Payment of \$150 has been received.",
      "timestamp": "9:30 AM"
    },
    {
      "title": "New Order",
      "body": "You have received a new order #002.",
      "timestamp": "8:45 AM"
    },
    {
      "title": "System Alert",
      "body": "Scheduled maintenance at midnight.",
      "timestamp": "7:00 AM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Center(child: Text('Notifications',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep,color: Colors.white,),
            onPressed: () {
              // Handle clearing all notifications
              print("Clear All Notifications");
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text(
                notification['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['body']!),
              trailing: Text(
                notification['timestamp']!,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Handle notification tap
                print("Tapped on: ${notification['title']}");
              },
            ),
          );
        },
      ),
    );
  }
}

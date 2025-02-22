import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'welcompage.dart';

class ReportSafetyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/welcomepage');
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('Report & Safety',style: mTextStyle20())),
        backgroundColor: Colors.amber
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.report, color: Colors.red),
            title: Text("Report an Issue"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to report issue form
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security, color: Colors.green),
            title: Text("Safety Guidelines"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to safety guidelines page
            },
          ),
        ],
      ),
    );
  }
}

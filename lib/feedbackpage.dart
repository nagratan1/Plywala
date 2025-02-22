import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'welcompage.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/welcomepage');
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('Feedback',style: mTextStyle20())),
        backgroundColor:  Colors.amber
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Write your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit feedback logic
              },
              child: Text("Submit Feedback",style: mTextStylewhite16(),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

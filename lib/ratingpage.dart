import 'package:buildingmaterialusers/editprofilepages.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'welcompage.dart';

class RatingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/welcomepage');
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('Ratings',style: mTextStyle20(),)),
        backgroundColor: Colors.amber
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rate Your Experience", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(Icons.star_border, size: 30, color: Colors.green),
                  onPressed: () {
                    // Handle rating logic
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

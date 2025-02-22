import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

import 'welcompage.dart';

class DeleteAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('Delete Account',style: mTextStyle20())),
        backgroundColor:  Colors.amber
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Delete Account"),
                content: Text(
                    "Are you sure you want to delete your account? This action cannot be undone."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
          child: Text("Delete My Account",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

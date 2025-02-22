import 'package:buildingmaterialusers/login%20page.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/welcomepage');
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Center(child: Text('Edit Profile',style: mTextStyle20(),)),
        backgroundColor: Colors.amber
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLength: 10,
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Welcome()));
                // Navigator.pop(context);
              },
              child: Text("Save Changes",style: TextStyle(color: Colors.black),

              )
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';

import 'welcompage.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // flexibleSpace: Container(
        // decoration: const BoxDecoration(
        // gradient: LinearGradient(
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        // colors: <Color>[
        //   Color.fromRGBO(62, 41, 29,2),   Color.fromRGBO(62, 41, 29,2),]))),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
        }, icon: Icon(Icons.arrow_back,color: Colors.black)),
        title: Center(child: Text('About',style: mTextStyle20(),)),
        backgroundColor: Colors.amber),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "This app is designed to provide the best shopping experience. "
              "You can explore, shop, and manage your orders easily.\n\n"
              "Version: 1.0.0\nDeveloper: YourCompany",
          style: mTextStyle16(),
        ),
      ),
    );
  }
}

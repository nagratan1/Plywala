import 'package:buildingmaterialusers/login%20page.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}


class _OnboardingState extends State<Onboarding> {
  final List<String> urlImages = [
    'https://alferozqatar.com/wp-content/uploads/2016/02/building-materials2.png',
    'https://tiimg.tistatic.com/fp/1/006/448/fine-finished-waterproof-plywood-792.jpg',
    'https://images.jdmagicbox.com/quickquotes/images_main/veneer-plywood-sheet-2013780481-b2ri2165.jpg'
  ];

  final List<String> descriptions = [
    'Find high-quality building materials at one place.',
    'Explore reliable construction services and products.',
    'Get your materials delivered with ease and speed.',
  ];

  int _currentIndex = 0; // Tracks the current slide

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.amberAccent
              // Color.fromRGBO(128, 68, 68,1),
              // Color.fromRGBO(202, 52, 0,1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Carousel Slider
            CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return buildImage(urlImages[index]);
              },
            ),
            SizedBox(height: 30),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: urlImages.asMap().entries.map((entry) {
                return Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green
                    ),
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.white
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),

            // Text Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                descriptions[_currentIndex],
                textAlign: TextAlign.center,
                style: mTextStyle16()
              ),
            ),
            SizedBox(height: 30),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () {
                      context.go('/loginpage');
                    },
                    child: Text(
                      'Skip',
                      style: mTextStyle16()
                    ),
                  ),

                  // Next/Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < urlImages.length - 1) {
                        setState(() {
                          _currentIndex++;
                        });
                      } else {
                        context.go('/loginpage');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      _currentIndex < urlImages.length - 1
                          ? 'Next'
                          : 'Get Started',
                      style: mTextStyle16()
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(urlImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

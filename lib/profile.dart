import 'package:buildingmaterialusers/paymentpage.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //           flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: <Color>[
          //         Color.fromRGBO(252, 150, 5, 1),
          //         Color.fromRGBO(230, 115, 71, 1),
          //
          //       ]),
          //   ),
          // ),
          centerTitle: true,
          title: Text(
            'Profile',
            style: mTextStyle24(),
          ),
          backgroundColor: Colors.amber),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(16.0),
              //           decoration: BoxDecoration(
              //              gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: <Color>[
              //  Color.fromRGBO(222, 105, 95, 1),
              //           Color.fromRGBO(230, 115, 71, 1),

              //       ]),
              //           ),
              child: Column(
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage('assets/man.jpg'),
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                    radius: 90,
                    // child: Icon(
                    //   Icons.person,
                    //   size: 80,
                    //    color:     Color.fromRGBO(222, 105, 95, 1),
                    // ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("MARV", style: mTextStyle20()),
                      SizedBox(height: 5),
                      Text("1234567890", style: mTextStyle20()),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Promotion Banner or Placeholder
            // PromotionBanner(),

            // Profile Menu Options
            _buildMenuOption(
              title: 'Edit Profile',
              icon: Icons.arrow_forward_ios_rounded,
              onPressed: () {
                context.go('/editpages');
              },
            ),
            _buildMenuOption(
              title: 'Rating',
              icon: Icons.star_rate_outlined,
              onPressed: () {
                context.go('/ratingpage');
              },
            ),
            _buildMenuOption(
              title: 'Payment Setting',
              icon: Icons.payment,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentSettingsPage()),
                );
                //context.go('/paymentsetting');
              },
            ),
            _buildMenuOption(
              title: 'About',
              icon: Icons.local_activity,
              onPressed: () {
                context.go('/aboutpage');
              },
            ),
            _buildMenuOption(
              title: 'Report & Safety',
              icon: Icons.report,
              onPressed: () {
                context.go('/reportsafetypage');
              },
            ),
            _buildMenuOption(
              title: 'FeedBack',
              icon: Icons.feedback,
              onPressed: () {
                context.go('/feedbackpage');
              },
            ),
            _buildMenuOption(
              title: 'Delete Account',
              icon: Icons.delete,
              onPressed: () {
                context.go('/deletepage');
                // var snackBar = SnackBar(
                //   content: Text("Your Account is deleted Sucessfully"),
                //   backgroundColor: Colors.green,
                // );
                // ScaffoldMessenger.of(context).showSnackBar((snackBar));
              },
            ),

            SizedBox(height: 30),

            // Logout Button
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.go('/loginpage');
                  },
                  child: Text(
                    "Logout",
                    style: mTextStyle16(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Menu Options
  Widget _buildMenuOption({
    required String title,
    required IconData icon,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            title,
            style: mTextStyle16(),
          ),
          trailing: Icon(
            icon,
            color: Colors.black,
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}

// Dummy PromotionBanner Widget
class PromotionBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://www.healthyfood.com/wp-content/uploads/2017/03/Ask-the-experts-Raw-chicken-500x376.jpg',
      'https://media.self.com/photos/62cd9c3069671d734f919d0f/4:3/w_960,c_limit/should-you-wash-chicken.jpg',
      'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=360/app/images/products/sliding_image/474769a.jpg?ts=1701200355'
    ];
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
      items: imageList.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

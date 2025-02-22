import 'package:buildingmaterialusers/Deleteaccountpages.dart';
import 'package:buildingmaterialusers/aboutpage.dart';
import 'package:buildingmaterialusers/editprofilepages.dart';
import 'package:buildingmaterialusers/feedbackpage.dart';
import 'package:buildingmaterialusers/login%20page.dart';
import 'package:buildingmaterialusers/onboarding.dart';
import 'package:buildingmaterialusers/otp.dart';
import 'package:buildingmaterialusers/paymentpage.dart';
import 'package:buildingmaterialusers/ratingpage.dart';
import 'package:buildingmaterialusers/report&safety.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:go_router/go_router.dart';
import 'package:buildingmaterialusers/SplashScree.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/', //splash screen
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      path: '/onboardingpage', 
      builder: (context, state) => const Onboarding()),
       GoRoute(
      path: '/loginpage', 
      builder: (context, state) => const LoginPage()),
         GoRoute(
      path: '/otppage', 
      builder: (context, state) => const MyOtpPage()),
         GoRoute(
      path: '/welcomepage', 
      builder: (context, state) =>  Welcome()),
  GoRoute(
      path: '/editpages',
      builder: (context, state) =>  EditProfilePage()),
  GoRoute(
      path: '/ratingpage',
      builder: (context, state) => RatingsPage()),
  GoRoute(
      path: '/paymentsetting',
      builder: (context, state) => PaymentSettingsPage()),
  GoRoute(
      path: '/aboutpage',
      builder: (context, state) => AboutPage()),
  GoRoute(
      path: '/reportsafetypage',
      builder: (context, state) => ReportSafetyPage()),
  GoRoute(
      path: '/feedbackpage',
      builder: (context, state) =>  FeedbackPage()),
  GoRoute(
      path: '/deletepage',
      builder: (context, state) => DeleteAccountPage()),

]);

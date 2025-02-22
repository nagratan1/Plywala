import 'package:buildingmaterialusers/text.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:buildingmaterialusers/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';


class MyOtpPage extends StatefulWidget {
  const MyOtpPage({Key? key, this.phone}) : super(key: key);
  final String? phone;

  @override
  State<MyOtpPage> createState() => _MyOtpPageState();
}

class _MyOtpPageState extends State<MyOtpPage> {
  String otp = "1111";
  // late Future<Album> futureAlbum;/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   icon: const Padding(
      //   //     padding: EdgeInsets.only(left: 20),
      //   //     child: Icon(
      //   //       Icons.arrow_back,
      //   //       color: Colors.black,
      //   //     ),
      //   //   ),
      //   // ),
      // ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    'OTP Verification',
                    style: mTextStyle24()
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Enter the verification code we just sent on your mobile number',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'please enter OTP sent to',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        Text(
                          '  +91 ${widget.phone}',
                          style: TextStyle(color: Color.fromRGBO(62, 41, 29,2),),
                        ),
                        IconButton(
                            onPressed: () {
                              context.go('/loginpage');
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    defaultPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12))),
                    focusedPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12))),
                    submittedPinTheme: PinTheme(
                        textStyle: (const TextStyle(fontSize: 28)),
                        constraints: const BoxConstraints(
                          minWidth: 64,
                          minHeight: 64,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12))),
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      // logPrint.w('verify button pressed');
                      otp = pin;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TimerWidget(
                    onClick: (val) {},
                  ),
                  const SizedBox(
                    height: 144,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/welcomepage');
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()));
                   Future.delayed(const Duration(seconds: 2));
                        // logPrint.w('verify button pressed');
                        if ( otp == '1111') {
                           Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));
                         Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));
                         Future.delayed(
                              const Duration(seconds: 0),
                              () => context.go("/welcomepage")
                                  // Navigator.pushReplacement(
                                  // context,
                                  // MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //       Welcome(),
                                  // ))
                         );
                        } else {
                           Future.delayed(const Duration(seconds: 0),
                              () => Navigator.pop(context));
                        Fluttertoast.showToast(
                          msg: "Wrong Otp",
                          backgroundColor: Colors.grey[100],
                          textColor: Colors.red[800],
                        );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:  Colors.amber,
                          // Color.fromRGBO(222, 105, 95, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),

                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


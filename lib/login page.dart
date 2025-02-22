// ignore_for_file: use_build_context_synchronously

import 'package:buildingmaterialusers/otp.dart';
import 'package:buildingmaterialusers/text.dart';
import 'package:buildingmaterialusers/welcompage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 120,
                      // backgroundImage: AssetImage('assets/warsilogo.png'),
                      child: Image.asset('assets/homedepo.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    width: 0.65 * size.width,
                    child: FittedBox(
                      child: Text(
                        'LOGIN TO CONTINUE',
                        style: mTextStyle20()                       ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'please enter your mobile number to get OTP verify account',
                    style: mTextStyle12().copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      // textAlign: TextAlign.center,
                      controller: _phone,
                      decoration: InputDecoration(
                        isDense: true,
                        // suffixIcon: Icon(
                        //   Icons.call,
                        //   color: Colors.redAccent,
                        // ),
                        prefixIcon: Text(
                          "+91",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                            // Color.fromRGBO(222, 105, 95, 1),
                          ),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 40, minHeight: 0),
                        border: InputBorder.none,
                        hintText: "mobile no",
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      validator: (value) {
                        if (value!.isEmpty || value.length > 9) {
                          return 'Enter Number only';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate mobile number
                        if (_phone.text.length != 10 || !RegExp(r'^\d+$').hasMatch(_phone.text)) {
                          Fluttertoast.showToast(
                            msg: "Mobile number must be exactly 10 digits",
                            backgroundColor: Colors.grey[100],
                            textColor: Color.fromRGBO(222, 105, 95, 1),
                          );
                          return; // Stop further execution if validation fails
                        }

                        // Save the phone number in SharedPreferences
                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('_phone', _phone.text);

                        // Navigate to OTP Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyOtpPage(phone: _phone.text),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'SEND OTP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

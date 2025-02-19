import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:jewelbook_calculator/ui/dashboard/dashboard.dart';
// import 'package:jewelbook_calculator/ui/otp_screen/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F172A),
                  Color(0xFF000000),
                ], // Dark blue to black
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); // Close the keyboard
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo with Glow Effect
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // OTP Instruction Text
                  const Text(
                    'We have sent a verification code to your mobile number.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 40,
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.amber),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).nextFocus();
                            }
                            if (index == 5) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Resend OTP
                  GestureDetector(
                    onTap: () {
                      // Resend OTP function
                    },
                    child: const Text(
                      "Didn't get the OTP? Resend OTP",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Verify OTP Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Center(
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

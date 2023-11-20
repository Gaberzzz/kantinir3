import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kantinir_mobile_app/screens/onboarding/onboarding2.dart';
import 'package:kantinir_mobile_app/screens/theme.dart';
import 'package:provider/provider.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding2()),
            );
          },
          child: Center(
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'KAN',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  TextSpan(
                    text: 'TINIR',
                    style: TextStyle(
                        color: Color(0xFF59CCB5),
                        fontSize: 64,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

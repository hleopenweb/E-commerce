import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/colors.dart';

class DefaultLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/cart_arrow_down.png',
                height: 50,
              ),
            ),
            Text(
              'Spider Shop',
              style: GoogleFonts.beVietnam(
                textStyle: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

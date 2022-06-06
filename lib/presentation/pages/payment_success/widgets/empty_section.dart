import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptySection extends StatelessWidget {
  final String emptyImg, emptyMsg;

  const EmptySection({
    Key? key,
    required this.emptyImg,
    required this.emptyMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              emptyMsg,
              style: GoogleFonts.beVietnam(
                fontSize: 20.0,
                color: Color(0xFF303030),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
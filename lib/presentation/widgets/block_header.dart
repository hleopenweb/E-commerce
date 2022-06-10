import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockHeader extends StatelessWidget {
  final double? width;
  final String? title;
  final String? linkText;
  final VoidCallback? onLinkTap;
  const BlockHeader({this.width, this.title, this.linkText, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(
            title!,
            style:
                GoogleFonts.beVietnam(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
          ),
          Spacer(),
          InkWell(
              onTap: onLinkTap,
              child: Text(
                linkText!,
                style: GoogleFonts.beVietnam(
                    textStyle: TextStyle(color: Colors.green)),
              ))
        ],
      ),
    );
  }
}

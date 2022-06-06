import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemCart extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onpressed;

  const ListItemCart({this.icon, this.title, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        elevation: 3,
        child: TextButton(
          onPressed: onpressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: Color(0xFFFF7643),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      title!,
                      style: GoogleFonts.beVietnam(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

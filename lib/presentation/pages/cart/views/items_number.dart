import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemNuber extends StatelessWidget {
  final int? itemNumber;

  ItemNuber({this.itemNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Giỏ hàng của bạn',
          style:
              GoogleFonts.beVietnam(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$itemNumber sản phẩm',
              style: GoogleFonts.beVietnam(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    );
  }
}

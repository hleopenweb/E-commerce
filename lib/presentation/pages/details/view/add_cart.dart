import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/product.dart';

class AddToCard extends StatefulWidget {
  final VoidCallback? onChanged;

  AddToCard(
      {this.onChanged,
      this.product,
      required this.onClick,
      required this.imageLink});

  final Content? product;
  final void Function(GlobalKey) onClick;
  final String imageLink;

  @override
  State<AddToCard> createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  final GlobalKey imageGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: widget.onChanged,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Mua',
                      style: GoogleFonts.beVietnam(
                        textStyle: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                widget.onClick(imageGlobalKey);
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Center(
                      child: Text(
                        'Thêm vào giỏ hàng',
                        style: GoogleFonts.beVietnam(
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Opacity(
                      opacity: 0,
                      child: Container(
                        key: imageGlobalKey,
                        child: Image.memory(
                          base64.decode(widget.imageLink),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

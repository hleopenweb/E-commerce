import 'package:flutter/material.dart';
import 'package:sajilo_dokan/config/colors.dart';

class AddQuantity extends StatefulWidget {
  // add quantity of product to cart
  final VoidCallback? addButton;

  // subtract quantity of product to cart
  final VoidCallback? subtractButton;
  final int noOfItem;

  AddQuantity({this.addButton, this.subtractButton, required this.noOfItem});

  @override
  State<AddQuantity> createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: widget.subtractButton,
          child: Container(
            height: 20,
            width: 20,
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Text('-',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(widget.noOfItem > 0 ? widget.noOfItem.toString() : '0',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            )),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: widget.addButton,
          child: Container(
            height: 20,
            width: 20,
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

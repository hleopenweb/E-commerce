import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/category.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';

class CategoriesTile extends StatelessWidget {
  const CategoriesTile({this.onChanged, required this.category});

  final VoidCallback? onChanged;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onChanged,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Image.memory(
                        base64.decode(category.thumbnail!),
                        errorBuilder: (_, __, ___) {
                          return LoadingWidget();
                        },
                        width: 90,
                        fit: BoxFit.fill,
                      ),
                    )),
                SizedBox(height: 8),
                Text(
                  category.name!,
                  maxLines: 2,
                  style: GoogleFonts.beVietnam()
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

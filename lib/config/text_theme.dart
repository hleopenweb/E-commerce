import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';


const kFontWeightNormal = FontWeight.w300;
const kFontWeightBold = FontWeight.w600;

final kDefaultTextStyle = TextStyle(
  fontSize: 20,
  color: kOnSecondaryColor,
  fontWeight: kFontWeightBold,
);

final kDefaultInput =  GoogleFonts.beVietnam().copyWith(
  fontSize: 18,
);

final kDefaultTitleAppBarStyle = TextStyle(
  fontSize: 20,

  color: kOnPrimaryColor,
  fontWeight: kFontWeightBold,
);

final defaultTextTheme = TextTheme(
  headline6: kDefaultTextStyle,
  headline5: kDefaultTextStyle.copyWith(
    fontSize: 16.2,
    fontWeight: kFontWeightBold,
  ),
  bodyText2: kDefaultTextStyle.copyWith(
    fontSize: 12.6,
  ),
  subtitle2: kDefaultTextStyle.copyWith(
    fontSize: 9,
  ),
  bodyText1: kDefaultTextStyle.copyWith(
    fontSize: 14,
  ),
  subtitle1: kDefaultTextStyle.copyWith(
    fontSize: 14,
    fontWeight: kFontWeightBold,
  ),
  button: kDefaultTextStyle.copyWith(
    fontSize: 16.0,
    color: kOnPrimaryColor,
    fontWeight: kFontWeightBold,
  ),
);



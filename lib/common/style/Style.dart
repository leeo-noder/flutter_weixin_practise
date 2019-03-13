import 'package:flutter/material.dart';

class Style {
  static const int primaryValue = 0xffEDEDED;
  static const int primaryLightValue = 0xFFFFFFFF;
  static const int primaryDarkValue = 0xFF121917;
  static const MaterialColor primarySwatchDefault = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
  static const MaterialColor primarySwatch = const MaterialColor(
    primaryLightValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

class ICons {
  static const String FONT_FAMILY = 'wxIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const IconData XIANSHIQI = const IconData(
      0xe61d, fontFamily: ICons.FONT_FAMILY);

  static const IconData QR = const IconData(
      0xe646, fontFamily: ICons.FONT_FAMILY);

  static const IconData HOME = const IconData(
      0xe65d, fontFamily: ICons.FONT_FAMILY);
  static const IconData HOME_CHECKED = const IconData(
      0xe619, fontFamily: ICons.FONT_FAMILY);

  static const IconData ADDRESS_BOOK = const IconData(
      0xe711, fontFamily: ICons.FONT_FAMILY);
  static const IconData ADDRESS_BOOK_CHECKED = const IconData(
      0xe687, fontFamily: ICons.FONT_FAMILY);

  static const IconData FOUND = const IconData(
      0xe60f, fontFamily: ICons.FONT_FAMILY);
  static const IconData FOUND_CHECKED = const IconData(
      0xe746, fontFamily: ICons.FONT_FAMILY);

  static const IconData WO = const IconData(
      0xe626, fontFamily: ICons.FONT_FAMILY);
  static const IconData WO_CHECKED = const IconData(
      0xe627, fontFamily: ICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}

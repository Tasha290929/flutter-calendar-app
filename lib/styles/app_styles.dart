import 'package:flutter/material.dart';

// Цвета
class AppColors {
  static const violet = Color(0xFF777ED3);
  static const dullLavender = Color(0xFF9AA9E0);
  static const error = Color(0xFFB3261E);
  static const background = Color(0xFFD8D7DB);
  static const black = Color(0xFF242323);
  static const white = Color(0xFFFFFFFF);
  static const greyLavender = Color(0xFFCBCFD9);
  static const lightGreyLavender = Color(0xFFC1C4DB);
}

// Шрифты / текст
class AppTextStyles {
  static const headingScreen = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 36 / 28,
  );

  static const headingSection = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 28 / 22,
  );

  static const headingCards = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
  );

  // Base text
  static const basicText = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
  );

  static const bodyRegular = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
  );

///////

  static const secondaryText = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
  );

  static const smallText = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
  );

  static const primaryButton = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  static const secondaryButton = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
  );

  static const cips = TextStyle(
    fontFamily: 'Geist',
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
  );

}
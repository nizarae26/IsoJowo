import 'package:flutter/material.dart';

class JowoColors {
  static const Color navyBg = Color(0xFF102C44); // Biru gelap latar belakang
  static const Color goldAccent = Color(0xFFC6934B); // Emas untuk tombol
  static const Color lightGrey = Color(0xFFF6D1A5); // Emas untuk tombol
  static const Color creamCard = Color(0xFFF6EBD7); // Krem untuk menu kotak
  static const Color whiteText = Colors.white;
  static const Color greyText = Color(0xFFBDBDBD);
  static const Color transparent = Color.fromARGB(0, 0, 0, 0);

  static Gradient get jowoGradient {
    return const LinearGradient(
      colors: [whiteText, lightGrey],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

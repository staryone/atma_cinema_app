import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/get.dart';

const String baseUrl =
    "https://lightslategray-dinosaur-894765.hostingersite.com/api";
// const String baseUrl = "http://172.21.64.1:8000/api";
const Color colorPrimary = Color(0xFF001F3F);
const Color colorBorder = Color(0xFFD9D9D9);
const Color colorGold = Color(0xFFEAD8B1);

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xff264968), Color(0xff4B91CE)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final homeSymbol = SymbolsGet.get('home_rounded', SymbolStyle.rounded);

TextStyle styleNormal = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
);

TextStyle styleMedium = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
);

TextStyle styleMedium2 = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
);

TextStyle styleBold = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);
TextStyle styleBold2 = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xff264968),
  ),
);
TextStyle styleBold3 = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xff4B91CE),
  ),
);

TextStyle styleBold4 = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
);
TextStyle styleHeader = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    foreground: Paint()..shader = linearGradient,
  ),
);
TextStyle styleHeade2 = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    foreground: Paint()..shader = linearGradient,
  ),
);

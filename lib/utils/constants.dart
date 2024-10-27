import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/get.dart';

const Color colorPrimary = Color(0xFF001F3F);
const Color colorBorder = Color(0xFFD9D9D9);

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
    color: colorPrimary,
  ),
);
TextStyle styleHeader = GoogleFonts.roboto(
  textStyle: const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: colorPrimary,
  ),
);

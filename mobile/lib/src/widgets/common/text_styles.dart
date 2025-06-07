import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get headerStyle => GoogleFonts.inter(
  fontWeight: FontWeight.w600,
  fontSize: 20,
  height: 1.2,
  color: const Color(0xFF040D29),
);

TextStyle get hintTextStyle => GoogleFonts.inter(
  fontWeight: FontWeight.w500,
  color: const Color(0xFF72798F),
  fontSize: 12,
);

TextStyle get subtitleTextStyle => GoogleFonts.inter(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: const Color(0xFF72798F),
);

TextStyle buttonTextStyle(Color color) =>
    GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16, color: color);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextCustom extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  const TextCustom({required this.text,this.fontWeight,this.fontSize,this.color,this.maxLines,this.overflow,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.habibi(
      color: color,
      fontSize: fontSize,
    ),
    maxLines:maxLines ,
    overflow:overflow,
    );
  }
}
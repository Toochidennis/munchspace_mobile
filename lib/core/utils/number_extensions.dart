import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension NumberFormatting on num {
  static const String nairaSymbol = '₦';

  /// Formats a number as Nigerian Naira currency without kobo (decimal places)
  /// Example: 2500 -> "₦2,500"
  String toCurrency() {
    final formatter = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final parts = toStringAsFixed(0).split('.');
    final integerPart = parts[0].replaceAll(formatter, ',');
    return '${NumberFormatting.nairaSymbol}$integerPart';
  }
}

extension CurrencyTextStyle on TextStyle {
  /// Returns a TextStyle with the Inter font family for proper currency symbol rendering
  TextStyle get withCurrencyFont {
    return copyWith(fontFamily: GoogleFonts.inter().fontFamily);
  }
}

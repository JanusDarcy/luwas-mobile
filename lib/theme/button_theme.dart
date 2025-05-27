import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class BtnTheme {
  static ButtonStyle primaryBtn({
    required EdgeInsets padding,
    required Color backgroundColor,
    required double borderRadius,
  }) {
    return TextButton.styleFrom(
      padding: padding,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}


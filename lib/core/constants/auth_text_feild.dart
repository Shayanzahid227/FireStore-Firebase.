import 'package:code_structure/core/constants/colors.dart';
import 'package:code_structure/core/constants/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_style.dart';

final authFieldDecoration = InputDecoration(
  hintText: "Enter your email",
  hintStyle: style16,
  prefixIconColor: blackColor,
  suffixIconColor: blackColor,
  //fillColor: filledColor,
  filled: true,
  border: InputBorder.none,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textfiledBorderColor, width: 2.0),
    borderRadius: BorderRadius.circular(16),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textfiledBorderColor, width: 2.0),
    borderRadius: BorderRadius.circular(16),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textfiledBorderColor, width: 2.0),
    borderRadius: BorderRadius.circular(16),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textfiledBorderColor, width: 2.0),
    borderRadius: BorderRadius.circular(16),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: textfiledBorderColor, width: 2.0),
    borderRadius: BorderRadius.circular(16),
  ),
);


import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppFonts.dart';
import 'TextStyles.dart';

class AppTheme {
  static const Color _pageBackgroundColor = AppColors.white;
  static final ThemeData light = ThemeData(
    textTheme: const TextTheme(),
    fontFamily: Family.regular,
    scaffoldBackgroundColor: _pageBackgroundColor,
    colorScheme: const ColorScheme.light(
      background: AppColors.primaryColor,

    ),
    primaryColor: AppColors.primaryGreen,
    inputDecorationTheme: EditTextTheme.editTextTheme,
    floatingActionButtonTheme: _floatingButtonTheme
  );

  static final ThemeData dark = ThemeData(
    textTheme: const TextTheme(),
    fontFamily: Family.regular,
    scaffoldBackgroundColor: _pageBackgroundColor,
    colorScheme: const ColorScheme.light(
      background: AppColors.primaryColor,
    ),
    primaryColor: AppColors.primaryGreen,
    inputDecorationTheme: EditTextTheme.editTextTheme,
      floatingActionButtonTheme: _floatingButtonTheme
  );


  static FloatingActionButtonThemeData get _floatingButtonTheme => FloatingActionButtonThemeData(
    backgroundColor: _pageBackgroundColor,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppFonts.s40)),
  );
}


class EditTextTheme {
  static InputDecorationTheme get editTextTheme => InputDecorationTheme(
    focusColor: AppColors.primaryColor,
    disabledBorder: disableBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: setErrorBorder,
    labelStyle: TextStyles.regular14Black,
    outlineBorder: outlinedBorder,
    focusedBorder: focusedBorder,
    enabledBorder: enabledBorder,
  );

  static InputBorder get disableBorder => InputBorder.none;

  static BorderSide get outlinedBorder => BorderSide.none;

  static InputBorder get focusedBorder => setBorder;

  static InputBorder get enabledBorder => setBorder;

  static InputBorder get errorBorder => setErrorBorder;

  static InputBorder get setBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppFonts.s10),
      borderSide: const BorderSide(color: AppColors.grey20, width: 2));

  static InputBorder get setErrorBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppFonts.s10),
      borderSide: const BorderSide(color: AppColors.red, width: 2));
}



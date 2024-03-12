import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppFonts.dart';

class Family {
  static const String regular = "Poppins-Regular";
  static const String medium = "Poppins-Medium";
  static const String semiBold = "Poppins-SemiBold";
  static const String bold = "Poppins-Bold";
  static const String extraBold = "Poppins-ExtraBold";
}

class TextStyles {
  //Regular
  static const TextStyle regular10GreyText = TextStyle(
      color: AppColors.grey50,
      fontSize: AppFonts.s10,
      fontFamily: Family.regular);
  static const TextStyle regular12Black = TextStyle(
      color: AppColors.black,
      fontSize: AppFonts.s12,
      fontFamily: Family.regular);

  static const TextStyle regular14Black = TextStyle(
      color: AppColors.black,
      fontSize: AppFonts.s14,
      fontFamily: Family.regular);
  static const TextStyle regularTextHint = TextStyle(
      color: AppColors.grey50,
      fontSize: AppFonts.s14,
      fontFamily: Family.regular);


  //medium
  static const TextStyle medium14Black = TextStyle(
      color: AppColors.black,
      fontSize: AppFonts.s14,
      fontFamily: Family.medium);

  static const TextStyle medium14White= TextStyle(
      color: AppColors.white,
      fontSize: AppFonts.s14,
      fontFamily: Family.medium);


  //SemiBold
  static const TextStyle semiBold20Black = TextStyle(
      color: AppColors.black,
      fontSize: AppFonts.s20,
      fontFamily: Family.semiBold);

  //Bold

  //extra Bold
}

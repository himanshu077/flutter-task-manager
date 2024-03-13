import 'package:flutter/material.dart';

import '../../../core/utils/appExtension.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../constants/AppIcons.dart';
import '../../constants/TextStyles.dart';
import '../../coreWidgets/AppButton.dart';
import '../../coreWidgets/ImageView.dart';
import '../../coreWidgets/TextView.dart';

class FailureMessageDialog extends StatelessWidget {
  final Function()? onTap;
  final String message;
  final Function()? dismiss;
  const FailureMessageDialog({super.key, this.onTap, this.dismiss, required this.message});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.isPortraitMode ? mainView() : Expanded(child: SingleChildScrollView(
          child: mainView(),
        ))
      ],
    );
  }

  Widget  mainView(){
    return  Column(
      children: [
       const  ImageView(url: AppIcons.backButton,
          tintColor: AppColors.primaryColor,
          size: AppFonts.s40 * 2,),
        TextView(text: message, textStyle: TextStyles.regular16Black,
          textAlign: TextAlign.center,
          margin: const EdgeInsets.only(top: AppFonts.s10, bottom: AppFonts.s30),
        ),

        AppButton(
          padding: const EdgeInsets.symmetric(horizontal: AppFonts.s40,vertical: AppFonts.s16) ,
          onTap: onTap,
          label: 'OK',
          labelStyle: TextStyles.medium14White,
        )
      ],
    );

  }
}

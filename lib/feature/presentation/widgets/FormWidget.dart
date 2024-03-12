import 'package:flutter/material.dart';

import '../../../components/constants/TextStyles.dart';
import '../../../core/utils/appExtension.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../components/coreWidgets/AppButton.dart';
import '../../../components/widgets/AppBar2.dart';

class FormWidget extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final Widget child;
  final Function() onBackPress;
  final Function() onButtonPress;
  const FormWidget({super.key, required this.title, required this.buttonLabel, required this.child, required this.onBackPress, required this.onButtonPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar2(
              onLeadTap: context.pop,
              title: title,
              titleStyle: TextStyles.semiBold20Black,
            ),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppFonts.s20),
              child: Column(
                children: [
                  child,
                  AppButton(
                    onTap: onButtonPress,
                    label: buttonLabel,
                    margin: const EdgeInsets.symmetric(vertical: AppFonts.s40),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppIcons.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/coreWidgets/ImageView.dart';
import '../../../components/coreWidgets/TapWidget.dart';
import '../../../components/coreWidgets/TextView.dart';


class TaskListTile extends StatelessWidget {
  final Function() onDeleteAction;
  final Function() onTap;
  const TaskListTile({super.key, required this.onDeleteAction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppFonts.s10),
        child: Row(
          children: [
            const  Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextView(text: 'task title', textStyle: TextStyles.regular14Black,
                margin: EdgeInsets.only(bottom: AppFonts.s7),
              ),
                TextView(text: '12-12-2024  |  12:00AM', textStyle: TextStyles.regular10GreyText)
            ],)),
            ImageView(
              onTap: onDeleteAction,
              url: AppIcons.remove, size: AppFonts.s20,)
          ],
        ),
      ),
    );
  }
}

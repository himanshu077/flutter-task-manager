import 'package:flutter/material.dart';

import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppIcons.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/coreWidgets/ImageView.dart';
import '../../../components/coreWidgets/TapWidget.dart';
import '../../../components/coreWidgets/TextView.dart';
import '../../domain/entities/TaskEntity.dart';


class TaskListTile extends StatelessWidget {
  final TaskEntity data;
  final Function() onDeleteAction;
  final Function() onTap;
  const TaskListTile({super.key, required this.onDeleteAction, required this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppFonts.s10),
        child: Row(
          children: [
              Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextView(text: data.title, textStyle: TextStyles.regular14Black,
                margin: const EdgeInsets.only(bottom: AppFonts.s7),
              ),
                TextView(text: '${data.getDate}  |  ${data.getTime}', textStyle: TextStyles.regular10GreyText)
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

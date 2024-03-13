import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/DateTimeUtils.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../core/utils/appExtension.dart';
import '../../../components/coreWidgets/EditText.dart';
import '../bloc/task/task_bloc.dart';
import '../widgets/FormWidget.dart';

class UpdateTaskView extends StatefulWidget {
  const UpdateTaskView({super.key});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  late TaskBloc _bloc;
  final _title = TextEditingController();
  final _date = TextEditingController();
  final _time = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TaskBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
        title: 'Update Task',
        onBackPress: context.pop,
        buttonLabel: 'Update',
        onButtonPress: () => _bloc.add(UpdateTaskEvent(
            title: _title.text.trim(),
            date: _date.text.trim(),
            time: _time.text.trim())),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is UpdateTaskLoadingState) {
              context.load;
            } else if (state is UpdateTaskSuccessState) {
              context.stopLoader;
              context.pop();
            } else if (state is UpdateTaskFailureState) {
              context.stopLoader;
            } else if (state is UpdateTaskFormValidationState) {
              context.stopLoader;
            }
          },
          builder: (context, state) {
            final error = state is UpdateTaskFormValidationState ? state : null;
            return Column(
              children: [
                EditText(
                    hint: 'Title',
                    controller: _title,
                  error: error?.title,
                ),
                EditText(
                  hint: 'Date',
                  controller: _date,
                  readOnly: true,
                  margin: const EdgeInsets.symmetric(vertical: AppFonts.s20),
                  error: error?.date,
                  onTap: () => context.datePicker.then((value) {
                    if (value != null) {
                      _date.text = value.ddMMMyyyy;
                    }
                  }),
                ),
                EditText(
                  hint: 'Time',
                  readOnly: true,
                  controller: _time,
                  error: error?.time,
                  onTap: () => context.timePicker.then((value) {
                    if (value != null) {
                      _time.text = value.format(context);
                    }
                  }),
                ),
              ],
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/DateTimeUtils.dart';
import '../../../core/utils/appExtension.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../components/coreWidgets/EditText.dart';
import '../bloc/task/task_bloc.dart';
import '../widgets/FormWidget.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
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
        title: 'Create New Task',
        onBackPress: context.pop,
        buttonLabel: 'Submit',
        onButtonPress: () => _bloc.add(CreateTaskEvent(
            title: _title.text.trim(),
            date: _date.text.trim(),
            time: _time.text.trim())),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is CreateTaskLoadingState) {
              context.load;
            } else if (state is CreateTaskSuccessState) {
              context.stopLoader;
              context.pop();
            } else if (state is CreateTaskFailureState) {
              context.stopLoader;
            } else if (state is CreateTaskFormValidationState) {
              context.stopLoader;
            }
          },
          builder: (context, state) {
            final error = state is CreateTaskFormValidationState ? state : null;
            return Column(
              children: [
                EditText(
                  key: Key('titleCreate'),
                    hint: 'Title',
                    controller: _title,
                  error: error?.title,
                ),
                EditText(
                  key: Key('dateCreate'),
                  readOnly: true,
                  hint: 'Date',
                  controller: _date,
                  margin: const EdgeInsets.symmetric(vertical: AppFonts.s20),
                  error: error?.date,
                  onTap: () =>
                    context.datePicker.then((value) {
                      if (value != null) {
                        _date.text = value.ddMMMyyyy;
                      }
                    }),
                ),
                EditText(
                  key: Key('timeCreate'),
                  hint: 'Time',
                  readOnly: true,
                  controller: _time,
                  error: error?.time,
                  onTap: () =>
                    context.timePicker.then((value) {
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





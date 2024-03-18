
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_manager/components/coreWidgets/AppButton.dart';
import 'package:flutter_task_manager/components/coreWidgets/EditText.dart';
import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_task_manager/feature/presentation/pages/UpdateTaskView.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // late MockBloc bloc;
  late TaskBloc bloc;
  final stamp = DateTime.now().timeStamp;
  final entity = TaskEntity(title: 'title', timeStamp: stamp, createdAt: stamp);

  final list = [
    entity,
    entity,
    entity
  ];

  setUp(() {
    bloc = TaskBloc();
    bloc.tasks = list;
    bloc.updateTaskIndex = 1;
  });

  Widget _makeTestableWidget(Widget body) {
    return
      MultiBlocProvider(
        providers: [BlocProvider<TaskBloc>(create: (context) => TaskBloc(),)],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('initial state UpdateTask', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(const UpdateTaskView()));
    final titleField = find.byType(EditText);
    final button = find.byType(AppButton);
    await tester.pump();

    expect(titleField, findsNWidgets(3));
    expect(button, findsOneWidget);
  });

  testWidgets('UpdateTaskView UI Test when form field are empty', (WidgetTester tester) async {
    // Build CreateTaskView widget
    await tester.pumpWidget(_makeTestableWidget(const UpdateTaskView()));

    expect(find.byKey(Key('formSubmitButton')), findsOneWidget); // Submit button

    await tester.tap(find.byKey(Key('formSubmitButton')));
    await tester.pumpAndSettle();
    //
    expect(find.text('Please select time'),findsOneWidget);
    expect(find.text('Please select date'),findsOneWidget);
    expect(find.text('Please enter task title'),findsOneWidget);
  });

  testWidgets('UpdateTaskView UI Test when form field are field', (WidgetTester tester) async {
    // Build CreateTaskView widget
    final obj = bloc.tasks[bloc.updateTaskIndex];
    await tester.pumpWidget(_makeTestableWidget(const UpdateTaskView()));


    await tester.enterText(find.byKey(Key('titleUpdate')),obj.title);
    (tester.widget(find.byKey(Key('dateUpdate'))) as EditText).controller.text = obj.getDate;
    (tester.widget(find.byKey(Key('timeUpdate'))) as EditText).controller.text = obj. getTime;

    // Tap the Submit button
    await tester.tap(find.byKey(Key('formSubmitButton')));
    await tester.pump();

    expect(find.text('Please select time'),findsNothing);
    expect(find.text('Please select date'),findsNothing);
    expect(find.text('Please enter task title'),findsNothing);
  });
}
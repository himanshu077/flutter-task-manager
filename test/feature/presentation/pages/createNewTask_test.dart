import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_manager/components/coreWidgets/AppButton.dart';
import 'package:flutter_task_manager/components/coreWidgets/EditText.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_task_manager/feature/presentation/pages/CreateTaskView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  // late MockBloc bloc;
  late TaskBloc bloc;
  setUp(() {
    bloc = TaskBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [BlocProvider<TaskBloc>(create: (context) => TaskBloc(),)],
        child: MaterialApp(
      home: body,
    ));
  }




  testWidgets('initial state', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(const CreateTaskView()));
    final titleField = find.byType(EditText);
    final button = find.byType(AppButton);
    await tester.pump();

    expect(titleField, findsNWidgets(3));
    expect(button, findsOneWidget);
  });


  testWidgets('CreateTaskView UI Test when form field are empty', (WidgetTester tester) async {
    // Build CreateTaskView widget
    await tester.pumpWidget(_makeTestableWidget(const CreateTaskView()));

    expect(find.text('Create New Task'), findsOneWidget); // Title
    expect(find.text('Title'), findsOneWidget); // Title EditText hint
    expect(find.text('Date'), findsOneWidget); // Date EditText hint
    expect(find.text('Time'), findsOneWidget); // Time EditText hint

    expect(find.byKey(Key('formSubmitButton')), findsOneWidget); // Submit button

    await tester.tap(find.byKey(Key('formSubmitButton')));
     await tester.pumpAndSettle();

     expect(find.text('Please select time'),findsOneWidget);
     expect(find.text('Please select date'),findsOneWidget);
     expect(find.text('Please enter task title'),findsOneWidget);
  });



  testWidgets('CreateTaskView UI Test when form field are field', (WidgetTester tester) async {
    // Build CreateTaskView widget
    await tester.pumpWidget(_makeTestableWidget(const CreateTaskView()));


    await tester.enterText(find.byKey(Key('titleCreate')),'title');
    (tester.widget(find.byKey(Key('dateCreate'))) as EditText).controller.text = '18-Mar-2024';
    (tester.widget(find.byKey(Key('timeCreate'))) as EditText).controller.text = '12:00 AM';

    // Tap the Submit button
    await tester.tap(find.byKey(Key('formSubmitButton')));
    await tester.pump();

    expect(find.text('Please select time'),findsNothing);
    expect(find.text('Please select date'),findsNothing);
    expect(find.text('Please enter task title'),findsNothing);
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/presentation/widgets/TaskListTile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _testableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('description', (tester) async {
    await tester.pumpWidget(_testableWidget(TaskListTile(
        onDeleteAction: () {},
        onTap: () {},
        data: const TaskEntity(timeStamp: 1, createdAt: 1, title: 'title'))));

    final card = find.byType(TaskListTile);
    await tester.pump();

    expect(find.text('title'), findsOneWidget);
    expect(card, findsOneWidget);
  });
}

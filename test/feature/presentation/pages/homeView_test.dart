import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_manager/core/utils/DateTimeUtils.dart';
import 'package:flutter_task_manager/feature/domain/entities/TaskEntity.dart';
import 'package:flutter_task_manager/feature/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_task_manager/feature/presentation/pages/HomeView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  late TaskBloc bloc;


  setUp(() {
    bloc = TaskBloc();
  });
  final stamp = DateTime.now().timeStamp;
  final entity = TaskEntity(title: 'title', timeStamp: stamp, createdAt: stamp);

  final list = [entity,entity,entity];


  Widget _testableWidget(Widget body){
    return MultiBlocProvider(
        providers: [BlocProvider<TaskBloc>(create: (context) => TaskBloc(),)],
        child: MaterialApp(
          home: body,
        )
    );
  }


  testWidgets('initial when list is empty', (tester) async{

    await tester.pumpWidget(_testableWidget(const HomeView()));

    await tester.pump();
    if(bloc.state is TaskHomeLoadingState){
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    }else{
      expect(find.text('No Task found'), findsOneWidget);
    }
  });



  testWidgets('on fetch list', (tester) async{

    bloc.tasks = list;
    await tester.pumpWidget(_testableWidget(const HomeView()));
     bloc.add(FetchTasksEvent());

    await tester.pump();

    if(bloc.tasks.isNotEmpty){
      expectLater(find.byType(ListView), findsOneWidget);
    }else{
      expectLater(find.text('No Task found'), findsOneWidget);
    }

  });



}
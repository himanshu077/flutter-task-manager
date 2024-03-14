import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/constants/AppTheme.dart';
import 'feature/presentation/bloc/task/task_bloc.dart';
import 'feature/presentation/pages/SplashView.dart';
import 'services/storage/storageServices.dart';

void main() async{
  await StorageService.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => TaskBloc()),
];

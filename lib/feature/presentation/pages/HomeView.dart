import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/constants/AppColors.dart';
import '../../../core/utils/appExtension.dart';
import '../../../components/constants/AppFonts.dart';
import '../../../components/constants/AppStrings.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../components/widgets/AppBar2.dart';
import '../bloc/task/task_bloc.dart';
import '../widgets/TaskListTile.dart';
import 'CreateTaskView.dart';
import 'UpdateTaskView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TaskBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<TaskBloc>();
    _bloc.add(FetchTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBar2(
              isLeadVisible: false,
              title: AppStrings.appName,
              titleStyle: TextStyles.semiBold20Black,
            ),
            Expanded(
                child: BlocConsumer<TaskBloc, TaskState>(
                  listener: (context, state) {
                    if(state is TaskHomeLoadingState){
                      context.load;
                    }else if(state is TaskHomeSuccessState){
                      context.stopLoader;
                    }
                  },
                  builder: (context, state) {
                    return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(AppFonts.s20),
                        itemBuilder: (context, index) =>
                            TaskListTile(
                              onTap: () =>
                                  context.pushNavigator(const UpdateTaskView()),
                              onDeleteAction: ()=> _bloc.add(RemoveTaskEvent(id: 'id')),
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _bloc.tasks.length);
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNavigator(const CreateTaskView()),
        child: const Icon(Icons.add, color: AppColors.black),
      ),
    );
  }
}

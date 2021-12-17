import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/shared/app_cubit/app_states/app_states.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';

class NewTasks extends StatefulWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var task = AppCubit.get(context).NewList;
        return ConditionalBuilder(
            condition: task.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => taskLabel(task[index], context,
                    doneIcon: const Icon(
                      Icons.check_box,
                      color: Colors.black26,
                    ),
                    archivedIcon: const Icon(
                      Icons.archive,
                      color: Colors.black26,
                    )),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                itemCount: task.length),
            fallback: (context) =>
                emptyPage(i: Icons.menu, text: 'new tasks is empty!'));
      },
    );
  }
}

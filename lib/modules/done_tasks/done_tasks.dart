import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/shared/app_cubit/app_states/app_states.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';
import 'package:im/shared/component/componant.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = AppCubit.get(context);
        return ConditionalBuilder(
            condition: c.DoneList.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    taskLabel(c.DoneList[index], context,
                        doneIcon: const Icon(
                          Icons.check_box,
                          color: Colors.green,
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
                itemCount: c.DoneList.length),
            fallback: (context) => emptyPage(
                i: Icons.check_circle_outline, text: 'done tasks is empty!'));
      },
    );
  }
}

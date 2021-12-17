import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/archived_tasks/archived_tasks.dart';
import 'package:im/modules/done_tasks/done_tasks.dart';
import 'package:im/modules/new_tasks/new_tasks.dart';
import 'package:im/shared/app_cubit/app_states/app_states.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Todo extends StatelessWidget {
  var k = GlobalKey<ScaffoldState>();
  var form = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {
          if (states is InsertDataState) {
            Navigator.pop(context);
          }
        },
        builder: (context, states) {
          AppCubit cubit = BlocProvider.of(context);
          return Scaffold(
              key: k,
              appBar: AppBar(
                title: Text(cubit.title[cubit.current]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.show) {
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                    k.currentState!
                        .showBottomSheet((context) => Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(15.0),
                              child: Form(
                                key: form,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultField(
                                        Controller: titleController,
                                        type: TextInputType.text,
                                        vale: (value) {
                                          if (value!.isEmpty) {
                                            return 'title must not be empty';
                                          }
                                          return null;
                                        },
                                        lbName: 'title',
                                        pre: Icons.title),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultField(
                                        tap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text =
                                                value!.format(context);
                                          });
                                        },
                                        Controller: timeController,
                                        type: TextInputType.datetime,
                                        vale: (value) {
                                          if (value!.isEmpty) {
                                            return 'time must not be empty';
                                          }
                                          return null;
                                        },
                                        lbName: 'time',
                                        pre: Icons.watch_later_outlined),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultField(
                                        tap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2021-12-01'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMd().format(value!);
                                          });
                                        },
                                        Controller: dateController,
                                        type: TextInputType.datetime,
                                        vale: (value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        },
                                        lbName: 'date',
                                        pre: Icons.calendar_today_outlined),
                                  ],
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      cubit.ChangeSheet(tor: true, icon: Icons.add);
                    });
                    cubit.ChangeSheet(tor: false, icon: Icons.edit);
                  } else {
                    if (form.currentState!.validate()) {
                      cubit.insertDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);

                      cubit.ChangeSheet(tor: true, icon: Icons.add);
                    }
                  }
                },
                child: Icon(cubit.e),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.current,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    cubit.NavBar(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined), label: 'Archived'),
                  ]),
              body: cubit.pages[cubit.current]);
        },
      ),
    );
  }
}

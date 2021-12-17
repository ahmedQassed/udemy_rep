import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/archived_tasks/archived_tasks.dart';
import 'package:im/modules/contacts_page/contactsPage.dart';
import 'package:im/modules/done_tasks/done_tasks.dart';
import 'package:im/modules/new_tasks/new_tasks.dart';
import 'package:im/shared/app_cubit/app_states/app_states.dart';
import 'package:im/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInit());

  static AppCubit get(context) => BlocProvider.of(context);

  int current = 0;
  List<Widget> pages = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> title = ['new tasks', 'done tasks', 'archived tasks'];

  void NavBar(int index) {
    current = index;
    emit(ChangeBottomNavBar());
  }

  late Database db;
  List<Map> NewList = [];
  List<Map> DoneList = [];
  List<Map> ArchivedList = [];

  createDatabase() {
    openDatabase('tasks.db', version: 1, onCreate: (database, version) {
      print('database created');

      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('tables created');
      }).catchError((onError) {
        print('error when : ${onError.toString()}');
      });
    }, onOpen: (data) {
      getData(data);
    }).then((value) {
      db = value;
      emit(CreateDataState());
    });
  }

  insertDatabase(
      {required String title,
      required String date,
      required String time}) async {
    db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('inserting success');
        emit(InsertDataState());

        getData(db);
      });
    });
  }

  void getData(data) {
    NewList = [];
    DoneList = [];
    ArchivedList = [];
    data.rawQuery('SELECT * FROM tasks').then((value) {
      emit(GetDataState());

      value.forEach((element) {
        if (element['status'] == 'new') {
          NewList.add(element);
        } else if (element['status'] == 'done') {
          DoneList.add(element);
        } else {
          ArchivedList.add(element);
        }
      });
    });
  }

  void updateDate({required String updateName, required int id}) {
    db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$updateName', id]).then((value) {
      getData(db);
      emit(UpdateDataState());
    });
  }

  void deleteData({required int id}) {
    db.rawDelete('DELETE FROM tasks WHERE id = ? ', [id]);
    getData(db);
    emit(DeleteDataState());
  }

  bool show = true;
  IconData e = Icons.add;

  void ChangeSheet({required bool tor, required IconData icon}) {
    show = tor;
    e = icon;
    emit(ChangeIcon());
  }

  void icons({required IconData done, required IconData archived}) {
    Icon(done);
    Icon(archived);
    emit(IconState());
  }

  bool ligh = true;

  void appMode({bool? f}) {
    if (f != null) {
      ligh = f;
    } else {
      ligh = !ligh;
      CacheHelper.putBool(key: 'changeMode', value: ligh).then((value) {
        emit(AppMode());
      });
    }
  }
}

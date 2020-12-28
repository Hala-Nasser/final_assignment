import 'package:flutter/material.dart';
import 'package:flutter_app_final/task_model.dart';

import 'db_helper.dart';

class AppProvider with ChangeNotifier {
  List<Task> list = List<Task>();
  bool isComplete = false;

  Future getTasks() async {
    List<Task> newList = [];
    await DBHelper.dbHelper
        .selectAllTasks()
        .then((value) => value.forEach((element) {
              newList.add(Task.fromMap(element));
            }))
        .whenComplete(() => list.clear())
        .whenComplete(() => list.addAll(newList))
        .whenComplete(() => notifyListeners());
  }

  updateTask(Task task) async {
    await DBHelper.dbHelper
        .updateTask(task)
        .whenComplete(() => notifyListeners());
  }

  deleteTask(int id) async {
    await DBHelper.dbHelper.deleteTask(id);
    getTasks();
  }

  Future insertTask(Task task) async {
    await DBHelper.dbHelper.insertNewTask(task);
    getTasks();
  }

}

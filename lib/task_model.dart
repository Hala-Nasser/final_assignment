import 'db_helper.dart';

class Task {
  int id;
  String taskName;
  bool isComplete;

  Task(this.taskName, this.isComplete);

  static toMap(Task task) {
    return {
      DBHelper.taskNameColumnName: task.taskName,
      DBHelper.taskIsCompleteName: task.isComplete ? 1 : 0
    };
  }

  static Task fromMap(Map map) {
    bool value;
    if (map[DBHelper.taskIsCompleteName] == 1)
      value = true;
    else
      value = false;
    var task = Task(map[DBHelper.taskNameColumnName], value);
    task.id = map[DBHelper.taskIdColumnName];
    return task;
  }
}

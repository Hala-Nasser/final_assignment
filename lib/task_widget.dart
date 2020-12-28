import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final/app_provider.dart';

import 'package:provider/provider.dart';

import 'task_model.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  Function function;
  TaskWidget(this.task);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, prov, child) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showAlertDialog(BuildContext context) {
                          AlertDialog alert = AlertDialog(
                              title: Text(
                                "Alert",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                  "You will Delete A task, are you sure?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              actions: [
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    prov.deleteTask(task.id);
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }

                        showAlertDialog(context);
                      }),
                  Text(task.taskName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  Checkbox(
                      value: task.isComplete,
                      onChanged: (value) {
                        task.isComplete = !task.isComplete;
                        prov.updateTask(task);
                      })
                ]));
      },
    );
  }
}

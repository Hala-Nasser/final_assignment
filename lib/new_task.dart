import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final/task_model.dart';
import 'package:provider/provider.dart';
import 'app_provider.dart';

class NewTask extends StatelessWidget {
  String taskName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Consumer<AppProvider>(
          builder: (context, prov, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onChanged: (value) {
                      this.taskName = value;
                    },
                  ),
                  Consumer<AppProvider>(builder: (context, prov, child) {
                    return RaisedButton(
                        child: Text('Add New Task'),
                        onPressed: () {
                          prov
                              .insertTask(Task(this.taskName, false))
                              .whenComplete(() => Navigator.pop(context));
                        });
                  })
                ]);
          },
        ),
      ),
    );
  }
}

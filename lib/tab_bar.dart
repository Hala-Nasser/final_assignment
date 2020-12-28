import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final/task_model.dart';
import 'package:flutter_app_final/task_widget.dart';
import 'package:provider/provider.dart';

import 'app_provider.dart';
import 'new_task.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage();
  TabController tabController;
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.tabController = TabController(length: 3, vsync: this);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Consumer<AppProvider>(builder: (context, value, child) {
          value.getTasks();
          return Scaffold(
            drawer: Drawer(),
            appBar: AppBar(
              title: Text("Todo Task"),
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Container(
                      child: Text(
                        'All Tasks',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Complete Tasks',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      child: Text(
                          'InComplete '
                          'Tasks',
                          style: TextStyle(fontSize: 16)),
                    ),
                  )
                ],
                isScrollable: true,
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                AllTasks(),
                CompleteTasks(),
                InCompleteTasks(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewTask();
                }));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
            ),
          );
        }));
  }
}

// class TabBarPage extends StatefulWidget {
//   @override
//   _TabBarPageState createState() => _TabBarPageState();
// }
//
// class _TabBarPageState extends State<TabBarPage>
//     with SingleTickerProviderStateMixin {
//   TabController tabController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//     _pageController = PageController();
//   }
//
//   PageController _pageController;
//   int _currentIndex = 0;
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(),
//       appBar: AppBar(
//         title: Text('Todo'),
//         bottom: TabBar(
//           controller: tabController,
//           tabs: [
//             Tab(
//               child: Container(
//                 child: Text(
//                   'All Tasks',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 width: 100,
//                 margin: EdgeInsets.only(left: 10),
//                 child: Text('Complete Tasks', style: TextStyle(fontSize: 16)),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 width: 100,
//                 child: Text(
//                     'InComplete '
//                         'Tasks',
//                     style: TextStyle(fontSize: 16)),
//               ),
//             )
//           ],
//           isScrollable: true,
//         ),
//       ),
//       body: SizedBox.expand(
//         child: PageView(
//           controller: _pageController,
//           onPageChanged: (index) {
//             setState(() => _currentIndex = index);
//           },
//           children: [
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 children: <Widget>[
//                   AllTasks(),
//                   CompleteTasks(),
//                   InCompleteTasks()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return NewTask();
//             },
//           ));
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }
// }

class AllTasks extends StatefulWidget {
  List<Task> array = [];
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        child: Column(
          children: provider.list.map((e) => TaskWidget(e)).toList(),
        ),
      );
    });
  }
}

class CompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        child: Column(
          children: provider.list
              .where((element) => element.isComplete == true)
              .map((e) => TaskWidget(e))
              .toList(),
        ),
      );
    });
  }
}

class InCompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        child: Column(
          children: provider.list
              .where((element) => element.isComplete == false)
              .map((e) => TaskWidget(e))
              .toList(),
        ),
      );
    });
  }
}

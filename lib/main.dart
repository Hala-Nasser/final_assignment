import 'package:flutter/material.dart';
import 'package:flutter_app_final/app_provider.dart';
import 'package:flutter_app_final/tab_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) {
        return AppProvider();
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: TabBarPage()),
    );
  }
}

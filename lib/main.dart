import 'package:flutter/material.dart';
import 'package:test_project/features/pages/today_task/today_task_screen.dart';
import 'features/pages/add_task/add_task_create.dart';
import 'features/pages/calendar/SelectionModeScreen.dart';
import 'helpers/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Calendar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TodayTaskScreen(),
    );
  }
}
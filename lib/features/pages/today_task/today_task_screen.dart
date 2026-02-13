import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:test_project/core/controllers/task_controller.dart';
import 'package:test_project/features/ui/size_config.dart';
import 'package:test_project/styles/app_styles.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreen();
}

class _TodayTaskScreen extends State<TodayTaskScreen> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _customAppBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 8),
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _customAppBar(){
    return AppBar(
      leading: IconButton(
          onPressed: onPressed,
          icon: icon
      ),
    )
  }
}

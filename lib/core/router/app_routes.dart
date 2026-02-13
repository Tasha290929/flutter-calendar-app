import 'package:get/get.dart';
import 'package:test_project/features/pages/reports/reports_screen.dart';
import 'package:test_project/features/pages/settings/settings_screen.dart';

import '../../features/pages/add_task/add_task_create.dart';
import '../../features/pages/today_task/today_task_screen.dart';

class AppRoutes {
  static final routers = [
    GetPage(name: '/today', page: () => TodayTaskScreen()),
    GetPage(name: '/calendar', page: () => TodayTaskScreen()),
    GetPage(name: '/add-task', page: () => AddTaskCreate()),
    GetPage(name: '/reports', page: () => ReportsScreen()),
    GetPage(name: '/settings', page: () => SettingsScreen()),
  ];
}
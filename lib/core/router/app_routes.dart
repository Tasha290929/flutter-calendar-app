import 'package:get/get.dart';

import '../../features/add_task/add_task_create.dart';

class AppRoutes {
  static final routers = [
    GetPage(name: '/today', page: page),
    GetPage(name: '/calendar', page: page),
    GetPage(name: '/add-task', page: () => AddTaskCreate()),
    GetPage(name: '/reports', page: page),
    GetPage(name: '/settings', page: page),
  ]
}
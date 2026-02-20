import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:test_project/core/controllers/task_controller.dart';
import 'package:test_project/core/services/theme_services.dart';
import 'package:test_project/features/pages/add_task/add_task_create.dart';
import 'package:test_project/features/ui/size_config.dart';
import 'package:test_project/styles/app_styles.dart';

import '../../../models/task.dart';
import '../../widgets/button.dart';
import '../../widgets/task_tile.dart';

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

  AppBar _customAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode ? Icons.sunny : Icons.dark_mode,
          size: 24,
          color: Get.isDarkMode ? Colors.white : AppColors.lightGreyLavender,
        ),
      ),
      elevation: 0,
      backgroundColor: AppColors.background,
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                // style: subHeadingStyle,
              ),
              Text(
                'Today',
                // style: subHeadingStyle,
              ),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskCreate());
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: _selectedDate,
        selectedTextColor: AppColors.white,
        selectionColor: AppColors.lightGreyLavender,
        dateTextStyle: AppTextStyles.headingSection,
        dayTextStyle: AppTextStyles.bodyMedium,
        monthTextStyle: AppTextStyles.headingCards,
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          var task = _taskController.taskList[index];

          if (task.repeat == 'Daily' ||
              task.date == DateFormat.yMd().format(_selectedDate) ||
              (task.repeat == 'Weekly' &&
                  _selectedDate
                              .difference(DateFormat.yMd().parse(task.date!))
                              .inDays %
                          7 ==
                      0) ||
              (task.repeat == 'Monthly' &&
                  DateFormat.yMd().parse(task.date!).day ==
                      _selectedDate.day)) {
            try {
              var date = DateFormat.jm().parse(task.startTime!);
              var myTime = DateFormat('HH:mm').format(date);

              /*notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                ),*/
            } catch (e) {
              print('Error parsing time: $e');
            }
          } else {
            Container();
          }
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(microseconds: 1375),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => _showBottomSheet(context, task),
                    child: TaskTitle(task),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: _taskController.taskList.length,
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(microseconds: 500),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            children: [
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(height: 6)
                  : const SizedBox(height: 220),
              Icon(
                Icons.list_alt_outlined,
                color: AppColors.violet.withOpacity(0.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Text(
                  'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
                  style: AppTextStyles.basicText,
                  textAlign: TextAlign.center,
                ),
              ),
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(height: 120)
                  : const SizedBox(height: 180),
            ],
          ),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.6
                    : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.30
                    : SizeConfig.screenHeight * 0.39),
          color: AppColors.lightGreyLavender,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      lable: 'Task complet',
                      onTap: () {
                        _taskController.markTaskAsCompleted(task.id!);
                        Get.back();
                      },
                      clr: AppColors.dullLavender,
                    ),
              _buildBottomSheet(
                lable: 'Delete Task',
                onTap: () {
                  _taskController.deleteTasks(task);
                  Get.back();
                },
                clr: Colors.red[300]!,
              ),
              Divider(
                color: Get.isDarkMode
                    ? Colors.grey
                    : AppColors.lightGreyLavender,
              ),
              _buildBottomSheet(
                lable: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: AppColors.violet,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomSheet({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(child: Text(lable)),
      ),
    );
  }
}

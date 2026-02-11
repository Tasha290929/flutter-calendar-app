import 'package:flutter/material.dart';
import 'package:test_project/features/ui/input_field.dart';
import '../../core/controllers/task_controller.dart';
import '../../models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../ui/button.dart';

class AddTaskCreate extends StatefulWidget {
  const AddTaskCreate({Key? key}) : super(key: key);

  @override
  State<AddTaskCreate> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskCreate> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat(
    'hh:mm a',
  ).format(DateTime.now().add(const Duration(minutes: 15))).toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _customAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(
                title: 'Title',
                hint: 'Enter tile here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _descriptionController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () => _getDateFormUser(),
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  hint: '$_selectedRemind minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: remindList
                        .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem(
                                value: value.toString(),
                                child: Text(
                                  '$value',
                                  style: const TextStyle(color: Colors.white),
                                ))
                        ).toList(),
                        icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey,),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                        // style: subTitleStyle,
                        onChanged: (String? newvalue){
                        setState(() {
                          _selectedRemind = int.parse(newvalue!);
                        });
                        }
                    ),
                    const SizedBox(width: 6,),
                  ],
                ),
              ),
              InputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatList
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              ))
                      ).toList(),
                      icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      // style: subTitleStyle,
                      onChanged: (String? newValue){
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6,),
                  ],
                ),
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateData();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _customAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios, size: 24, color: Colors.white),
      ),
      title: const Text('Add Task'),
      elevation: 0,
      centerTitle: true,
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (_titleController.text.isNotEmpty ||
    _descriptionController.text.isNotEmpty){
      Get.snackbar('reqired', 'All fields are required!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.pinkAccent,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        )
      );
    } else {
      print(
          '############################ SOMETHING WRONG HAPPENED #############################');
    }
  }

  _addTasksToDb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
          title: _titleController.text,
          description: _descriptionController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('Value: $value');
    } catch (e) {
      print('error: $e');
    }
  }

  _getDateFormUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    } else {
      print('Please select correct date');
    }
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
        ),
        const SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(
            3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: CircleAvatar(
                    backgroundColor: index == 0
                    ? Colors.blue
                    : index == 1
                    ? Colors.pinkAccent
                    : Colors.cyanAccent,
                    radius: 14,
                    child: _selectedColor == index
                    ? const Icon(
                      Icons.done,
                      size: 16,
                      color: Colors.white,
                    ) : null,
                  ),
                ),
              )
          ),
        )
      ],
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pikedtime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15)),
            ),
    );

    String formattedTime = pikedtime!.format(context);

    if (isStartTime) {
      setState(() => _startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => _endTime = formattedTime);
    } else {
      print('Something went wrong !');
    }
  }
}

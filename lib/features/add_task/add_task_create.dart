import 'package:flutter/material.dart';
import '../../core/controllers/task_controller.dart';
import '../../models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskCreate extends StatefulWidget{
  const AddTaskCreate({Key? key}) : super(key: key);

  @override
 State<AddTaskCreate> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskCreate>{
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String _selectedRepead = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  _getDateFormUser() async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2025),
        lastDate: DateTime(2050)
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    } else {
      print('Please select correct date');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pikedtime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))
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
/*
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test_project/models/task.dart';

class DBHelper {
  static Db? _db;
  static DbCollection? _taskCollection;

  //Connection with db
  static Future<void> init() async {
    _db = Db('mongodb://localhost:27017/tasksdb');
    await _db!.open();

    _taskCollection = _db!.collection('tasks');
  }

  // Add new Task
  static Future<int> insert(Task? task) async {
    if (task == null) return 0;
    final resalt = await _taskCollection!.insertOne(task.toJson());
    return resalt.isSuccess ? 1 : 0;
  }

  //Take all Tasks
  static Future<List<Map<String, dynamic>>> query() async {
    final tasks = await _taskCollection!.find().toList();
    return tasks;
  }

  //Delete one task by id
  static Future<int> delete(Task task) async {
    final result = await _taskCollection!.deleteOne({'id': task.id});
    return result.isSuccess ? 1 : 0;
  }

  //Delete all tasks
  static Future<int> deleteAll() async {
    final resalt = await _taskCollection!.deleteMany({});
    return resalt.isSuccess ? 1 : 0;
  }

  //Update task
static Future<int> update(int id,{bool? isCompleted}) async{
    final result = await _taskCollection!.updateOne(
      where.eq('id', id),
      modify.set('isCompleted', isCompleted ?? true),
    );
    return result.isSuccess ? 1 : 0;
}

//End connection with base
static Future<void> close() async{
    await _db?.close();
}
}
*/

import 'package:test_project/models/task.dart';

class DBHelper {
  static bool _isDbAvailable = false; // Флаг наличия БД

  //Connection with db
  static Future<void> init() async {
    try {
      // Тут можно подключение к MongoDB, если она есть
      // await _db!.open();
      _isDbAvailable = false; // Пока нет БД
    } catch (e) {
      print('DB not available: $e');
      _isDbAvailable = false;
    }
  }

  // Add new Task
  static Future<int> insert(Task? task) async {
    if (task == null) return 0;
    if (!_isDbAvailable) return 1; // Имитируем успешную вставку
    // final result = await _taskCollection!.insertOne(task.toJson());
    // return result.isSuccess ? 1 : 0;
    return 1;
  }

  //Take all Tasks
  static Future<List<Map<String, dynamic>>> query() async {
    if (!_isDbAvailable) return []; // Возвращаем пустой список
    // return await _taskCollection!.find().toList();
    return [];
  }

  //Delete one task by id
  static Future<int> delete(Task task) async {
    if (!_isDbAvailable) return 1; // Имитируем успех
    // final result = await _taskCollection!.deleteOne({'id': task.id});
    // return result.isSuccess ? 1 : 0;
    return 1;
  }

  //Delete all tasks
  static Future<int> deleteAll() async {
    if (!_isDbAvailable) return 1;
    // final result = await _taskCollection!.deleteMany({});
    // return result.isSuccess ? 1 : 0;
    return 1;
  }

  //Update task
  static Future<int> update(int id, {bool? isCompleted}) async {
    if (!_isDbAvailable) return 1;
    // final result = await _taskCollection!.updateOne(
    //   where.eq('id', id),
    //   modify.set('isCompleted', isCompleted ?? true),
    // );
    // return result.isSuccess ? 1 : 0;
    return 1;
  }

  //End connection with base
  static Future<void> close() async {
    if (!_isDbAvailable) return;
    // await _db?.close();
  }
}

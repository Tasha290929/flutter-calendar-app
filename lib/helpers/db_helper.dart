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

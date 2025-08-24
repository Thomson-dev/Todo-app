import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  // [title, done, time, priority]
  List toDoList = [];

  final Box _box = Hive.box('myBox'); // be sure main.dart opened 'myBox'

  void createInitialData() {
    toDoList = [
      ['Make Tutorial', false, '8:00 AM', 'High Priority'],
      ['Do Exercise', false, '9:00 AM', 'Medium Priority'],
    ];
    updateData();
  }

  void loadData() {
    final data = _box.get('TODOLIST');
    if (data is List) {
      toDoList =
          data.whereType<List>().map((e) => List<dynamic>.from(e)).toList();
    }
  }

  void updateData() {
    _box.put('TODOLIST', toDoList);
  }
}

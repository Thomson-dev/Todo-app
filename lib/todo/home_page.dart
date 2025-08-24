import 'package:TodoApp/todo/Data/database.dart';
import 'package:TodoApp/todo/create_task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:TodoApp/todo/Data/database.dart';
import 'package:TodoApp/todo/create_task.dart';
import 'package:TodoApp/todo/utills/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const purple = Color(0xFF9747FF);

  DateTime _selectedDate = DateTime.now();

  // Simple list: [title, done, time, priority]
  // In a real app, use a proper database like Hive or SQLite

  final _mybox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

@override
void initState() {
  super.initState();
  if (_mybox.get('TODOLIST') == null) {
    db.createInitialData();
  } else {
    db.loadData();
  }
  // no need for setState here; data set before first build
}

  void checkBoxChanged(bool? value, int index) {
    setState(() => db.toDoList[index][1] = !db.toDoList[index][1]);
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() => db.toDoList.removeAt(index));
    db.updateData();
  }

  Future<void> _addTask() async {
    final newTask = await Navigator.push<List<dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CreateTaskPage()),
    );
    print('Returned: $newTask');
    if (newTask != null && newTask.length == 4) {
      setState(() => db.toDoList.add(newTask));
      db.updateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0,
        toolbarHeight: 72,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconBtn(Icons.grid_view_rounded, () {}),
              Text(
                dateLabel(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              iconBtn(Icons.access_time, () {}),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: purple,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: headerTopRow(
                onAdd: _addTask,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dateChips(
                    selected: _selectedDate,
                    onSelected: (d) {
                      setState(() => _selectedDate = d);
                      // filter tasks by date here later if you add dates to tasks
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'My Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    itemCount: db.toDoList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final row = db.toDoList[index];
                      return taskTile(
                        onDelete: () {
                          deleteTask(index);
                        },
                        time: row[2] as String,
                        taskName: row[0] as String,
                        subtitle: row[3] as String,
                        taskCompleted: row[1] as bool,
                        onChanged: (v) => checkBoxChanged(v, index),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

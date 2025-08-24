import 'package:TodoApp/todo/utills/widget.dart';
import 'package:flutter/material.dart';


class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _time = TextEditingController();
  String _priority = 'Medium Priority';

  static const lilac = Color(0xFFF4EEFF);
  static const purple = Color(0xFF6C4AB6);

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _time.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: now);
    if (picked != null) _time.text = picked.format(context);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final timeStr =
          _time.text.isEmpty ? TimeOfDay.now().format(context) : _time.text;
      final taskRow = [
        _title.text.trim(), // title
        false, // done
        timeStr, // time (string the list expects)
        _priority, // priority
      ];
      Navigator.pop(context, taskRow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lilac,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header bar
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: purple,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.timer_outlined),
                    color: purple,
                    onPressed: _pickTime,
                  ),
                ],
              ),
            ),

            // Scrollable white sheet
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CalendarWidget(),
                          const SizedBox(height: 16),
                          inputField(
                            controller: _title,
                            hintText: 'Task title...',
                            validator:
                                (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Enter a title'
                                        : null,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: _pickTime,
                            child: AbsorbPointer(
                              child: inputField(
                                controller: _time,
                                hintText: 'Pick time',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _priority,
                            decoration: InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              isDense: true,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'High Priority',
                                child: Text('High Priority'),
                              ),
                              DropdownMenuItem(
                                value: 'Medium Priority',
                                child: Text('Medium Priority'),
                              ),
                              DropdownMenuItem(
                                value: 'Low Priority',
                                child: Text('Low Priority'),
                              ),
                            ],
                            onChanged: (v) {
                              if (v != null) setState(() => _priority = v);
                            },
                          ),
                          const SizedBox(height: 16),
                          inputField(
                            controller: _desc,

                            hintText: 'Details (optional)...',
                            maxLines: 4,
                          ),
                          const SizedBox(height: 24),
                          createTaskButton(_save),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

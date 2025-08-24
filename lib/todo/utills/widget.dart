import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:table_calendar/table_calendar.dart';

// Define the purple color used in the widgets
const Color purple = Color(0xFF6C4AB6);
// Define the lilac color used in input fields
const Color lilac = Color(0xFFF4EEFF);

// Replace the existing dateChipsPlaceholder() with:
Widget dateChips({
  required DateTime selected,
  required ValueChanged<DateTime> onSelected,
  int days = 7,
}) {
  final start = DateTime.now();
  final items = List.generate(days, (i) {
    final d = DateTime(start.year, start.month, start.day + i);
    return d;
  });
  const wk = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return SizedBox(
    height: 74,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) {
        final d = items[i];
        final isSel =
            d.year == selected.year &&
            d.month == selected.month &&
            d.day == selected.day;
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onSelected(d),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 58,
            decoration: BoxDecoration(
              color: isSel ? purple : lilac,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  d.day.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSel ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  wk[d.weekday - 1],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSel ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// HEADER LEFT + BUTTON
Widget headerTopRow({required VoidCallback onAdd}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Today',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '6 Tasks',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
      ElevatedButton(
        onPressed: onAdd,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: purple,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Add New',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

// A reusable custom input field widget for forms/text inputs
Widget inputField({
  required TextEditingController controller, // Controller to read/write text
  // required String label, // Label displayed above the field
  String? hintText, // Hint/placeholder text inside the field
  int maxLines = 1, // Number of lines (default: 1, can be multi-line)
  bool obscureText = false, // If true → hides text (useful for passwords)
  String? Function(String?)? validator, // Validation function for forms
  TextInputType keyboardType =
      TextInputType.text, // Keyboard type (text, email, number, etc.)
  Widget? prefixIcon, // Optional icon shown at the start of the input
  Widget? suffixIcon, // Optional icon shown at the end of the input
  Color fillColor = const Color.fromARGB(
    255,
    254,
    254,
    255,
  ), // Background color
  Color borderColor = const Color(
    0xFF6A1B9A,
  ), // Default purple-ish border color

  double textFontSize = 14, // NEW: input text size
  double labelFontSize = 12, // NEW: label size
  bool alwaysShowLabel = true, // NEW: keep label floated
  bool topAlign = true, // NEW: align text to top (useful for multi-line)
}) {
  return TextFormField(
    controller: controller, // Connects field to controller
    maxLines: obscureText ? 1 : maxLines, // If password, force single line
    obscureText: obscureText, // Hides text if true
    validator: validator, // Runs validation when form is submitted
    keyboardType: keyboardType, // Defines the type of keyboard
    style: TextStyle(fontSize: textFontSize),
    textAlignVertical: topAlign ? TextAlignVertical.top : null,
    decoration: InputDecoration(
      isDense: true,
      // labelText: label,
      labelStyle: TextStyle(fontSize: labelFontSize, color: Colors.grey[700]),
      floatingLabelStyle: TextStyle(
        fontSize: labelFontSize,
        fontWeight: FontWeight.w600,
        color: borderColor,
      ),
      floatingLabelBehavior:
          alwaysShowLabel
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
      hintText: hintText,
      filled: true,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: topAlign ? 12 : 14, // smaller padding
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor.withOpacity(.4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor.withOpacity(.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    ),
  );
}

Widget createTaskButton(VoidCallback onPressed, {bool fullWidth = false}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: purple, // was white
        foregroundColor: Colors.white, // was purple
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text(
        'Create Task',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
      onDaySelected: (sel, foc) {
        setState(() {
          _selectedDay = sel;
          _focusedDay = foc;
        });
      },
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
      weekNumbersVisible: true, // shows the left column like in your image
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: purple.withOpacity(.25),
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: purple,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        weekendTextStyle: const TextStyle(color: purple),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: purple),
      ),
    );
  }
}

Widget iconBtn(IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}

String dateLabel(DateTime d) {
  const m = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${d.day} ${m[d.month - 1]}';
}

Widget taskTile({
  required String taskName,
  required bool taskCompleted,
  required String time,
  required String subtitle,
  required ValueChanged<bool> onChanged,
  required VoidCallback onDelete,
}) {
  return Slidable(
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => onDelete(),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,

          borderRadius: BorderRadius.circular(12),
          icon: Icons.delete,
          // label: 'Delete',
        ),
      ],
    ),
    child: InkWell(
      onTap: () => onChanged(!taskCompleted),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:
              taskCompleted ? purple.withOpacity(.08) : const Color(0xFFF4EEFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: taskCompleted ? purple : Colors.transparent,
          ),
        ),

        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: taskCompleted ? purple : Colors.black,
                      decoration:
                          taskCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: taskCompleted,
              activeColor: purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    ),
  );
}

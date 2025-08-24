class Task {
  final String time;
  final String title;
  final String subtitle;
  final bool done;
  const Task({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.done,
  });

  Task copyWith({bool? done}) => Task(
    time: time,
    title: title,
    subtitle: subtitle,
    done: done ?? this.done,
  );
}

// Combined sample data (replace old separate lists)
final List<Task> sampleTasks = [
  const Task(
    time: '6:00 - 7:30',
    title: 'Fitness',
    subtitle: 'Exercise and gym',
    done: true,
  ),
  const Task(
    time: '7:30 - 8:00',
    title: 'Check Emails and sms',
    subtitle: 'Review and respond to emails and SMS',
    done: true,
  ),
  const Task(
    time: '8:00 - 10:00',
    title: 'Work on Projects',
    subtitle: 'Focus on project tasks',
    done: true,
  ),
  const Task(
    time: '10:00 - 11:00',
    title: 'Attend Meeting',
    subtitle: 'Client meeting (ABC)',
    done: false,
  ),
  const Task(
    time: '11:00 - 13:00',
    title: 'Work of XYZ',
    subtitle: 'Change theme and ideas',
    done: false,
  ),
  const Task(
    time: '13:00 - 14:30',
    title: 'Lunch Break',
    subtitle: 'Healthy lunch & rest',
    done: false,
  ),
  const Task(
    time: '11:00 - 13:00',
    title: 'Work of XYZ',
    subtitle: 'Change theme and ideas',
    done: false,
  ),
  const Task(
    time: '13:00 - 14:30',
    title: 'Lunch Break',
    subtitle: 'Healthy lunch & rest',
    done: false,
  ),
];

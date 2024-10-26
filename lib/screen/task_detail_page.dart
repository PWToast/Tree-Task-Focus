class TaskDetailPage {
  TaskDetailPage(
      {required this.taskName,
      required this.hour,
      required this.minute,
      required this.second});
  String taskName;
  String hour;
  String minute;
  String second;
}

List<TaskDetailPage> tasks = [
  TaskDetailPage(
      taskName: "อ่านหนังสือ", hour: '0', minute: '01', second: '00'),
  TaskDetailPage(
      taskName: "งมหอยในมหาสมุทร", hour: '8', minute: '00', second: '00'),
];

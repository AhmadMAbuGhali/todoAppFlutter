import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';

class TaskController   extends GetxController {

  final taskList  = <Task>[

    Task(            title: 'Title1',
      note: 'Note Something',
      isCompleted: 0,
      startTime: DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 1))),
      color: 2,
    ),

  ];

  getTask(){

  }
}

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../theme.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selecteddate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 6,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => ThemeServices().switchTheme(),
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: subHeadingStyle,
              ),
              Text(
                'Todat',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTask();
            },
          )
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 65,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        )),
        onDateChange: (newDate) {
          setState(() {
            _selecteddate = newDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(child: _noTaskMsg());
    // Obx(() {
    //   //_taskController.taskList.isEmpty
    //   if (true){
    //       return _noTaskMsg();
    //   }else{
    //    return Container(
    //       height: 0,
    //     );
    //   }
    //
    // })
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ?Axis.horizontal:Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(height: 6)
                    : const SizedBox(height: 220),

                SvgPicture.asset(
                  'images/task.svg',
                  height: 90,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(0.5),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    'You do not have any tasks yet! \n Add new tasks to make your days productive',
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(height: 120)
                    : const SizedBox(height: 180),

              ],
            ),
          ),
        )
      ],
    );
  }
}

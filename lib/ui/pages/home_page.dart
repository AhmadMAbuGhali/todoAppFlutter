import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyButton(label: 'Add Task',onTap: (){
              Get.to(const AddTaskPage() );
            },),
            const InputField(title: 'title',hint: 'Enter Something',widget: Icon(Icons.access_alarm),)
          ],
        ),
      ),
    );
  }
  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () =>ThemeServices().switchTheme(),
        icon:  Icon(
          Get.isDarkMode?
          Icons.wb_sunny_outlined:
          Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ?Colors.white:darkGreyClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}

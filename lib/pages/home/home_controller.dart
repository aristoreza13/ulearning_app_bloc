import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/pages/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_events.dart';

class HomeController {
  final BuildContext context;
  HomeController({required this.context});
  UserItem? userProfile = Global.storageService.getUserProfile();

  void init() async {
    print("Home controller initializing..");
    // check if userProfile is valid or not

    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      print("valid");
      print(result.data!);
      //trigger event
      context.read<HomeBlocs>().add(HomePageCourseItem(result.data!));
    } else {
      print(result.code);
    }
  }
}

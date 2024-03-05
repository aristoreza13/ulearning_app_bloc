import 'package:ulearning_app/common/entities/course.dart';

class HomeStates {
  //when triggered, initialize variable
  const HomeStates({
    this.index = 0,
    this.courseItem = const <CourseItem>[],
  });

  final int index;
  final List<CourseItem> courseItem;

  HomeStates copyWith({int? index, List<CourseItem>? courseItem}) {
    return HomeStates(
      courseItem:
          courseItem ?? this.courseItem, // if exist, course item. else this
      index: index ?? this.index,
    );
  }
}

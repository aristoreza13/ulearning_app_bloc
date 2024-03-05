import '../../../common/entities/course.dart';

abstract class HomeEvents {
  const HomeEvents();
}

class HomePageDots extends HomeEvents {
  // Grab the value from states class
  final int index;

  HomePageDots(this.index);
}

// new event to show list course
class HomePageCourseItem extends HomeEvents {
  const HomePageCourseItem(this.courseItem);
  final List<CourseItem> courseItem;
}

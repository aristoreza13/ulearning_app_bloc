abstract class HomeEvents {
  const HomeEvents();
}

class HomePageDots extends HomeEvents {
  // Grab the value from states class
  final int index;

  HomePageDots(this.index);
}

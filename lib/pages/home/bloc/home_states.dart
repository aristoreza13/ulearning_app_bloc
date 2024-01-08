class HomeStates {
  final int index;
  const HomeStates({
    this.index = 0,
  });

  HomeStates copyWith({int? index}) {
    return HomeStates(
      index: index ?? this.index,
    );
  }
}

abstract class AppEvent {
  const AppEvent();
}

class TriggerAppEvent extends AppEvent {
  // get a value to save to AppState
  final int index;
  const TriggerAppEvent(this.index) : super();
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_states.dart';

class HomeBlocs extends Bloc<HomeEvents, HomeStates> {
  HomeBlocs() : super(const HomeStates()) {
    on<HomePageDots>(homePageDots);
  }

  void homePageDots(HomePageDots event, Emitter<HomeStates> emit) {
    emit(state.copyWith(index: event.index));
  }
}

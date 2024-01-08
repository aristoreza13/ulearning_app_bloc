import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_events.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_states.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingStates> {
  SettingsBlocs() : super(SettingStates()) {
    on<TriggerSettings>(triggerSettings);
  }

  triggerSettings(SettingsEvents event, Emitter<SettingStates> emit) {
    emit(const SettingStates());
  }
}

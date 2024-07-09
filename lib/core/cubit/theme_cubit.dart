import 'package:book_catalog/core/services/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());
  initTheme() async {
    emit(state.copyWith(darkTheme: SharedPreferencesService.getTheme()));
  }

  changeTheme() async {
    await SharedPreferencesService.setTheme(!state.darkTheme);
    emit(state.copyWith(darkTheme: !state.darkTheme));
  }
}

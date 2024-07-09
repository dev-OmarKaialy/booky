part of 'theme_cubit.dart';

class ThemeState {
  final bool darkTheme;
  ThemeState({
    this.darkTheme = false,
  });

  ThemeState copyWith({
    bool? darkTheme,
  }) {
    return ThemeState(
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }
}

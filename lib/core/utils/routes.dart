import 'package:flutter/material.dart';
import 'package:visual_notes/core/screens/splash_screen.dart';
import 'package:visual_notes/general/screens/language_screen.dart';
import 'package:visual_notes/general/screens/settings_screen.dart';
import 'package:visual_notes/modules/add_edit_note/screens/add_edit_note_screen.dart';
import 'package:visual_notes/modules/home/screens/visual_notes_screen.dart';

class RoutePaths {
  static const coreSplash = '/';
  static const home = '/home';
  static const addEditNote = '/add_edit_note';
  static const settings = '/settings';
  static const settingsLanguage = '/settings/language';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Core
      case RoutePaths.coreSplash:
        return MaterialPageRoute(builder: (_) => const Splash());

      //Settings
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RoutePaths.settingsLanguage:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      //Home
      case RoutePaths.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => VisualNotesScreen(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(seconds: 1),
        );
      case RoutePaths.addEditNote:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) =>
              AddEditNoteScreen(visualNoteModel: args['visualNoteModel']),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}

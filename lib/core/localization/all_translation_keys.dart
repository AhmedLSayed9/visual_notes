import 'package:get/get.dart';
import 'package:visual_notes/core/localization/ar.dart';
import 'package:visual_notes/core/localization/en.dart';
import 'package:visual_notes/general/localization/en.dart';
import 'package:visual_notes/general/localization/ar.dart';
import 'package:visual_notes/modules/add_edit_note/localization/en.dart';
import 'package:visual_notes/modules/add_edit_note/localization/ar.dart';
import 'package:visual_notes/modules/home/localization/en.dart';
import 'package:visual_notes/modules/home/localization/ar.dart';

class LanguageTranslation extends Translations {
  Map<String, String> en = coreEn;
  Map<String, String> ar = coreAr;

  LanguageTranslation() {
    en
      ..addAll(generalEn)
      ..addAll(notesEn)
      ..addAll(addEditNoteEn);
    ar
      ..addAll(generalAr)
      ..addAll(notesAr)
      ..addAll(addEditNoteAr);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}

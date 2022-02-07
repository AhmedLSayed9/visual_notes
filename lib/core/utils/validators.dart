import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:visual_notes/core/localization/app_localization.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  String? validateInteger(String? value) {
    if (value!.isEmpty) {
      return tr("ThisFieldIsEmpty");
    } else if (!value.isNumericOnly) {
      return tr("pleaseEnterOnlyNumericValues");
    } else if (value.toString().length > 30) {
      return tr("idMustBeAtMost30Numbers");
    }
  }

  String? validateTitle(String? value) {
    if (value!.isEmpty) {
      return tr("ThisFieldIsEmpty");
    } else if (value.toString().length > 30) {
      return tr("titleMustBeAtMost30Letters");
    }
  }

  String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return tr("ThisFieldIsEmpty");
    }
  }
}

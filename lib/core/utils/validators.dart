import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:visual_notes/core/localization/app_localization.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  String? Function(String?)? validateInteger() {
    return (value) {
      if (value!.isEmpty) {
        return tr("ThisFieldIsEmpty");
      } else if (!value.isNumericOnly) {
        return tr("pleaseEnterOnlyNumericValues");
      } else if (value.toString().length > 30) {
        return tr("idMustBeAtMost30Numbers");
      }
    };
  }

  String? Function(String?)? validateTitle() {
    return (value) {
      if (value!.isEmpty) {
        return tr("ThisFieldIsEmpty");
      } else if (value.toString().length > 30) {
        return tr("titleMustBeAtMost30Letters");
      }
    };
  }

  String? Function(String?)? validateDescription() {
    return (value) {
      if (value!.isEmpty) {
        return tr("ThisFieldIsEmpty");
      }
    };
  }
}

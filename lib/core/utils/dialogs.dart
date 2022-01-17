import 'package:get/get.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/utils/dialog_message_state.dart';
import 'package:visual_notes/core/services/navigation_service.dart';
import 'package:visual_notes/core/widgets/dialog_widget.dart';

class AppDialogs {
  static Future showDefaultErrorDialog() async {
    await DialogWidget.showCustomDialog(
      context: Get.context!,
      dialogWidgetState: DialogWidgetState.error,
      title: tr('oops'),
      description: tr('somethingWentWrong') + '\n' + tr('pleaseTryAgainLater'),
      textButton: tr('OK'),
      onPressed: () {
        NavigationService.goBack();
      },
    );
  }
}

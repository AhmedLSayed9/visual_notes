import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/utils/dialogs.dart';

class ImageSelector {
  ImageSelector._();

  static final instance = ImageSelector._();

  static String? _appDocDirPath;

  Future<String> get appDocDir async {
    if (_appDocDirPath != null) return _appDocDirPath!;
    _appDocDirPath = await getAppDocDir();
    return _appDocDirPath!;
  }

  getAppDocDir() async {
    final _appDocDir = await getApplicationDocumentsDirectory();
    return _appDocDir.path;
  }

  Future<File?>? pickImage({required bool fromCamera}) async {
    try {
      final _pickedFile = await ImagePicker().pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: Sizes.pickedImageMaxSize,
        maxWidth: Sizes.pickedImageMaxSize,
      );
      if (_pickedFile != null) {
        return File(_pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
      return null;
    }
  }

  Future<String?>? saveImageLocally({
    required File imageFile,
    String? fileName,
  }) async {
    try {
      final _appDocDir = await appDocDir;
      fileName == null ? basename(imageFile.path) : fileName += '.jpg';
      final _savedImage = await imageFile.copy('$_appDocDir/$fileName');
      return _savedImage.path;
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
      return null;
    }
  }

  Future deleteImageLocally({
    required File imageFile,
  }) async {
    try {
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  clearImageCache() {
    imageCache!.clear();
    imageCache!.clearLiveImages();
  }
}
